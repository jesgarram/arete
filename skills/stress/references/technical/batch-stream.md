# Batch & Stream Processing

## Key Concepts

Processing data at rest (batch) vs in motion (stream). Batch optimizes for throughput, stream for latency. Lambda architecture combines both but doubles complexity. Exactly-once semantics are hard - most systems offer at-least-once with idempotent consumers.

## Refinement Questions

- How do you handle late-arriving data? What's the allowed lateness window?
- What's your windowing strategy: tumbling, sliding, or session? Why that choice?
- How do you replay events when business logic changes? Full reprocess or incremental?
- What's the backpressure strategy when consumers fall behind?
- Is exactly-once worth the performance cost, or can you make processing idempotent?
- What's the checkpoint interval? Too short = overhead, too long = reprocessing on failure
- How do you handle schema evolution in your event format?
- What happens if the stream source goes down? Failover or dead letter queue?
