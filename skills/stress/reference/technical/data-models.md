# Data Models & Encoding

## Key Concepts

Schema evolution determines system flexibility. Adding required fields breaks backward compatibility. Removing fields breaks forward compatibility. Field numbers in Protobuf are forever - never reuse them. Denormalization trades write complexity for read performance.

## Refinement Questions

- What happens when you add a required field? Have you tested the migration path?
- Are your Protobuf/Avro field numbers stable? Do you have a governance process?
- How do you handle schema migrations in production with zero downtime?
- What's your API versioning strategy: URL, header, or content negotiation? Why?
- Is this denormalization worth the write complexity? Show me the read pattern that justifies it
- What's the maximum acceptable migration time? How do you handle if it exceeds that?
- Do you have rollback scripts for every migration? Tested?
- What happens to in-flight requests during schema changes?
