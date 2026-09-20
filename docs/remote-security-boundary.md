# Remote Security Boundary

This sample shows the public shape of a server-owned request boundary without reproducing Guardian's production policy.

## Boundary

```text
untrusted request
      |
      v
structural validation
      |
      v
schema and finite-value checks
      |
      v
server-owned authorization
      |
      +---- reject -> sanitized diagnostic record
      |
      v
validated request
      |
      v
server-owned domain
```

The client supplies a request, not authority. Authorization comes from server-owned context.

Accepted input is rebuilt from validated fields instead of forwarding the original request table. Unknown fields therefore do not become trusted domain input.

Numeric identifiers reject non-finite values such as NaN and positive or negative infinity. Diagnostic provider failures are isolated from the request decision.

## Public evidence

The accompanying tests cover malformed payloads, non-finite numbers, request-shaped authority, unexpected fields and diagnostic provider failure.

This is intentionally not a production validator. Operational budgets, replay handling, sequencing, endpoint-specific policy, correlation and enforcement remain private.
