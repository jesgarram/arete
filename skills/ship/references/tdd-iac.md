# IaC Verification Reasoning

Guide for generating **Verify:**/**Expect:** fields in IaC plans. Focus: **integration errors that pass `terraform apply` but fail at runtime**.

---

## Core Principle

> **Test what the runtime consumer will do, from where they'll do it, with the identity they'll use.**

`terraform apply` succeeding ≠ system works. Test the integration, not the component.

---

## Derive Tests with 5 Questions

| Question | Derives |
|----------|---------|
| **WHO** consumes this resource? | Test context (container, VM, function, external service) |
| **FROM WHERE?** | Network context (VNet, subnet, public internet) |
| **WITH WHAT** identity? | Auth context (managed identity, service principal, key) |
| **WHAT** operation? | The actual test (not a proxy like ping) |
| **THROUGH WHAT** path? | Each hop: DNS → network → auth → operation |

### Example Derivation

Task: "Deploy Container App with Key Vault secrets"

1. WHO = Container App runtime
2. FROM = Container Apps subnet (10.x.x.x)
3. WITH = Managed Identity attached to app
4. WHAT = Read secret value at startup
5. THROUGH = App → Private DNS → Key Vault PE → RBAC → secret

→ **Verify:** `az containerapp exec --command "printenv SECRET_NAME"`
→ **Expect:** Returns secret value (not empty, not error)

---

## Test Chain (in order)

Each layer can pass while the next fails. Verify all:

```
EXISTENCE  → Resource created?
NETWORK    → Consumer can reach it? (not just "it exists")
DNS        → FQDN resolves correctly from consumer's network?
IDENTITY   → Consumer has credentials attached?
AUTHZ      → Credentials have required permissions?
OPERATION  → Actual operation succeeds? (not just connection)
```

For **Depends on:** — reference earlier tasks that must pass before this verification is meaningful.

---

## Anti-Patterns

| Wrong | Right |
|-------|-------|
| Test from your laptop | Test from consumer's network context |
| `nc -zv host port` | Actual operation the app performs |
| Verify resource exists | Verify consumer can use it |
| `nslookup` from public DNS | `nslookup` from inside VNet |
| Check RBAC assignment exists | Check operation succeeds with identity |
| Secret exists in Key Vault | Secret injected into env AND valid format |

---

## Boundary Heuristics

Cross-boundary = explicit test:

| Boundary | Verify |
|----------|--------|
| Subnet → Subnet | NSG allows traffic both directions |
| VNet → Private Endpoint | DNS resolves to private IP, not public |
| Subscription → Subscription | RBAC assigned in target subscription |
| Public → Private | Full ingress path (LB/Gateway → internal) |
| App → External Service | Network + auth + operation (all three) |

---

## Common Failure Patterns

Use these to inform what to test, not as copy-paste commands:

| Pattern | Symptom | Test Focus |
|---------|---------|------------|
| **Private Endpoint DNS** | Timeout, connection refused | Resolve FQDN from consumer subnet |
| **NSG/Firewall** | Connection refused | Connectivity from source to dest:port |
| **RBAC propagation** | 403 immediately after deploy | Retry with delay, or wait before verify |
| **Secret format** | App crashes on parse | Validate format (JSON, connection string) |
| **Identity not attached** | 401 at runtime | Check identity exists on consumer resource |
| **Health probe mismatch** | Backend marked unhealthy | Probe path returns 200 within timeout |
| **Cross-sub RBAC** | 403 on remote resource | Assignment exists in target subscription |
| **Service vs Private Endpoint** | Routing confusion | Verify which endpoint type is used |

---

## Verification Field Format

```markdown
**Verify:** [Executable command preferred, prose if command not possible]
**Expect:** [Specific success criteria - exit code, output content, absence of errors]
**Depends on:** [Earlier tasks whose V{N} must pass first]
```

### Good Examples

```markdown
**Verify:** `az containerapp exec --name app -g rg --command "curl -sf http://api:8080/health"`
**Expect:** Returns 200 with `{"status": "healthy"}`
**Depends on:** Task 1 (network), Task 2 (API deployment)
```

```markdown
**Verify:** `az keyvault secret show --vault-name myvault -n mysecret --query value -o tsv`
**Expect:** Returns valid JSON (not empty, not error)
**Depends on:** VPN connected (for private Key Vault)
```

---

## Integration with Plan Tasks

When a task involves IaC:

1. **Derive** verification using the 5 questions
2. **Order** tests by the test chain (existence → operation)
3. **Set dependencies** so V{N} only runs after prerequisite V{M} passes
4. **Prefer commands** over prose — executable verification is unambiguous
