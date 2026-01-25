# Application Logic Testing Reasoning

Guide for generating **Verify:**/**Expect:** fields for application correctness. Focus: **code that compiles but behaves incorrectly at runtime**.

---

## Core Principle

> **Test behavior, not implementation. Test from the caller's perspective.**

Code compiling ≠ code correct. Test what it does, not how it does it.

---

## When to Add Application Tests

| Signal in Plan | Test Type Needed |
|----------------|------------------|
| New function/method | Unit test for behavior |
| New API endpoint | Contract test for request/response |
| Business rule implementation | Behavior test with edge cases |
| Data transformation | Input/output validation |
| Error handling added | Error path tests |
| Integration with external service | Integration test with mocks |

---

## Derive Tests with 5 Questions

| Question | Derives |
|----------|---------|
| **WHAT** behavior? | The unit under test (function, method, endpoint) |
| **WHEN** success? | Happy path: valid inputs → expected outputs |
| **WHEN** failure? | Error cases: invalid inputs → expected errors |
| **WHERE** boundaries? | Edge cases: empty, null, zero, max, min, off-by-one |
| **WHAT'S** isolated? | Dependencies to mock (DB, API, time, randomness) |

### Example Derivation

Task: "Implement `calculateDiscount(cart, userTier)` function"

1. WHAT = calculateDiscount returns discount percentage
2. WHEN success = gold user with $100 cart → 15% discount
3. WHEN failure = negative cart total → throws InvalidCartError
4. WHERE boundaries = empty cart (0%), exactly $50 threshold, tier boundaries
5. WHAT'S isolated = None (pure function)

→ Tests:
- `test_gold_user_gets_15_percent_on_100_dollar_cart`
- `test_silver_user_gets_10_percent_on_100_dollar_cart`
- `test_empty_cart_returns_zero_discount`
- `test_negative_total_throws_invalid_cart_error`
- `test_exactly_50_dollar_threshold_applies_discount`

---

## Test Structure

Use Arrange-Act-Assert (AAA) or Given-When-Then:

```
ARRANGE  → Set up inputs, mocks, preconditions
ACT      → Call the function/method under test
ASSERT   → Verify outputs, side effects, state changes
```

Keep each test focused on ONE behavior. Multiple asserts = multiple tests.

---

## Failure Patterns

| Pattern | Symptom | Test Focus |
|---------|---------|------------|
| **Missing edge case** | Bug on unusual input | Boundary values, empty/null states |
| **Untested error path** | Unhandled exception crashes app | Invalid inputs, error conditions |
| **Wrong error type** | Caller can't handle error properly | Specific exception types, error messages |
| **Off-by-one** | Boundary logic wrong | Exactly-at-threshold values |
| **Null/undefined leak** | TypeError in production | Null inputs, missing fields |
| **State mutation** | Side effects leak between calls | Isolation, fresh state per test |
| **Race condition** | Flaky behavior under concurrency | Async handling, ordering |
| **Time dependency** | Test fails at midnight/new year | Mock time, deterministic dates |

---

## Edge Case Heuristics

For any input, test these boundaries:

| Type | Edge Cases |
|------|------------|
| **Numbers** | 0, 1, -1, MAX_INT, MIN_INT, NaN, Infinity |
| **Strings** | "", " ", null, unicode, very long, special chars |
| **Arrays/Lists** | [], [one], [many], null, duplicates |
| **Objects** | {}, null, missing keys, extra keys |
| **Dates** | now, epoch, far future, leap year, DST transition |
| **Booleans** | true, false, null, truthy/falsy values |

Don't test all combinations - test boundaries that matter for the behavior.

---

## Isolation Principles

| Dependency | How to Isolate |
|------------|----------------|
| Database | In-memory DB, repository mock, fixtures |
| External API | HTTP mock, fake client, recorded responses |
| Time | Inject clock, mock `Date.now()`, freeze time |
| Randomness | Seed RNG, inject random source |
| File system | In-memory FS, temp directories, mock |
| Environment | Inject config, mock env vars |

**Rule**: If a test can fail because of external state, isolate it.

---

## Test Types

| Type | Tests | Speed | Isolation |
|------|-------|-------|-----------|
| **Unit** | Single function/method | Fast (ms) | Full (all deps mocked) |
| **Integration** | Components together | Medium (s) | Partial (real DB, mock external APIs) |
| **Contract** | API request/response | Medium | Mock consumer/provider |
| **E2E** | Full user flow | Slow (min) | None (real everything) |

**Pyramid**: Many unit → Some integration → Few E2E

---

## Verification Field Format

```markdown
**Verify:** [Test command or description]
**Expect:** [Specific behavior - outputs, errors, state changes]
**Depends on:** [Implementation task that must complete first]
```

### Good Examples

```markdown
**Verify:** `pytest tests/test_discount.py -v`
**Expect:** All tests pass, covers happy path + empty cart + invalid input
**Depends on:** Task 1 (implement calculateDiscount)
```

```markdown
**Verify:** `npm test -- --grep "UserService"`
**Expect:** Tests cover: create user, duplicate email error, missing required fields
**Depends on:** Task 2 (implement UserService)
```

```markdown
**Verify:** Test that `parseConfig` handles missing optional fields
**Expect:** Returns defaults for missing fields, throws for missing required fields
**Depends on:** Task 3 (implement parseConfig)
```

---

## Anti-Patterns

| Anti-Pattern | Problem | Fix |
|--------------|---------|-----|
| **Test the mock** | Verifies mock was called, not behavior | Assert on outputs, not internals |
| **Implementation coupling** | Tests break on refactor | Test public API, not private methods |
| **Shared mutable state** | Tests affect each other | Fresh fixtures per test |
| **Test data in code** | Hard to understand test intent | Named fixtures, builder patterns |
| **Commented-out tests** | Hidden test debt | Delete or fix, never comment |
| **Flaky tests** | Erode trust in suite | Fix immediately or quarantine |

---

## Test Naming

Name tests by behavior, not method:

| Bad | Good |
|-----|------|
| `test_calculate_discount` | `test_gold_user_gets_15_percent_discount` |
| `test_validate` | `test_rejects_email_without_at_symbol` |
| `test_process_order` | `test_out_of_stock_item_throws_inventory_error` |

Pattern: `test_[condition]_[expected_behavior]`

---

## Integration with Plan Tasks

Application verification tasks should:

1. **Follow implementation** — test task depends on implementation task
2. **Specify behaviors to cover** — not just "write tests"
3. **Include edge cases** — at least happy path + one error + one boundary
4. **Be runnable** — prefer executable test commands over prose
