import React from 'react';
import { CheckCircle2, AlertTriangle, Cpu, Layers, HelpCircle, Code2, ArrowRight } from 'lucide-react';

export default function DivergenceInspector({
  results,
  overallVerdict,
  allEquivalent,
  isRunning,
  onGenerateHarness
}) {
  if (!results || results.length === 0) {
    return null;
  }

  return (
    <div className="divergence-section">
      {/* Formal Overall Verdict Banner */}
      <div className={`verdict-banner ${allEquivalent ? 'unsat' : 'sat'}`}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
          {allEquivalent ? (
            <CheckCircle2 size={24} color="var(--text-green)" />
          ) : (
            <AlertTriangle size={24} color="var(--text-red)" />
          )}
          <div>
            <div style={{ fontSize: '16px', fontWeight: 'bold' }}>
              {allEquivalent
                ? 'OVERALL VERDICT: ALL MODULES SEMANTICALLY EQUIVALENT (UNSAT)'
                : 'OVERALL VERDICT: SEMANTIC DIVERGENCE DETECTED (SAT)'}
            </div>
            <div style={{ fontSize: '11px', fontWeight: 'normal', opacity: 0.85, marginTop: '2px' }}>
              {allEquivalent
                ? 'Z3 SMT solver proved no counter-example exists across all symbolic path inputs.'
                : 'Z3 synthesized a concrete counter-example witness where C and Rust behaviors diverge.'}
            </div>
          </div>
        </div>

        <div className={`verdict-badge ${allEquivalent ? 'unsat' : 'sat'}`}>
          {allEquivalent ? 'PROOF: UNSAT' : 'WITNESS: SAT'}
        </div>
      </div>

      {/* Function Analysis Cards */}
      <div className="retro-window" style={{ margin: '0' }}>
        <div className="window-titlebar">
          <div className="titlebar-text">
            <Layers size={13} />
            <span>INTER-PROCEDURAL FUNCTION EQUIVALENCE BREAKDOWN</span>
          </div>
          <span style={{ fontSize: '11px' }}>{results.length} FUNCTION(S) ANALYZED</span>
        </div>

        <div style={{ padding: '12px' }}>
          {results.map((res, idx) => {
            const hasCex = res.counterexample && Object.keys(res.counterexample).length > 0;
            const cOutputs = res.c_outputs || {};
            const rustOutputs = res.rust_outputs || {};
            const outputKeys = Array.from(new Set([...Object.keys(cOutputs), ...Object.keys(rustOutputs)]));

            return (
              <div key={idx} className="function-card">
                <div className="function-card-header">
                  <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                    <span className="func-name">fn {res.function}()</span>
                    <span
                      className={`verdict-badge ${res.equivalent ? 'unsat' : 'sat'}`}
                      style={{ fontSize: '11px', padding: '2px 8px' }}
                    >
                      {res.verdict || (res.equivalent ? 'UNSAT' : 'SAT')}
                    </span>
                  </div>

                  {!res.equivalent && hasCex && (
                    <button
                      className="retro-btn small primary"
                      onClick={() => onGenerateHarness(res)}
                      title="Synthesize standalone C and Rust reproduction test harness"
                    >
                      <Code2 size={12} />
                      <span>GENERATE REPRODUCER</span>
                    </button>
                  )}
                </div>

                <div style={{ fontSize: '12px', color: 'var(--text-primary)', marginBottom: '8px' }}>
                  <strong>Status:</strong> {res.details}
                </div>

                {/* If Divergence Detected, show Witness and Output Diff */}
                {!res.equivalent && hasCex && (
                  <div className="witness-grid">
                    {/* Witness Inputs */}
                    <div className="witness-block">
                      <div className="witness-title">
                        <span>COUNTER-EXAMPLE WITNESS INPUTS</span>
                        <Cpu size={12} />
                      </div>
                      <table className="witness-table">
                        <tbody>
                          {Object.entries(res.counterexample).map(([k, v]) => (
                            <tr key={k}>
                              <td className="label">{k}:</td>
                              <td className="val">
                                {v}{' '}
                                {typeof v === 'number' && (
                                  <span style={{ color: 'var(--text-muted)', fontSize: '10px' }}>
                                    (0x{v.toString(16)})
                                  </span>
                                )}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>

                    {/* Side-by-Side State Trace */}
                    <div className="witness-block">
                      <div className="witness-title">
                        <span>BEHAVIORAL TRACE COMPARISON</span>
                        <span style={{ fontSize: '10px', color: 'var(--text-red)' }}>[MISMATCH]</span>
                      </div>
                      <table className="witness-table">
                        <thead>
                          <tr style={{ borderBottom: '1px solid var(--border-editor)' }}>
                            <th style={{ textAlign: 'left', fontSize: '10px', color: 'var(--text-muted)' }}>ATTRIBUTE</th>
                            <th style={{ textAlign: 'right', fontSize: '10px', color: 'var(--text-accent)' }}>C STATE</th>
                            <th style={{ textAlign: 'right', fontSize: '10px', color: 'var(--text-highlight)' }}>RUST STATE</th>
                          </tr>
                        </thead>
                        <tbody>
                          {outputKeys.map((key) => {
                            const cVal = cOutputs[key] !== undefined ? String(cOutputs[key]) : 'null';
                            const rVal = rustOutputs[key] !== undefined ? String(rustOutputs[key]) : 'null';
                            const isMismatch = cVal !== rVal;

                            return (
                              <tr key={key}>
                                <td className="label">{key}:</td>
                                <td className={`val ${isMismatch ? 'mismatch' : 'match'}`}>{cVal}</td>
                                <td className={`val ${isMismatch ? 'mismatch' : 'match'}`}>{rVal}</td>
                              </tr>
                            );
                          })}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
