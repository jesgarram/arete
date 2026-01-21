# Distributed Systems

## Key Concepts

Core tension in distributed systems: strong consistency requires coordination (consensus, locking), which adds latency and reduces availability. CAP theorem forces a choice under partition - consistency or availability. Replication provides redundancy but introduces complexity in keeping replicas synchronized. Network failures are inevitable, not exceptional.

## Questions

- What consistency guarantees do users actually need? Can they tolerate stale reads?
- What's the failure mode you're designing for? Node crash, network partition, or Byzantine faults?
- Can you tolerate stale reads? For how long - seconds, minutes, hours?
- Do you need distributed transactions across multiple services?
- What happens during a network partition? Sacrifice availability or consistency?
- Is the system read-heavy or write-heavy? Does that change your replication strategy?
- Do you need leader election or can you use leaderless replication?
- What's more important: low latency or strong guarantees?
- Can you design for eventual consistency and handle conflicts at the application level?
- What's the geographic distribution? Single datacenter, multi-region, or global?
- Do you need synchronous replication (strong consistency) or asynchronous (better performance)?
- How do you detect and handle split-brain scenarios?
