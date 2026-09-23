import React from 'react';
import { Play, Monitor, Palette, Cpu, Sparkles, Terminal, FileCode } from 'lucide-react';

export default function RetroHeader({
  theme,
  setTheme,
  scanlines,
  setScanlines,
  onRunVerification,
  isRunning,
  solverStatus
}) {
  return (
    <header className="retro-menubar">
      <div className="menubar-left">
        <div className="app-title-badge">
          <Terminal size={14} />
          <span>RUSTSKETCH 1.0</span>
        </div>

        <nav className="menu-items">
          <div className="menu-item" onClick={() => alert("RustSketch: Semantic Equivalence Validation Framework for C-to-Rust Transpilation.\nPowered by Clang, rustc, llvm-link, angr, and Z3.")}>
            <span className="shortcut">F</span>ile
          </div>
          <div className="menu-item" onClick={() => onRunVerification()}>
            <span className="shortcut">R</span>un (F9)
          </div>
          <div className="menu-item" onClick={() => alert("RustSketch decomposes C and Rust code into LLVM IR, extracts summaries with angr, and queries Z3 for (Summary_C != Summary_Rust).")}>
            <span className="shortcut">A</span>rchitecture
          </div>
          <div className="menu-item" onClick={() => alert("Shortcuts:\n• F9 / Ctrl+Enter: Run Verification\n• Esc: Close Modals\n• Drag & Drop files into C/Rust editor panels")}>
            <span className="shortcut">H</span>elp (F1)
          </div>
        </nav>
      </div>

      <div className="menubar-right">
        {/* Solver status badge */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '11px', color: 'var(--text-accent)' }}>
          <Cpu size={13} />
          <span>Z3: {solverStatus?.z3 || 'READY'}</span>
        </div>

        {/* CRT Scanline Toggle */}
        <button
          className={`retro-btn small ${scanlines ? 'secondary' : ''}`}
          onClick={() => setScanlines(!scanlines)}
          title="Toggle vintage CRT scanline and phosphor bloom overlay"
        >
          <Monitor size={12} />
          <span>CRT: {scanlines ? 'ON' : 'OFF'}</span>
        </button>

        {/* Theme Picker */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
          <Palette size={12} />
          <select
            className="retro-select"
            value={theme}
            onChange={(e) => setTheme(e.target.value)}
            title="Switch Vintage Coding Theme"
          >
            <option value="borland">Borland Turbo C++ (1993)</option>
            <option value="amber">Amber CRT VT220 (1982)</option>
            <option value="green">Phosphor Green VT100 (1987)</option>
            <option value="cyberdeck">Cyberdeck Neon (1984)</option>
          </select>
        </div>

        {/* Big Action Run Button */}
        <button
          className="retro-btn primary"
          onClick={onRunVerification}
          disabled={isRunning}
          title="Execute angr symbolic analysis and Z3 SMT solver verification"
        >
          <Play size={13} fill={isRunning ? 'none' : 'currentColor'} />
          <span>{isRunning ? 'SOLVING...' : 'F9: VERIFY'}</span>
        </button>
      </div>
    </header>
  );
}
