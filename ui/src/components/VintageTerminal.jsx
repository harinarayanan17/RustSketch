import React, { useRef, useEffect, useState } from 'react';
import { Terminal, Download, Copy, Check, Trash2, ArrowDownCircle } from 'lucide-react';

export default function VintageTerminal({
  log,
  isRunning,
  activeStage,
  onClearLog,
  onDownloadLog
}) {
  const [autoScroll, setAutoScroll] = useState(true);
  const [copied, setCopied] = useState(false);
  const terminalRef = useRef(null);

  useEffect(() => {
    if (autoScroll && terminalRef.current) {
      terminalRef.current.scrollTop = terminalRef.current.scrollHeight;
    }
  }, [log, autoScroll]);

  const copyLog = () => {
    navigator.clipboard.writeText(log || '');
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  const stages = [
    { num: 1, label: 'VALIDATE' },
    { num: 2, label: 'LLVM IR' },
    { num: 3, label: 'CALL-GRAPH' },
    { num: 4, label: 'ANGR SUMMARIES' },
    { num: 5, label: 'Z3 DIFF QUERY' },
    { num: 6, label: 'FORMAL VERDICT' }
  ];

  return (
    <div className="terminal-window">
      {/* Stages Progress Bar */}
      <div className="verification-progress-bar">
        {stages.map((stage, idx) => {
          const isDone = activeStage > stage.num;
          const isActive = activeStage === stage.num;
          return (
            <React.Fragment key={stage.num}>
              <div className={`stage-step ${isDone ? 'done' : ''} ${isActive ? 'active' : ''}`}>
                <span>[{isDone ? '✓' : isActive ? '▶' : stage.num}]</span>
                <span>{stage.label}</span>
              </div>
              {idx < stages.length - 1 && <span className="stage-divider">→</span>}
            </React.Fragment>
          );
        })}
      </div>

      {/* Terminal Titlebar */}
      <div className="terminal-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <Terminal size={13} color="var(--text-accent)" />
          <span style={{ fontWeight: 'bold' }}>VERIFICATION PIPELINE CONSOLE [TTY 1]</span>
          {isRunning && (
            <span style={{ color: 'var(--text-highlight)', fontWeight: 'bold' }}>
              ● RUNNING SMT PROVER...
            </span>
          )}
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
          <button
            className={`retro-btn small ${autoScroll ? 'primary' : 'secondary'}`}
            onClick={() => setAutoScroll(!autoScroll)}
            title="Toggle automatic scrolling to newest output"
          >
            <ArrowDownCircle size={11} />
            <span>SCROLL: {autoScroll ? 'ON' : 'OFF'}</span>
          </button>

          <button
            className="retro-btn small"
            onClick={copyLog}
            title="Copy Terminal Logs"
          >
            {copied ? <Check size={11} color="var(--text-green)" /> : <Copy size={11} />}
            <span>{copied ? 'COPIED' : 'COPY'}</span>
          </button>

          <button
            className="retro-btn small"
            onClick={onDownloadLog}
            title="Download Full Terminal Log"
          >
            <Download size={11} />
            <span>SAVE LOG</span>
          </button>

          <button
            className="retro-btn small"
            onClick={onClearLog}
            title="Clear Console Output"
          >
            <Trash2 size={11} />
            <span>CLEAR</span>
          </button>
        </div>
      </div>

      {/* Terminal Output */}
      <div className="terminal-output" ref={terminalRef}>
        {log || (
          <span style={{ color: 'var(--text-muted)' }}>
            [RustSketch System Ready]&#10;
            Select a benchmark preset or enter C and Rust code above, then press [F9: VERIFY] to run formal equivalence analysis.
          </span>
        )}
      </div>
    </div>
  );
}
