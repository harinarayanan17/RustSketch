import React, { useRef, useState } from 'react';
import { FileCode, Upload, Copy, Check, Trash2, ArrowDownToLine } from 'lucide-react';

export default function DualCodeEditor({
  cCode,
  setCCode,
  rustCode,
  setRustCode,
  detectedPointers,
  isRunning
}) {
  const [cCopied, setCCopied] = useState(false);
  const [rustCopied, setRustCopied] = useState(false);
  const [cDragging, setCDragging] = useState(false);
  const [rustDragging, setRustDragging] = useState(false);

  const cFileInputRef = useRef(null);
  const rustFileInputRef = useRef(null);
  const cTextareaRef = useRef(null);
  const rustTextareaRef = useRef(null);
  const cGutterRef = useRef(null);
  const rustGutterRef = useRef(null);

  // Line calculations
  const cLines = (cCode || '').split('\n');
  const rustLines = (rustCode || '').split('\n');

  // Synchronize scroll between textarea and gutter
  const handleScroll = (textarea, gutter) => {
    if (gutter && textarea) {
      gutter.scrollTop = textarea.scrollTop;
    }
  };

  // Tab key handling in textarea
  const handleKeyDown = (e, setCode) => {
    if (e.key === 'Tab') {
      e.preventDefault();
      const start = e.target.selectionStart;
      const end = e.target.selectionEnd;
      const value = e.target.value;
      const newValue = value.substring(0, start) + '    ' + value.substring(end);
      setCode(newValue);
      setTimeout(() => {
        e.target.selectionStart = e.target.selectionEnd = start + 4;
      }, 0);
    }
  };

  // Copy helpers
  const copyToClipboard = (text, setCopied) => {
    navigator.clipboard.writeText(text);
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  // File upload helpers
  const handleFileUpload = (e, setCode) => {
    const file = e.target.files?.[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (event) => {
      setCode(event.target.result);
    };
    reader.readAsText(file);
    e.target.value = '';
  };

  // Drag and Drop helpers
  const handleDrop = (e, setCode, setDragging) => {
    e.preventDefault();
    setDragging(false);
    const file = e.dataTransfer.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (event) => {
        setCode(event.target.result);
      };
      reader.readAsText(file);
    }
  };

  return (
    <div className="editors-grid">
      {/* C Program Editor */}
      <div
        className="editor-panel"
        onDragOver={(e) => { e.preventDefault(); setCDragging(true); }}
        onDragLeave={() => setCDragging(false)}
        onDrop={(e) => handleDrop(e, setCCode, setCDragging)}
      >
        <div className="editor-header">
          <div className="editor-header-title">
            <FileCode size={13} color="var(--text-accent)" />
            <span>ORIGINAL C PROGRAM [INPUT.C]</span>
            {detectedPointers && (
              <span
                className="badge badge-unsat"
                style={{ marginLeft: '6px', fontSize: '9px', padding: '1px 5px' }}
                title="Automatic Pointer Detection: Pointer parameter(s) detected (*ptr)"
              >
                *PTR DETECTED
              </span>
            )}
          </div>
          <div className="editor-header-actions">
            <input
              type="file"
              ref={cFileInputRef}
              style={{ display: 'none' }}
              accept=".c,.h,.txt"
              onChange={(e) => handleFileUpload(e, setCCode)}
            />
            <button
              className="retro-btn small"
              onClick={() => cFileInputRef.current?.click()}
              title="Upload C Source File"
            >
              <Upload size={11} />
              <span>LOAD .C</span>
            </button>
            <button
              className="retro-btn small"
              onClick={() => copyToClipboard(cCode, setCCopied)}
              title="Copy C Code"
            >
              {cCopied ? <Check size={11} color="var(--text-green)" /> : <Copy size={11} />}
              <span>{cCopied ? 'COPIED' : 'COPY'}</span>
            </button>
            <button
              className="retro-btn small"
              onClick={() => setCCode('')}
              title="Clear C Editor"
            >
              <Trash2 size={11} />
              <span>CLEAR</span>
            </button>
          </div>
        </div>

        <div className="editor-body-wrapper">
          {cDragging && (
            <div className="drop-overlay">
              <ArrowDownToLine size={32} />
              <span>DROP C SOURCE FILE HERE (.c / .h)</span>
            </div>
          )}
          <div className="line-numbers-gutter" ref={cGutterRef}>
            {cLines.map((_, i) => (
              <div key={i}>{i + 1}</div>
            ))}
          </div>
          <textarea
            ref={cTextareaRef}
            className="code-textarea"
            value={cCode}
            onChange={(e) => setCCode(e.target.value)}
            onKeyDown={(e) => handleKeyDown(e, setCCode)}
            onScroll={() => handleScroll(cTextareaRef.current, cGutterRef.current)}
            placeholder="// Type or paste original C program here...&#10;// Supports helper functions, callers, and global state"
            spellCheck={false}
            disabled={isRunning}
          />
        </div>

        <div className="editor-statusbar">
          <span>LINES: {cLines.length} | CHARS: {cCode.length}</span>
          <span>SIZE: {(cCode.length / 1024).toFixed(2)} KB</span>
          <span>LANG: C (CLANG LLVM)</span>
        </div>
      </div>

      {/* Rust Program Editor */}
      <div
        className="editor-panel"
        onDragOver={(e) => { e.preventDefault(); setRustDragging(true); }}
        onDragLeave={() => setRustDragging(false)}
        onDrop={(e) => handleDrop(e, setRustCode, setRustDragging)}
      >
        <div className="editor-header">
          <div className="editor-header-title">
            <FileCode size={13} color="var(--text-highlight)" />
            <span>TRANSPILED RUST PROGRAM [INPUT.RS]</span>
          </div>
          <div className="editor-header-actions">
            <input
              type="file"
              ref={rustFileInputRef}
              style={{ display: 'none' }}
              accept=".rs,.txt"
              onChange={(e) => handleFileUpload(e, setRustCode)}
            />
            <button
              className="retro-btn small"
              onClick={() => rustFileInputRef.current?.click()}
              title="Upload Rust Source File"
            >
              <Upload size={11} />
              <span>LOAD .RS</span>
            </button>
            <button
              className="retro-btn small"
              onClick={() => copyToClipboard(rustCode, setRustCopied)}
              title="Copy Rust Code"
            >
              {rustCopied ? <Check size={11} color="var(--text-green)" /> : <Copy size={11} />}
              <span>{rustCopied ? 'COPIED' : 'COPY'}</span>
            </button>
            <button
              className="retro-btn small"
              onClick={() => setRustCode('')}
              title="Clear Rust Editor"
            >
              <Trash2 size={11} />
              <span>CLEAR</span>
            </button>
          </div>
        </div>

        <div className="editor-body-wrapper">
          {rustDragging && (
            <div className="drop-overlay">
              <ArrowDownToLine size={32} />
              <span>DROP RUST SOURCE FILE HERE (.rs)</span>
            </div>
          )}
          <div className="line-numbers-gutter" ref={rustGutterRef}>
            {rustLines.map((_, i) => (
              <div key={i}>{i + 1}</div>
            ))}
          </div>
          <textarea
            ref={rustTextareaRef}
            className="code-textarea"
            value={rustCode}
            onChange={(e) => setRustCode(e.target.value)}
            onKeyDown={(e) => handleKeyDown(e, setRustCode)}
            onScroll={() => handleScroll(rustTextareaRef.current, rustGutterRef.current)}
            placeholder="// Type or paste transpiled Rust program here...&#10;// Export functions using: pub extern &quot;C&quot; fn foo() ...&#10;// RustSketch automatically handles #[no_mangle] &amp; static mut instrumentation"
            spellCheck={false}
            disabled={isRunning}
          />
        </div>

        <div className="editor-statusbar">
          <span>LINES: {rustLines.length} | CHARS: {rustCode.length}</span>
          <span>SIZE: {(rustCode.length / 1024).toFixed(2)} KB</span>
          <span>LANG: RUST (RUSTC LLVM)</span>
        </div>
      </div>
    </div>
  );
}
