# Public Engineering Evidence

This page maps the engineering properties described by the showcase to code and test coverage that can be inspected directly.

| Property | Implementation | Test coverage |
| --- | --- | --- |
| Client input crosses a server-owned validation boundary | `src/Demo/ExampleValidator.luau`, `src/Demo/RemoteSecurityBoundary.luau` | malformed input, invalid field types, non-finite numbers, request-shaped authority, unexpected fields, unauthorized context |
| Diagnostic state remains bounded | `src/Infrastructure/BoundedBuffer.luau` | capacity overflow, repeated wraparound, insertion order |
| Diagnostic context is sanitized before storage | `src/Infrastructure/Sanitizer.luau` | unsupported values, long keys, long values, nil input |
| Diagnostic provider failure stays inside the diagnostic boundary | `src/Infrastructure/SafeDiagnosticSink.luau` | provider exception with domain state left unchanged |

## Validation status

The repository includes tests for the public contracts above. Runtime execution is a separate validation step and is not claimed by this showcase until a Roblox-compatible test runner or Studio validation is connected.

The code and test cases are public so the boundaries and expected behavior can be reviewed independently.

## Private implementation

Production detectors, thresholds, signal correlation, integrity mechanisms, suspicion logic and enforcement policy are not part of this repository.
