# Transactions

## Key Concepts

Transactions group reads and writes into a logical unit with ACID guarantees. Not all systems need serializability - weaker isolation levels trade safety for performance. Distributed transactions (2PC) are slow and fragile. Saga patterns split work but require compensation logic. Optimistic concurrency (version checks) often beats pessimistic locking for read-heavy workloads.

## Isolation Levels (Know What You're Getting)

| Level | Dirty Reads | Non-Repeatable Reads | Phantom Reads | Write Skew |
|-------|-------------|---------------------|---------------|------------|
| Read Uncommitted | Yes | Yes | Yes | Yes |
| Read Committed | No | Yes | Yes | Yes |
| Repeatable Read | No | No | Maybe | Yes |
| Snapshot Isolation | No | No | No | Yes |
| Serializable | No | No | No | No |

## Refinement Questions

- What isolation level does your database default to? Is that what you actually need?
- Have you tested for write skew scenarios? Two doctors on-call example: can both remove themselves?
- How long do your transactions hold locks? What's the p99 lock duration?
- Are you using SELECT FOR UPDATE where needed? Or relying on implicit locking?
- What's your deadlock handling strategy? Retry with backoff or fail fast?
- For distributed transactions: why 2PC instead of saga? What's the coordinator failure plan?
- Have you profiled transaction aborts? High abort rate signals contention issues
- What happens if a transaction spans multiple services? How do you maintain atomicity?
