# Architecture

Guardian's security model starts with ownership.

A Roblox client owns presentation and input. It does not own competitive truth, administrative authority, rewards, or security decisions. Requests entering a trusted domain therefore cross a validation boundary before domain state can change.

```text
Client input
    |
    v
Request boundary
    |
    +-- structural validation
    +-- schema validation
    +-- authorization
    +-- abuse controls
    |
    v
Server-owned domain
    |
    +-- state transition
    +-- bounded diagnostic evidence
    +-- observability
```

## Separation of concerns

Validation answers whether a request may enter the domain.

The domain owns the resulting state transition.

Evidence records a bounded, sanitized description of an event for diagnostics. Evidence is not itself a verdict.

Observability reports system behavior. A telemetry or persistence failure must not manufacture suspicion or change an otherwise valid security decision.

Production Guardian contains additional layers beyond this sample. Their implementation is intentionally outside the public boundary.
