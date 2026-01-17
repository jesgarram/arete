# Distributed Systems

## Key Concepts

Strong consistency requires coordination, which adds latency and reduces availability. CAP theorem forces a choice under partition. Network failures are inevitable, not exceptional. Split-brain is the nightmare scenario - detect and handle it explicitly.

## Refinement Questions

- What's your replication topology? Sync or async? Justify the trade-off
- How do you detect and handle split-brain scenarios? What's the resolution strategy?
- What's the failover time when the leader dies? Is that acceptable for your SLA?
- How do you handle conflicting writes in multi-leader or leaderless? Last-write-wins or custom merge?
- What's the consistency guarantee you're actually providing? Can you explain it to users?
- How long until a write is durable? What happens if the node crashes before that?
- What's your strategy for rolling deployments across replicas?
- How do you test partition scenarios? Do you have chaos engineering in place?
