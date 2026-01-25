# Load Testing Reasoning

Guide for generating **Verify:**/**Expect:** fields for capacity verification. Focus: **systems that work under light load but fail at production traffic**.

---

## Core Principle

> **Test at expected production load before production traffic arrives.**

Integration passing ≠ capacity sufficient. Test the ceiling, not just the floor.

---

## When to Load Test

Only after integration tests pass. Load testing a broken integration wastes time.

| Signal in Plan | Indicates Load Test Needed |
|----------------|---------------------------|
| Autoscaling rules | Verify scaling triggers correctly |
| SKU/tier selection | Verify throughput within limits |
| Connection pools, rate limits | Verify no exhaustion at concurrency |
| Timeout configurations | Verify latency under load |
| Replica min/max settings | Verify scaling range is sufficient |
| Throughput units (RU, TPM, DTU) | Verify no throttling at expected rate |

---

## Derive Load Tests with 5 Questions

| Question | Derives |
|----------|---------|
| **WHO** generates load? | Traffic source (users, batch jobs, other services, events) |
| **HOW MUCH?** | Concurrency, requests/sec, data volume, burst patterns |
| **WHAT BREAKS?** | Failure mode (429s, timeouts, OOM, cold starts, connection exhaustion) |
| **WHAT SCALES?** | Scaling dimension (replicas, throughput units, connections) |
| **WHAT'S THE CEILING?** | Hard limits (SKU max, quota, max replicas, rate limits) |

### Example Derivation

Task: "Configure Container App autoscaling (min 5, max 30, HTTP concurrency 50)"

1. WHO = End users via API Gateway
2. HOW MUCH = 500 concurrent users, 100 req/sec sustained
3. WHAT BREAKS = 5xx errors if replicas don't scale, timeouts if cold start slow
4. WHAT SCALES = Container App replicas (5 → 30)
5. CEILING = 30 replicas max, need ~10 at 500 concurrent (50 per replica)

→ **Verify:** `hey -n 10000 -c 500 https://app/api/endpoint`
→ **Expect:** Replicas scale to 10+, 0% 5xx, p95 < 3s

---

## Failure Modes

| Mode | Symptom | Test Focus |
|------|---------|------------|
| **Throttling** | 429 responses | Requests/sec at expected rate |
| **Timeout** | 504, client timeout | p95/p99 latency under load |
| **OOM/Crash** | 503, pod restarts | Memory pressure at sustained load |
| **Cold start** | First-request latency spike | Scale-from-zero or scale-up latency |
| **Connection exhaustion** | Connection refused after N requests | Concurrent connections at peak |
| **Scaling too slow** | Errors during ramp-up | Time-to-scale vs traffic ramp rate |
| **Scaling ceiling** | Errors at max replicas | Load beyond max capacity |

---

## Load Test Tools

Use what fits. The reasoning matters, not the tool.

| Tool | Use Case |
|------|----------|
| `hey` | Quick HTTP load test, simple concurrency |
| `k6` | Scripted scenarios, ramp patterns, thresholds |
| `locust` | Python-based, complex user flows |
| `ab` | Simple Apache benchmark |
| `wrk` | High-throughput HTTP benchmarking |
| `artillery` | YAML-based, CI-friendly |

---

## Metrics to Verify

| Metric | Healthy | Unhealthy |
|--------|---------|-----------|
| Error rate (5xx) | < 0.1% | > 1% |
| Throttle rate (429) | 0% at expected load | Any 429s below ceiling |
| p95 latency | Within SLA | > SLA threshold |
| p99 latency | < 2x p95 | >> p95 (tail latency issue) |
| Replica count | Scales proportionally | Hits max or doesn't scale |
| Cold start time | < acceptable threshold | Causes timeout on first request |

---

## Verification Field Format

```markdown
**Verify:** Load test at [concurrency] for [duration]
**Expect:** [Metric thresholds] (e.g., 0% 5xx, p95 < 2s, replicas stay below max)
**Depends on:** All integration tasks (V1, V2, ... must pass first)
```

### Good Examples

```markdown
**Verify:** `hey -n 10000 -c 200 -q 100 https://api.example.com/endpoint`
**Expect:** 0% 5xx errors, p95 < 500ms, no 429s
**Depends on:** Task 1-4 (integration verified)
```

```markdown
**Verify:** `k6 run --vus 100 --duration 2m load-test.js`
**Expect:** Replicas scale from 5 to 15+, error rate < 0.1%
**Depends on:** Task 3 (autoscaling configured)
```

```markdown
**Verify:** Monitor CosmosDB metrics during load test
**Expect:** RU consumption < 80% of provisioned, 0 throttled requests
**Depends on:** Task 2 (CosmosDB capacity configured)
```


---

## Load Test Patterns

### Ramp-Up Test
Gradually increase load to find breaking point.
```
**Verify:** Ramp from 10 to 500 concurrent users over 5 minutes
**Expect:** Error rate stays < 0.1% until 400 users, identifies scaling ceiling
```

### Sustained Load Test
Hold at expected production load.
```
**Verify:** Hold 200 concurrent users for 10 minutes
**Expect:** No degradation over time (memory leaks, connection exhaustion)
```

### Spike Test
Sudden traffic burst.
```
**Verify:** Spike from 50 to 500 users in 10 seconds
**Expect:** Recovers within 30s, scale-up handles burst
```

### Soak Test
Extended duration at moderate load.
```
**Verify:** Run at 50% expected load for 1 hour
**Expect:** No memory growth, no connection leaks, stable latency
```

---

## Integration with Plan Tasks

Load verification tasks should:

1. **Come last** — after all integration tasks verified
2. **Specify concurrency and duration** — not just "run load test"
3. **Define success metrics** — error rate, latency percentiles, scaling behavior
4. **Reference integration dependencies** — V{N} for all prerequisite verifications
