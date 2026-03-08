# API Design

## Key Concepts

APIs are contracts. Breaking changes are expensive — consumers build against your interface, not your implementation. The tension: stability (don't break clients) vs evolution (the domain will change). Backwards-compatible changes are safe; breaking changes need versioning strategy. Design for the consumer's mental model, not your internal architecture.

## Questions

- Who are the consumers? Internal services, third-party developers, or both?
- What's the communication pattern? Request-response, event-driven, or streaming?
- REST, GraphQL, gRPC, or message queue? What does the consumer experience need?
- How will you handle versioning? URL path, header, or never-break-the-contract?
- What's the backwards compatibility strategy? Additive-only changes or explicit deprecation?
- What does the error contract look like? Structured error codes or just HTTP status?
- How do you handle pagination? Offset, cursor, or keyset?
- What's the rate limiting strategy? Per-client, per-endpoint, or global?
- Do consumers need real-time updates or is polling acceptable?
- What's the authentication model? API keys, OAuth, mTLS, or service mesh?
- How do you handle partial failures in composed API calls?
- What happens when a downstream dependency is slow or unavailable?
