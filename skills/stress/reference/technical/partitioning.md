# Partitioning

## Key Concepts

The partition key determines data distribution and query efficiency. Hot partitions kill scalability. Rebalancing during growth is operationally expensive. Scatter-gather queries don't scale - design for single-partition access patterns.

## Refinement Questions

- What happens when one partition grows 10x larger than others? Show me the rebalancing plan
- How do you rebalance without downtime? What's the impact on read/write latency during rebalancing?
- Can queries be satisfied by a single partition or require scatter-gather? What percentage?
- What's your strategy for time-series data? Time-based partitions get cold - how do you handle?
- What's the partition key? Why that field? What access patterns does it optimize for?
- What happens when the hot user/tenant arrives? Celebrity problem solved?
- How many partitions do you start with? How do you add more later?
- What's the data locality story? Can related data land on the same partition?
