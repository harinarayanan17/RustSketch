import React, { useState } from 'react';
import { Code2, X, Download, Copy, Check, FileCode } from 'lucide-react';

export default function HarnessModal({
  isOpen,
  onClose,
  harnessData
}) {
  const [activeTab, setActiveTab] = useState('c'); // 'c' or 'rust'
  const [copied, setCopied] = useState(false);

  if (!isOpen || !harnessData) return null;

  const currentCode = activeTab === 'c' ? harnessData.c_harness : harnessData.rust_harness;
  const currentFilename = activeTab === 'c'
    ? `test_${harnessData.function_name}_divergence.c`
    : `test_${harnessData.function_name}_divergence.rs`;

  const handleCopy = () => {
    navigator.clipboard.writeText(currentCode || '');
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  const handleDownload = () => {
    const dataStr = "data:text/plain;charset=utf-8," + encodeURIComponent(currentCode || '');
    const downloadAnchor = document.createElement('a');
    downloadAnchor.setAttribute("href", dataStr);
    downloadAnchor.setAttribute("download", currentFilename);
    document.body.appendChild(downloadAnchor);
    downloadAnchor.click();
    downloadAnchor.remove();
  };

  const handleDownloadBoth = () => {
    // Download C
    const dataStrC = "data:text/plain;charset=utf-8," + encodeURIComponent(harnessData.c_harness || '');
    const aC = document.createElement('a');
    aC.setAttribute("href", dataStrC);
    aC.setAttribute("download", `test_${harnessData.function_name}_divergence.c`);
    document.body.appendChild(aC);
    aC.click();
    aC.remove();

    // Download Rust
    setTimeout(() => {
      const dataStrR = "data:text/plain;charset=utf-8," + encodeURIComponent(harnessData.rust_harness || '');
      const aR = document.createElement('a');
      aR.setAttribute("href", dataStrR);
      aR.setAttribute("download", `test_${harnessData.function_name}_divergence.rs`);
      document.body.appendChild(aR);
      aR.click();
      aR.remove();
    }, 200);
  };

  return (
    <div className="retro-modal-backdrop" onClick={onClose}>
      <div className="retro-modal" onClick={(e) => e.stopPropagation()}>
        {/* Titlebar */}
        <div className="window-titlebar">
          <div className="titlebar-text">
            <Code2 size={14} color="var(--text-highlight)" />
            <span>SYNTHESIZED REPRODUCER TEST HARNESS // {harnessData.function_name}</span>
          </div>
          <div className="titlebar-controls">
            <button className="window-control-btn" onClick={onClose}>
              <X size={10} />
            </button>
          </div>
        </div>

        {/* Tab Selection */}
        <div style={{ display: 'flex', gap: '4px', padding: '6px 14px', background: 'var(--bg-card)', borderBottom: '1px solid var(--border-editor)' }}>
          <button
            className={`retro-btn small ${activeTab === 'c' ? 'primary' : 'secondary'}`}
            onClick={() => setActiveTab('c')}
          >
            <FileCode size={11} />
            <span>STANDALONE C TEST (.C)</span>
          </button>
          <button
            className={`retro-btn small ${activeTab === 'rust' ? 'primary' : 'secondary'}`}
            onClick={() => setActiveTab('rust')}
          >
            <FileCode size={11} />
            <span>STANDALONE RUST TEST (.RS)</span>
          </button>
        </div>

        {/* Code Content */}
        <div className="modal-content">
          <div style={{ marginBottom: '8px', fontSize: '11px', color: 'var(--text-muted)' }}>
            This standalone test file reproduces the exact counterexample synthesized by Z3. Compile and run it directly to observe the divergence in isolation.
          </div>
          <pre
            style={{
              backgroundColor: 'var(--bg-editor)',
              color: 'var(--text-primary)',
              padding: '12px',
              fontFamily: 'var(--font-mono)',
              fontSize: '12px',
              lineHeight: 1.5,
              border: '1px solid var(--border-editor)',
              overflowX: 'auto',
              maxHeight: '380px',
              whiteSpace: 'pre-wrap'
            }}
          >
            {currentCode}
          </pre>
        </div>

        {/* Footer actions */}
        <div className="modal-footer">
          <button className="retro-btn small" onClick={handleCopy}>
            {copied ? <Check size={11} color="var(--text-green)" /> : <Copy size={11} />}
            <span>{copied ? 'COPIED' : 'COPY CODE'}</span>
          </button>
          <button className="retro-btn small" onClick={handleDownload}>
            <Download size={11} />
            <span>DOWNLOAD {activeTab.toUpperCase()}</span>
          </button>
          <button className="retro-btn small primary" onClick={handleDownloadBoth}>
            <Download size={11} />
            <span>DOWNLOAD BOTH (.C + .RS)</span>
          </button>
          <button className="retro-btn small secondary" onClick={onClose}>
            <span>CLOSE</span>
          </button>
        </div>
      </div>
    </div>
  );
}
