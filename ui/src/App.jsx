import React, { useState, useEffect, useMemo } from 'react';
import RetroHeader from './components/RetroHeader';
import PresetSelector from './components/PresetSelector';
import DualCodeEditor from './components/DualCodeEditor';
import ProjectFolderSelector from './components/ProjectFolderSelector';
import VintageTerminal from './components/VintageTerminal';
import DivergenceInspector from './components/DivergenceInspector';
import DownloadManager from './components/DownloadManager';
import HarnessModal from './components/HarnessModal';
import RetroStatusBar from './components/RetroStatusBar';

export const detectPointersInCCode = (cSource) => {
  if (!cSource || typeof cSource !== 'string') return false;
  const funcPattern = /\b(?:[a-zA-Z_]\w*[\s*]+)+\b([a-zA-Z_]\w*)\s*\(([^)]*)\)\s*\{/g;
  let match;
  while ((match = funcPattern.exec(cSource)) !== null) {
    const fname = match[1];
    const params = match[2];
    if (fname === 'main') continue;
    if (params.includes('*')) {
      return true;
    }
  }
  return false;
};

export default function App() {
  // Theme and CRT effect state
  const [theme, setTheme] = useState('borland');
  const [scanlines, setScanlines] = useState(true);

  // Input Mode: 'editor' (raw code) or 'folders' (2 project directories)
  const [inputMode, setInputMode] = useState('editor');

  // Benchmarks & Preset selection
  const [presets, setPresets] = useState([]);
  const [selectedPresetId, setSelectedPresetId] = useState('');

  // Folder Mode State
  const [cDirectories, setCDirectories] = useState([]);
  const [rustDirectories, setRustDirectories] = useState([]);
  const [cPath, setCPath] = useState('tests/fixtures/01_global_state_divergence/c');
  const [rustPath, setRustPath] = useState('tests/fixtures/01_global_state_divergence/rust_buggy/src');
  const [cFilesUploaded, setCFilesUploaded] = useState(null);
  const [rustFilesUploaded, setRustFilesUploaded] = useState(null);
  const [includeDir, setIncludeDir] = useState('');

  // Code editors state
  const [cCode, setCCode] = useState('');
  const [rustCode, setRustCode] = useState('');

  // Live auto-detection of pointer parameters in C code
  const detectedPointers = useMemo(() => {
    if (inputMode === 'editor') {
      return detectPointersInCCode(cCode);
    }
    if (cFilesUploaded && Array.isArray(cFilesUploaded)) {
      return cFilesUploaded.some((f) => detectPointersInCCode(f.content));
    }
    return false;
  }, [inputMode, cCode, cFilesUploaded]);

  // Execution state
  const [isRunning, setIsRunning] = useState(false);
  const [activeStage, setActiveStage] = useState(0);
  const [log, setLog] = useState('');
  const [results, setResults] = useState([]);
  const [allEquivalent, setAllEquivalent] = useState(false);
  const [overallVerdict, setOverallVerdict] = useState('');
  const [runId, setRunId] = useState(null);
  const [summary, setSummary] = useState(null);

  // Solver & System status
  const [solverStatus, setSolverStatus] = useState(null);

  // Harness Modal state
  const [harnessModalOpen, setHarnessModalOpen] = useState(false);
  const [harnessData, setHarnessData] = useState(null);

  // Set theme data-attribute on document root
  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
  }, [theme]);

  // Fetch status and fixtures on mount
  useEffect(() => {
    fetch('/api/status')
      .then((res) => res.json())
      .then((data) => {
        if (data && data.solvers) {
          setSolverStatus(data.solvers);
        }
      })
      .catch((err) => console.error("Error fetching solver status:", err));

    fetch('/api/fixtures')
      .then((res) => res.json())
      .then((data) => {
        if (data.presets) {
          setPresets(data.presets);
          if (data.presets.length > 0) {
            const initial = data.presets[0];
            setSelectedPresetId(initial.id);
            setCCode(initial.c_code);
            setRustCode(initial.rust_code);
          }
        }
        if (data.c_directories) {
          setCDirectories(data.c_directories);
          if (data.c_directories.length > 0) {
            setCPath(data.c_directories[0].path);
          }
        }
        if (data.rust_directories) {
          setRustDirectories(data.rust_directories);
          if (data.rust_directories.length > 0) {
            setRustPath(data.rust_directories[0].path);
          }
        }
      })
      .catch((err) => console.error("Error fetching fixtures:", err));
  }, []);

  // Global hotkeys (F9 to run verification, Esc to close modal)
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'F9' || (e.ctrlKey && e.key === 'Enter')) {
        e.preventDefault();
        if (!isRunning) {
          handleRunVerification();
        }
      } else if (e.key === 'Escape') {
        setHarnessModalOpen(false);
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [inputMode, cCode, rustCode, cPath, rustPath, cFilesUploaded, rustFilesUploaded, isRunning]);

  // Handle Preset selection in editor mode
  const handleSelectPreset = (presetId) => {
    setSelectedPresetId(presetId);
    const found = presets.find((p) => p.id === presetId);
    if (found) {
      setCCode(found.c_code);
      setRustCode(found.rust_code);
      setLog(`[Preset Loaded] ${found.title}\n${found.description}\nExpected Verdict: ${found.expected_verdict}\n`);
    }
  };

  // Reset inputs
  const handleReset = () => {
    if (inputMode === 'editor') {
      setCCode('');
      setRustCode('');
      setSelectedPresetId('');
    } else {
      setCPath('');
      setRustPath('');
      setCFilesUploaded(null);
      setRustFilesUploaded(null);
    }
    setResults([]);
    setLog('[Workspace Reset] Ready for new input.');
  };

  // Run Equivalence Verification
  const handleRunVerification = async () => {
    // Validate inputs based on mode
    let requestPayload = { pointer_mode: 'auto' };

    if (inputMode === 'editor') {
      if (!cCode.trim() || !rustCode.trim()) {
        alert("Please provide both C source code and Rust source code before running verification.");
        return;
      }
      requestPayload.c_code = cCode;
      requestPayload.rust_code = rustCode;
    } else {
      // Folder mode
      if (cFilesUploaded && rustFilesUploaded) {
        requestPayload.c_files = cFilesUploaded;
        requestPayload.rust_files = rustFilesUploaded;
      } else if (cPath && rustPath) {
        requestPayload.c_path = cPath;
        requestPayload.rust_path = rustPath;
        if (includeDir.trim()) {
          requestPayload.include_dir = includeDir.trim();
        }
      } else {
        alert("Please specify both a C project directory and a Rust project directory (or upload folders) before running verification.");
        return;
      }
    }

    setIsRunning(true);
    setActiveStage(1);
    setResults([]);
    setLog("==============================================================================\n" +
           "  RustSketch: Inter-Procedural Semantic Equivalence Validation Framework\n" +
           "  [Powered by Clang, rustc, llvm-link, angr, and Z3 Theorem Prover]\n" +
           "==============================================================================\n\n" +
           (inputMode === 'folders'
             ? `[*] Target C Project   : ${cPath}\n[*] Target Rust Project: ${rustPath}\n`
             : `[*] Comparing In-Memory C and Rust Programs...\n`) +
           "[*] Stage 1: Validating Project Source Trees & Syntax...\n");

    const stageTimer1 = setTimeout(() => {
      setActiveStage(2);
      setLog((prev) => prev + "[*] Stage 2: Compiling C Bitcode & Instrumenting Rust to LLVM IR...\n");
    }, 400);

    const stageTimer2 = setTimeout(() => {
      setActiveStage(3);
      setLog((prev) => prev + "[*] Stage 3: Extracting Call-Graph Hierarchy & Modular Separation...\n");
    }, 900);

    const stageTimer3 = setTimeout(() => {
      setActiveStage(4);
      setLog((prev) => prev + "[*] Stage 4: angr Symbolic Execution & Summary Repository Synthesis...\n");
    }, 1500);

    const stageTimer4 = setTimeout(() => {
      setActiveStage(5);
      setLog((prev) => prev + "[*] Stage 5: Formulating Z3 SMT Difference Queries (Summary_C != Summary_Rust)...\n");
    }, 2200);

    try {
      const response = await fetch('/api/verify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(requestPayload)
      });

      const data = await response.json();
      clearTimeout(stageTimer1);
      clearTimeout(stageTimer2);
      clearTimeout(stageTimer3);
      clearTimeout(stageTimer4);

      if (data.success) {
        setActiveStage(6);
        setResults(data.results || []);
        setAllEquivalent(data.all_equivalent);
        setOverallVerdict(data.overall_verdict);
        setRunId(data.run_id);
        setSummary(data.summary);
        setLog(data.log || "Verification completed.");
      } else {
        setActiveStage(0);
        setLog(data.log || `[ERROR] ${data.error || "Verification failed"}`);
        alert(`Verification Error: ${data.error}`);
      }
    } catch (err) {
      clearTimeout(stageTimer1);
      clearTimeout(stageTimer2);
      clearTimeout(stageTimer3);
      clearTimeout(stageTimer4);
      setActiveStage(0);
      setLog((prev) => prev + `\n[NETWORK ERROR] Failed to communicate with RustSketch server: ${err.message}`);
    } finally {
      setIsRunning(false);
    }
  };

  // Generate Reproducer Harness for a given function
  const handleGenerateHarness = async (result) => {
    try {
      const response = await fetch('/api/generate-harness', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          function_name: result.function,
          counterexample: result.counterexample || {},
          c_outputs: result.c_outputs || {},
          rust_outputs: result.rust_outputs || {}
        })
      });
      const data = await response.json();
      setHarnessData(data);
      setHarnessModalOpen(true);
    } catch (err) {
      alert("Failed to generate reproducer harness: " + err.message);
    }
  };

  // Download Reproducers for the first divergent function
  const handleDownloadReproducers = () => {
    const divergent = results.find((r) => !r.equivalent);
    if (divergent) {
      handleGenerateHarness(divergent);
    }
  };

  // Download log helper
  const handleDownloadLog = () => {
    const dataStr = "data:text/plain;charset=utf-8," + encodeURIComponent(log || '');
    const downloadAnchor = document.createElement('a');
    downloadAnchor.setAttribute("href", dataStr);
    downloadAnchor.setAttribute("download", `rustsketch_divergence_${runId || 'latest'}.log`);
    document.body.appendChild(downloadAnchor);
    downloadAnchor.click();
    downloadAnchor.remove();
  };

  return (
    <div className="app-container">
      {/* CRT Scanlines and Vignette Effect */}
      {scanlines && (
        <>
          <div className="crt-overlay" />
          <div className="crt-vignette" />
        </>
      )}

      {/* Retro Top Menubar */}
      <RetroHeader
        theme={theme}
        setTheme={setTheme}
        scanlines={scanlines}
        setScanlines={setScanlines}
        onRunVerification={handleRunVerification}
        isRunning={isRunning}
        solverStatus={solverStatus}
      />

      {/* Preset & Mode Switcher Toolbar */}
      <PresetSelector
        inputMode={inputMode}
        setInputMode={setInputMode}
        presets={presets}
        selectedPresetId={selectedPresetId}
        onSelectPreset={handleSelectPreset}
        detectedPointers={detectedPointers}
        onResetCode={handleReset}
        isRunning={isRunning}
      />

      {/* Mode 1: Dual Code Editors (C vs Rust) */}
      {inputMode === 'editor' && (
        <DualCodeEditor
          cCode={cCode}
          setCCode={setCCode}
          rustCode={rustCode}
          setRustCode={setRustCode}
          detectedPointers={detectedPointers}
          isRunning={isRunning}
        />
      )}

      {/* Mode 2: Project Folders Comparator */}
      {inputMode === 'folders' && (
        <ProjectFolderSelector
          cDirectories={cDirectories}
          rustDirectories={rustDirectories}
          cPath={cPath}
          setCPath={setCPath}
          rustPath={rustPath}
          setRustPath={setRustPath}
          cFilesUploaded={cFilesUploaded}
          setCFilesUploaded={setCFilesUploaded}
          rustFilesUploaded={rustFilesUploaded}
          setRustFilesUploaded={setRustFilesUploaded}
          detectedPointers={detectedPointers}
          includeDir={includeDir}
          setIncludeDir={setIncludeDir}
          onRunVerification={handleRunVerification}
          isRunning={isRunning}
        />
      )}

      {/* CRT Terminal Output Stream */}
      <VintageTerminal
        log={log}
        isRunning={isRunning}
        activeStage={activeStage}
        onClearLog={() => setLog('')}
        onDownloadLog={handleDownloadLog}
      />

      {/* Divergence Inspector & Counter-Example Visualizer */}
      <DivergenceInspector
        results={results}
        overallVerdict={overallVerdict}
        allEquivalent={allEquivalent}
        isRunning={isRunning}
        onGenerateHarness={handleGenerateHarness}
      />

      {/* Direct Download & Export Manager */}
      <DownloadManager
        runId={runId}
        results={results}
        log={log}
        allEquivalent={allEquivalent}
        summary={summary}
        onDownloadReproducers={handleDownloadReproducers}
      />

      {/* Standalone Reproducer Modal */}
      <HarnessModal
        isOpen={harnessModalOpen}
        onClose={() => setHarnessModalOpen(false)}
        harnessData={harnessData}
      />

      {/* Bottom Vintage Status Bar */}
      <RetroStatusBar
        cCode={cCode}
        rustCode={rustCode}
        isRunning={isRunning}
        solverStatus={solverStatus}
        allEquivalent={allEquivalent}
        hasResults={results.length > 0}
      />
    </div>
  );
}
