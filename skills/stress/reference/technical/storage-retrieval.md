# Storage & Retrieval

## Key Concepts

The fundamental trade-off: optimize for reads (B-trees) or writes (LSM-trees). Indexes speed reads but slow writes. Covering indexes avoid heap lookups. Working set must fit in RAM or performance cliffs. Compaction/vacuuming is unavoidable overhead.

## Refinement Questions

- What indexes exist? Are they covering or require heap lookups?
- What's the write amplification of your storage engine choice? Acceptable?
- How does your DB handle compaction/vacuuming? Scheduled or continuous?
- What happens when the working set exceeds RAM? Have you tested this scenario?
- What's the index maintenance cost during high write loads?
- Do you have query plans documented for your critical paths? What's the worst one?
- What's your backup strategy? How long to restore? Tested recently?
- How do you handle index bloat over time? Rebuild strategy?
