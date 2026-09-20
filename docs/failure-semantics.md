# Failure semantics

Security code is easier to reason about when failure behavior is explicit.

## Validation

Malformed or unauthorized input is rejected before domain execution. The caller receives a coarse error code suitable for the boundary; internal security context does not need to be disclosed to the client.

## Diagnostics

Diagnostics are secondary to the decision path.

If sanitization, telemetry, or an optional provider fails, that failure must not be converted into player suspicion. Diagnostic state is bounded so a noisy source cannot grow memory without limit.

## Dependencies

Production integrations sit behind narrow provider interfaces. A provider failure should be contained at that boundary rather than changing unrelated security semantics.

## Lifecycle

Services own the state they create and must release it during teardown. Reinitialization should not duplicate listeners or retain stale per-player state.

The tests in this repository exercise representative versions of these properties without reproducing Guardian's production heuristics.
