# Storage & Retrieval

## Key Concepts

The fundamental trade-off in storage systems: optimize for reads (B-trees, indexes) or writes (LSM-trees, append-only). Query patterns drive architecture - OLTP needs fast point lookups and transactions, while OLAP needs efficient scans and aggregations. Indexes speed up reads but slow down writes.

## Questions

- Is this a read-heavy or write-heavy workload? What's the ratio?
- Do you need point lookups (get user by ID) or range scans (all orders from January)?
- What query patterns dominate? Simple key-value, complex joins, or analytical aggregations?
- Do you need transactions? What isolation level is actually required?
- Is this OLTP (operational, many small transactions) or OLAP (analytical, large scans)?
- How much data per query? Fetching single records or scanning millions of rows?
- What's the acceptable query latency? Milliseconds, seconds, or minutes?
- Do you need full-text search or just structured queries?
- Are writes batched or do they come in one at a time?
- What happens if a query takes too long? Can you cache, pre-compute, or approximate?
- Do you need to support ad-hoc queries or are access patterns predictable?
- What's the data retention policy? Archive old data or keep everything hot?
