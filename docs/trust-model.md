# Trust model

## Trusted

Security-sensitive state derived and maintained by the server is trusted within its owning boundary. Administrative capability is server-derived. Domain services are responsible for their own invariants.

## Untrusted

All client-provided values are input, including values that appear structurally valid.

A request is not accepted because the client says it has permission, because a field has the expected type, or because a previous request was valid.

## Public invariants

1. A client cannot grant itself administrative authority.
2. Invalid input cannot mutate trusted domain state.
3. Validation occurs before domain execution.
4. Diagnostic infrastructure cannot create a security verdict.
5. Diagnostic state exposed by this sample is bounded.
6. Service ownership includes cleanup of state created during its lifecycle.

The private framework adds operational controls and detection logic that are not represented by the public examples.
