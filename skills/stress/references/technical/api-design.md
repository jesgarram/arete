# API Design

## Key Concepts

APIs are contracts. Breaking changes are expensive. Backwards-compatible changes (adding fields, new endpoints) are safe; removing or renaming is not. Version when you must, deprecate gracefully. Test from the consumer's perspective — your internal model doesn't matter if the API is confusing.

## Refinement Questions

- What happens when you need to change a field type or remove a field? Show me the migration path
- How do consumers discover your API? Documentation, SDK, or trial-and-error?
- What's the latency budget for your most critical endpoint? What happens when it's exceeded?
- How do you test backwards compatibility? Do you have contract tests?
- What's the blast radius of deploying a breaking change? How many consumers break?
- How do you handle a consumer that sends 100x expected traffic? Rate limit, queue, or fail?
- What's the retry strategy for failed API calls? Exponential backoff with jitter?
- How do you handle partial responses when one downstream service fails but others succeed?
