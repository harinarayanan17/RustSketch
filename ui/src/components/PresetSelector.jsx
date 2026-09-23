import React from 'react';
import { BookOpen, Folder, RotateCcw, FileCode, Layers, Sparkles, Cpu } from 'lucide-react';

export default function PresetSelector({
  inputMode,
  setInputMode,
  presets,
  selectedPresetId,
  onSelectPreset,
  detectedPointers,
  onResetCode,
  isRunning
}) {
  return (
    <div className="retro-toolbar">
      {/* Mode Switcher */}
      <div className="toolbar-group">
        <span className="toolbar-label">
          <Layers size={13} />
          <span>INPUT MODE:</span>
        </span>
        <button
          className={`retro-btn small ${inputMode === 'editor' ? 'primary' : 'secondary'}`}
          onClick={() => setInputMode('editor')}
          disabled={isRunning}
          title="Type or paste C and Rust source code directly in dual editor panes"
        >
          <FileCode size={11} />
          <span>CODE EDITORS</span>
        </button>
        <button
          className={`retro-btn small ${inputMode === 'folders' ? 'primary' : 'secondary'}`}
          onClick={() => setInputMode('folders')}
          disabled={isRunning}
          title="Select or compare two project directories (C Folder vs Rust Folder)"
        >
          <Folder size={11} />
          <span>PROJECT FOLDERS</span>
        </button>
      </div>

      {/* Benchmark Presets Dropdown (shown in editor mode) */}
      {inputMode === 'editor' && (
        <div className="toolbar-group">
          <label className="toolbar-label" htmlFor="benchmark-select">
            <BookOpen size={13} />
            <span>Benchmark Preset:</span>
          </label>
          <select
            id="benchmark-select"
            className="retro-select preset-dropdown"
            value={selectedPresetId || ''}
            onChange={(e) => onSelectPreset(e.target.value)}
            disabled={isRunning}
          >
            <option value="">-- Choose a Transpilation Benchmark --</option>
            {presets.map((preset) => (
              <option key={preset.id} value={preset.id}>
                {preset.title} [{preset.expected_verdict}]
              </option>
            ))}
          </select>
        </div>
      )}

      {/* Auto-Detection Status Pill & Reset */}
      <div className="toolbar-group" style={{ marginLeft: 'auto', display: 'flex', alignItems: 'center', gap: '8px' }}>
        {detectedPointers ? (
          <div
            className="retro-status-pill active"
            title="Automatic Pointer Detection: Pointer out-parameter tracking is enabled for this program"
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

        <button
          className="retro-btn small secondary"
          onClick={onResetCode}
          disabled={isRunning}
          title="Clear inputs and reset state"
        >
          <RotateCcw size={12} />
          <span>RESET</span>
        </button>
      </div>
    </div>
  );
}
