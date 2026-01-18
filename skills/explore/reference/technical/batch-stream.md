# Batch & Stream Processing

## Key Concepts

Processing data at rest (batch) versus in motion (stream). Batch optimizes for throughput and handles large datasets efficiently. Stream processing optimizes for latency and handles continuous data flows. Lambda architecture combines both - stream for real-time, batch for corrections. Exactly-once semantics are hard in distributed stream processing.

## Questions

- Is batch processing acceptable or do you need real-time/near-real-time results?
- What's the latency requirement? Minutes, seconds, or sub-second?
- What's the data source? Database CDC, API events, file uploads, or message queue?
- Do you need exactly-once processing or is at-least-once acceptable?
- What happens if a message is processed twice? Is it idempotent?
- What's the downstream consumer? Analytics warehouse, ML model, or operational system?
- Do you need windowing (tumbling, sliding, session)? What's the window size?
- Can you tolerate out-of-order events or do you need strict ordering?
- What's the event volume? Hundreds per second or millions?
- Do you need to join streams or enrich events with reference data?
- How do you handle late-arriving data? Drop it, reprocess, or maintain extended windows?
- What's the failure recovery strategy? Replay from checkpoint or dead-letter queue?
