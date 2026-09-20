# Public Engineering Evidence

This page maps the engineering properties described by the showcase to code and tests that can be inspected directly.

| Property | Implementation | Adversarial coverage |
| --- | --- | --- |
| Client input crosses a server-owned validation boundary | `src/Demo/ExampleValidator.luau` | malformed input, missing fields, invalid field types, client-shaped authority, unauthorized context |
| Diagnostic state remains bounded | `src/Infrastructure/BoundedBuffer.luau` | capacity overflow, repeated wraparound, insertion order |
| Diagnostic context is sanitized before storage | `src/Infrastructure/Sanitizer.luau` | unsupported values, long keys, long values, nil input |
| Diagnostic provider failure stays inside the diagnostic boundary | `src/Infrastructure/SafeDiagnosticSink.luau` | provider exception with domain state left unchanged |

## Scope of the evidence

These tests cover the public contracts in this repository. They do not simulate Guardian's production detection system.

Each published property has an implementation and a test that tries to violate the boundary.

## Private implementation

Production detectors, thresholds, signal correlation, integrity mechanisms, suspicion logic and enforcement policy are not part of this repository.
