import React, { useState, useEffect, useRef } from 'react';
import { Folder, FolderCheck, Upload, ArrowRight, FileCode, Search, CheckCircle2, AlertCircle, RefreshCw, Sparkles, Cpu } from 'lucide-react';

export default function ProjectFolderSelector({
  cDirectories = [],
  rustDirectories = [],
  cPath,
  setCPath,
  rustPath,
  setRustPath,
  cFilesUploaded,
  setCFilesUploaded,
  rustFilesUploaded,
  setRustFilesUploaded,
  detectedPointers,
  includeDir,
  setIncludeDir,
  onRunVerification,
  isRunning
}) {
  const [cInspection, setCInspection] = useState(null);
  const [rustInspection, setRustInspection] = useState(null);
  const [cDragging, setCDragging] = useState(false);
  const [rustDragging, setRustDragging] = useState(false);

  const cFolderInputRef = useRef(null);
  const rustFolderInputRef = useRef(null);

  // Inspect C folder whenever cPath changes
  useEffect(() => {
    if (!cPath) {
      setCInspection(null);
      return;
    }
    fetch(`/api/inspect-dir?path=${encodeURIComponent(cPath)}`)
      .then(res => res.json())
      .then(data => setCInspection(data))
      .catch(() => setCInspection({ error: "Folder not accessible" }));
  }, [cPath]);

  // Inspect Rust folder whenever rustPath changes
  useEffect(() => {
    if (!rustPath) {
      setRustInspection(null);
      return;
    }
    fetch(`/api/inspect-dir?path=${encodeURIComponent(rustPath)}`)
      .then(res => res.json())
      .then(data => setRustInspection(data))
      .catch(() => setRustInspection({ error: "Folder not accessible" }));
  }, [rustPath]);

  // Handle folder upload from local computer
  const handleFolderUpload = (e, setFilesState, setPathState) => {
    const files = Array.from(e.target.files || []);
    if (files.length === 0) return;

    const filePromises = files.map(file => {
      return new Promise((resolve) => {
        const reader = new FileReader();
        reader.onload = (evt) => {
          resolve({
            path: file.webkitRelativePath || file.name,
            content: evt.target.result
          });
        };
        reader.readAsText(file);
      });
    });

    Promise.all(filePromises).then(results => {
      setFilesState(results);
      // Derive folder name
      const folderName = files[0].webkitRelativePath ? files[0].webkitRelativePath.split('/')[0] : 'Uploaded Folder';
      setPathState(`[Uploaded: ${folderName}]`);
    });
    e.target.value = '';
  };

  return (
    <div className="retro-window" style={{ margin: '10px 14px' }}>
      <div className="window-titlebar">
        <div className="titlebar-text">
          <Folder size={14} color="var(--text-highlight)" />
          <span>PROJECT FOLDER EQUIVALENCE COMPARATOR // DIRECTORY MODE</span>
        </div>
        <span style={{ fontSize: '11px', color: 'var(--text-accent)' }}>
          {cFilesUploaded?.length ? `C: ${cFilesUploaded.length} UPLOADED` : cInspection?.total_c ? `C: ${cInspection.total_c} .C FILES` : 'C: SELECT FOLDER'} |{' '}
          {rustFilesUploaded?.length ? `RUST: ${rustFilesUploaded.length} UPLOADED` : rustInspection?.total_rs ? `RUST: ${rustInspection.total_rs} .RS FILES` : 'RUST: SELECT FOLDER'}
        </span>
      </div>

      <div style={{ padding: '12px' }}>
        <div style={{ fontSize: '11px', color: 'var(--text-muted)', marginBottom: '12px' }}>
          Select or enter paths to your **original C project directory** and **transpiled Rust project directory**.
          RustSketch will discover all `.c`, `.h`, and `.rs` source files, link them with Clang and LLVM, and formally check equivalence using angr and Z3.
        </div>

        <div className="editors-grid" style={{ padding: 0, gap: '14px' }}>
          {/* C Project Directory Card */}
          <div
            className="witness-block"
            style={{ padding: '12px' }}
            onDragOver={(e) => { e.preventDefault(); setCDragging(true); }}
            onDragLeave={() => setCDragging(false)}
            onDrop={(e) => {
              e.preventDefault();
              setCDragging(false);
              const files = Array.from(e.dataTransfer.files || []);
              if (files.length) {
                const filePromises = files.map(file => new Promise(res => {
                  const r = new FileReader();
                  r.onload = ev => res({ path: file.name, content: ev.target.result });
                  r.readAsText(file);
                }));
                Promise.all(filePromises).then(res => {
                  setCFilesUploaded(res);
                  setCPath('[Dropped Folder Files]');
                });
              }
            }}
          >
            <div className="witness-title">
              <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                <FolderCheck size={13} color="var(--text-accent)" />
                ORIGINAL C PROJECT DIRECTORY
              </span>
              <span style={{ fontSize: '10px', color: 'var(--text-muted)' }}>[INPUT C FOLDER]</span>
            </div>

            {/* C Directory Dropdown */}
            <div style={{ marginBottom: '10px' }}>
              <label style={{ fontSize: '11px', fontWeight: 'bold', display: 'block', marginBottom: '4px', color: 'var(--text-highlight)' }}>
                1. Select from Workspace Dropdown:
              </label>
              <select
                className="retro-select"
                style={{ width: '100%' }}
                value={cPath || ''}
                onChange={(e) => {
                  setCPath(e.target.value);
                  setCFilesUploaded(null);
                }}
                disabled={isRunning}
              >
                <option value="">-- Choose a C Source Folder in Workspace --</option>
                {cDirectories.map((dir, idx) => (
                  <option key={idx} value={dir.path}>
                    {dir.name} ({dir.c_files?.length || 0} .c files, {dir.h_files?.length || 0} .h headers)
                  </option>
                ))}
              </select>
            </div>

            {/* Custom Path Input */}
            <div style={{ marginBottom: '10px' }}>
              <label style={{ fontSize: '11px', fontWeight: 'bold', display: 'block', marginBottom: '4px', color: 'var(--text-highlight)' }}>
                2. Or Type Custom Folder Path:
              </label>
              <div style={{ display: 'flex', gap: '6px' }}>
                <input
                  type="text"
                  className="code-textarea"
                  style={{ height: '32px', padding: '6px 8px', width: '100%', border: '1px solid var(--border-editor)' }}
                  placeholder="e.g. tests/fixtures/01_global_state_divergence/c or /home/hari/..."
                  value={cPath}
                  onChange={(e) => {
                    setCPath(e.target.value);
                    setCFilesUploaded(null);
                  }}
                  disabled={isRunning}
                />
                <input
                  type="file"
                  ref={cFolderInputRef}
                  webkitdirectory=""
                  directory=""
                  multiple
                  style={{ display: 'none' }}
                  onChange={(e) => handleFolderUpload(e, setCFilesUploaded, setCPath)}
                />
                <button
                  className="retro-btn small"
                  onClick={() => cFolderInputRef.current?.click()}
                  title="Upload folder from local machine"
                  disabled={isRunning}
                >
                  <Upload size={12} />
                  <span>UPLOAD</span>
                </button>
              </div>
            </div>

            {/* Inspection Preview */}
            <div style={{ background: 'var(--bg-card)', padding: '8px', border: '1px solid var(--border-editor)', fontSize: '11px' }}>
              <div style={{ fontWeight: 'bold', color: 'var(--text-accent)', marginBottom: '4px' }}>
                Found Files in C Folder:
              </div>
              {cFilesUploaded ? (
                <div style={{ color: 'var(--text-green)' }}>
                  ✓ {cFilesUploaded.length} file(s) uploaded into temporary workspace
                </div>
              ) : cInspection?.c_files?.length ? (
                <div>
                  <div style={{ color: 'var(--text-green)', marginBottom: '2px' }}>
                    ✓ {cInspection.total_c} .c source(s), {cInspection.total_h} header(s)
                  </div>
                  <div style={{ color: 'var(--text-muted)', fontSize: '10.5px' }}>
                    Files: {cInspection.c_files.concat(cInspection.h_files).join(', ')}
                  </div>
                </div>
              ) : cInspection?.error ? (
                <div style={{ color: 'var(--text-red)' }}>⚠ {cInspection.error}</div>
              ) : (
                <div style={{ color: 'var(--text-muted)' }}>No folder chosen or empty directory.</div>
              )}
            </div>
          </div>

          {/* Rust Project Directory Card */}
          <div
            className="witness-block"
            style={{ padding: '12px' }}
            onDragOver={(e) => { e.preventDefault(); setRustDragging(true); }}
            onDragLeave={() => setRustDragging(false)}
            onDrop={(e) => {
              e.preventDefault();
              setRustDragging(false);
              const files = Array.from(e.dataTransfer.files || []);
              if (files.length) {
                const filePromises = files.map(file => new Promise(res => {
                  const r = new FileReader();
                  r.onload = ev => res({ path: file.name, content: ev.target.result });
                  r.readAsText(file);
                }));
                Promise.all(filePromises).then(res => {
                  setRustFilesUploaded(res);
                  setRustPath('[Dropped Folder Files]');
                });
              }
            }}
          >
            <div className="witness-title">
              <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                <FolderCheck size={13} color="var(--text-highlight)" />
                TRANSPILED RUST PROJECT DIRECTORY
              </span>
              <span style={{ fontSize: '10px', color: 'var(--text-muted)' }}>[INPUT RUST FOLDER]</span>
            </div>

            {/* Rust Directory Dropdown */}
            <div style={{ marginBottom: '10px' }}>
              <label style={{ fontSize: '11px', fontWeight: 'bold', display: 'block', marginBottom: '4px', color: 'var(--text-highlight)' }}>
                1. Select from Workspace Dropdown:
              </label>
              <select
                className="retro-select"
                style={{ width: '100%' }}
                value={rustPath || ''}
                onChange={(e) => {
                  setRustPath(e.target.value);
                  setRustFilesUploaded(null);
                }}
                disabled={isRunning}
              >
                <option value="">-- Choose a Rust Source Folder in Workspace --</option>
                {rustDirectories.map((dir, idx) => (
                  <option key={idx} value={dir.path}>
                    {dir.name} ({dir.rs_files?.length || 0} .rs source files)
                  </option>
                ))}
              </select>
            </div>

            {/* Custom Path Input */}
            <div style={{ marginBottom: '10px' }}>
              <label style={{ fontSize: '11px', fontWeight: 'bold', display: 'block', marginBottom: '4px', color: 'var(--text-highlight)' }}>
                2. Or Type Custom Folder Path:
              </label>
              <div style={{ display: 'flex', gap: '6px' }}>
                <input
                  type="text"
                  className="code-textarea"
                  style={{ height: '32px', padding: '6px 8px', width: '100%', border: '1px solid var(--border-editor)' }}
                  placeholder="e.g. tests/fixtures/01_global_state_divergence/rust_buggy/src"
                  value={rustPath}
                  onChange={(e) => {
                    setRustPath(e.target.value);
                    setRustFilesUploaded(null);
                  }}
                  disabled={isRunning}
                />
                <input
                  type="file"
                  ref={rustFolderInputRef}
                  webkitdirectory=""
                  directory=""
                  multiple
                  style={{ display: 'none' }}
                  onChange={(e) => handleFolderUpload(e, setRustFilesUploaded, setRustPath)}
                />
                <button
                  className="retro-btn small"
                  onClick={() => rustFolderInputRef.current?.click()}
                  title="Upload folder from local machine"
                  disabled={isRunning}
                >
                  <Upload size={12} />
                  <span>UPLOAD</span>
                </button>
              </div>
            </div>

            {/* Inspection Preview */}
            <div style={{ background: 'var(--bg-card)', padding: '8px', border: '1px solid var(--border-editor)', fontSize: '11px' }}>
              <div style={{ fontWeight: 'bold', color: 'var(--text-highlight)', marginBottom: '4px' }}>
                Found Files in Rust Folder:
              </div>
              {rustFilesUploaded ? (
                <div style={{ color: 'var(--text-green)' }}>
                  ✓ {rustFilesUploaded.length} file(s) uploaded into temporary workspace
                </div>
              ) : rustInspection?.rs_files?.length ? (
                <div>
                  <div style={{ color: 'var(--text-green)', marginBottom: '2px' }}>
                    ✓ {rustInspection.total_rs} .rs source file(s) detected
                  </div>
                  <div style={{ color: 'var(--text-muted)', fontSize: '10.5px' }}>
                    Files: {rustInspection.rs_files.join(', ')}
                  </div>
                </div>
              ) : rustInspection?.error ? (
                <div style={{ color: 'var(--text-red)' }}>⚠ {rustInspection.error}</div>
              ) : (
                <div style={{ color: 'var(--text-muted)' }}>No folder chosen or empty directory.</div>
              )}
            </div>
          </div>
        </div>

        {/* Verification Action and Options Bar */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '10px', marginTop: '12px', borderTop: '1px solid var(--border-editor)', paddingTop: '10px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px', flexWrap: 'wrap' }}>
            {detectedPointers ? (
              <div
                className="retro-status-pill active"
                title="Automatic Pointer Detection: Pointer out-parameter tracking is enabled for this project"
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '5px',
                  padding: '3px 9px',
                  fontSize: '11px',
                  fontWeight: 'bold',
                  fontFamily: 'var(--font-mono)',
                  background: 'rgba(0, 255, 102, 0.1)',
                  border: '1px solid var(--text-green, #00ff66)',
                  color: 'var(--text-green, #00ff66)',
                  letterSpacing: '0.5px'
                }}
              >
                <Sparkles size={12} color="var(--text-green, #00ff66)" />
                <span>AUTO: POINTER TRACKING ACTIVE</span>
              </div>
            ) : (
              <div
                className="retro-status-pill"
                title="Automatic Parameter Detection: Function parameters modeled as standard scalar symbolic inputs"
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '5px',
                  padding: '3px 9px',
                  fontSize: '11px',
                  fontFamily: 'var(--font-mono)',
                  background: 'rgba(255, 255, 255, 0.05)',
                  border: '1px solid var(--border-editor, #444)',
                  color: 'var(--text-muted, #888)',
                  letterSpacing: '0.5px'
                }}
              >
                <Cpu size={12} />
                <span>AUTO: SCALAR INPUTS</span>
              </div>
            )}

            <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '11px' }}>
              <span style={{ color: 'var(--text-muted)' }}>C Include Dir:</span>
              <input
                type="text"
                className="code-textarea"
                style={{ height: '26px', padding: '2px 6px', width: '180px', border: '1px solid var(--border-editor)', fontSize: '11px' }}
                placeholder="Optional include folder"
                value={includeDir || ''}
                onChange={(e) => setIncludeDir(e.target.value)}
                disabled={isRunning}
              />
            </div>
          </div>

          <button
            className="retro-btn primary"
            onClick={onRunVerification}
            disabled={isRunning || (!cPath && !cFilesUploaded) || (!rustPath && !rustFilesUploaded)}
            title="Execute inter-procedural equivalence verification across both folders"
          >
            <ArrowRight size={14} />
            <span>{isRunning ? 'VERIFYING FOLDERS...' : 'F9: VERIFY TWO PROJECT FOLDERS'}</span>
          </button>
        </div>
      </div>
    </div>
  );
}
