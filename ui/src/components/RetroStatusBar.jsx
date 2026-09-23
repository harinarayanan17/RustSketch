import React from 'react';

export default function RetroStatusBar({
  cCode,
  rustCode,
  isRunning,
  solverStatus,
  allEquivalent,
  hasResults
}) {
  const cLines = (cCode || '').split('\n').length;
  const rustLines = (rustCode || '').split('\n').length;

  return (
    <footer className="retro-statusbar">
      <div className="statusbar-left">
        <span>F1 HELP</span>
        <span>|</span>
        <span>F9 VERIFY</span>
        <span>|</span>
        <span>ESC MODAL</span>
        <span>|</span>
        <span>C: {cLines} LINES</span>
        <span>|</span>
        <span>RS: {rustLines} LINES</span>
      </div>

      <div className="statusbar-right">
        <span>TARGET: X86_64-LINUX-GNU</span>
        <span>|</span>
        <span>SOLVER: angr + Z3</span>
        <span>|</span>
        <span style={{ fontWeight: 'bold' }}>
          {isRunning
            ? '⚡ SOLVING...'
            : hasResults
            ? allEquivalent
              ? '✓ UNSAT (EQUIVALENT)'
              : '⚠ SAT (DIVERGENT)'
            : 'READY'}
        </span>
      </div>
    </footer>
  );
}
