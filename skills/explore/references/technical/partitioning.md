# Partitioning

## Key Concepts

Splitting data across multiple nodes for horizontal scalability. The partition key determines data distribution - good keys spread data evenly, bad keys create hot spots. Partitioning enables parallel processing but complicates queries that span partitions. Rebalancing partitions is operationally complex and can impact performance.

## Questions

- What's the natural partition key? User ID, tenant ID, timestamp, geography?
- Do you need range queries across partitions or just point lookups within a partition?
- What's the expected data distribution? Uniform or skewed? Any power users?
- How many partitions do you anticipate needing? Starting count vs 5-year projection?
- Do certain partitions get more traffic than others? Hot tenants, popular items?
- Can queries be satisfied from a single partition or do they need to scatter-gather?
- What happens when you need to add or remove partitions? Can you rebalance?
- Is the partition key immutable or can records move between partitions?
- Do you need secondary indexes? Local (per-partition) or global (cross-partition)?
- What's the partition size limit? When does a partition split?
- Can you tolerate cross-partition transactions or do you need single-partition atomicity?
- How do you route requests to the right partition? Client-side or proxy?
