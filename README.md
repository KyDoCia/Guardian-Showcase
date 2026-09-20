# Guardian Security Framework — Engineering Showcase

Guardian is a private, server-authoritative security framework for Roblox experiences.

This repository contains a deliberately limited engineering sample. It documents selected boundaries, contracts, and failure semantics without publishing the detection logic or operational policy used by the private framework.

The point of this repository is not to distribute an anti-cheat. It is to make a small set of security-engineering claims inspectable.

## Scope

The public sample focuses on a small set of properties:

| Property | Public evidence |
| --- | --- |
| Client authority is not trusted | [Trust model](docs/trust-model.md) |
| Requests cross an explicit validation boundary | [Validation contract](src/Contracts/ValidationResult.luau) and [example validator](src/Demo/ExampleValidator.luau) |
| Diagnostic evidence is bounded and sanitized | [Evidence contract](src/Contracts/Evidence.luau), [sanitizer](src/Infrastructure/Sanitizer.luau), [bounded buffer](src/Infrastructure/BoundedBuffer.luau) |
| Infrastructure failure is contained at the diagnostic boundary | [Failure semantics](docs/failure-semantics.md) and [safe diagnostic sink](src/Infrastructure/SafeDiagnosticSink.luau) |

## Request boundary

```text
untrusted client
      |
      v
validation boundary
  - structure
  - schema
  - authorization
  - abuse controls
      |
      v
server-owned domain
      |
      +-- evidence
      +-- observability
      +-- response boundary
```

The client can request an action. It does not decide whether that action is valid, privileged, or authoritative.

## Repository layout

```text
docs/
  architecture.md
  trust-model.md
  failure-semantics.md

src/
  Contracts/
  Infrastructure/
  Demo/

tests/
  TrustBoundary.spec.luau
  BoundedBuffer.spec.luau
  FailureIsolation.spec.luau
```

The demo code is intentionally generic. It exists to expose the shape of the boundaries described in the documentation, not Guardian's production detection behavior.

## Deliberately excluded

The private implementation is not reproduced here. In particular, this repository does not publish:

- production detection heuristics;
- movement analysis;
- integrity probes or challenge mechanisms;
- operational thresholds, windows, or budgets;
- suspicion scoring or signal-correlation rules;
- enforcement decision policy;
- deployment configuration or production integrations.

These omissions are security boundaries, not unfinished showcase features.

## Review notes

The examples are designed around explicit ownership, bounded state, fail-closed validation at the request boundary, and fail-isolated diagnostics. Tests target those properties directly instead of attempting to simulate Guardian's private detection system.

This repository should be read as an architecture and engineering sample, not as an installable release of Guardian.
