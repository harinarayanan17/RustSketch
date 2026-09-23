import React, { useState } from 'react';
import { Download, FileJson, FileText, Code2, ClipboardCopy, Check } from 'lucide-react';

export default function DownloadManager({
  runId,
  results,
  log,
  allEquivalent,
  summary,
  onDownloadReproducers
}) {
  const [copied, setCopied] = useState(false);

  if (!results || results.length === 0) {
    return null;
  }

  const handleDownloadJSON = () => {
    const dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(results, null, 2));
    const downloadAnchor = document.createElement('a');
    downloadAnchor.setAttribute("href", dataStr);
    downloadAnchor.setAttribute("download", `rustsketch_report_${runId || 'latest'}.json`);
    document.body.appendChild(downloadAnchor);
    downloadAnchor.click();
    downloadAnchor.remove();
  };

  const handleDownloadLog = () => {
    const dataStr = "data:text/plain;charset=utf-8," + encodeURIComponent(log || '');
    const downloadAnchor = document.createElement('a');
    downloadAnchor.setAttribute("href", dataStr);
    downloadAnchor.setAttribute("download", `rustsketch_divergence_${runId || 'latest'}.log`);
    document.body.appendChild(downloadAnchor);
    downloadAnchor.click();
    downloadAnchor.remove();
  };

  const handleCopySummary = () => {
    const text = `RustSketch Formal Verification Report\nRun ID: ${runId || 'latest'}\nVerdict: ${allEquivalent ? 'EQUIVALENT (UNSAT)' : 'DIVERGENCE DETECTED (SAT)'}\nFunctions Analyzed: ${results.length}\n${results.map(r => `• ${r.function}: ${r.verdict} (${r.details})`).join('\n')}`;
    navigator.clipboard.writeText(text);
    setCopied(true);
    setTimeout(() => setCopied(false), 1500);
  };

  return (
    <div className="download-bar">
      <div className="download-bar-title">
        <Download size={14} color="var(--text-highlight)" />
        <span>DIRECT EXPORT & AUDIT REPORTS</span>
      </div>

      <div className="download-buttons">
        <button
          className="retro-btn small primary"
          onClick={handleDownloadJSON}
          title="Download complete JSON equivalence report with counterexamples"
        >
          <FileJson size={12} />
          <span>DOWNLOAD JSON REPORT</span>
        </button>

        <button
          className="retro-btn small"
          onClick={handleDownloadLog}
          title="Download raw terminal divergence execution log"
        >
          <FileText size={12} />
          <span>DOWNLOAD FULL LOG</span>
        </button>

        {!allEquivalent && (
          <button
            className="retro-btn small secondary"
            onClick={onDownloadReproducers}
            title="Download standalone C and Rust reproduction test harness files"
          >
            <Code2 size={12} />
            <span>EXPORT REPRODUCERS (.C / .RS)</span>
          </button>
        )}

        <button
          className="retro-btn small"
          onClick={handleCopySummary}
          title="Copy text summary to clipboard"
        >
          {copied ? <Check size={12} color="var(--text-green)" /> : <ClipboardCopy size={12} />}
          <span>{copied ? 'COPIED SUMMARY' : 'COPY SUMMARY'}</span>
        </button>
      </div>
    </div>
  );
}
