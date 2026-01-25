---
name: implement-plan
description: Convert a plan document into Claude Code tasks with dependencies. Pure parser that reads plans from context/plans/ and creates executable task workflows.
---

# Implement Plan

Convert plan documents into Claude Code tasks with verification dependencies.

## Flow

1. Resolve plan file (from argument or list available)
2. Read plan from `context/plans/`
3. Parse implementation tasks and verification blocks
4. Create tasks via TaskCreate
5. Set dependencies via TaskUpdate
6. Output summary

## Arguments

```
/implement-plan [plan-filename]
```

- If filename provided: load that plan
- If no filename: list available plans in `context/plans/` and ask user to select

## Parsing Rules

### Task Detection

Each `### Task N:` heading becomes an implementation task.

Extract from each task section:
- **Subject**: The task heading (e.g., "Task 1: Modify Plan.md Template")
- **Description**: Content between heading and verification block
- **Files**: Lines starting with `**Files:**`
- **Verify**: Lines starting with `**Verify:**`
- **Expect**: Lines starting with `**Expect:**`
- **Depends on**: Lines starting with `**Depends on:**`

### Task Creation

For each task, create TWO Claude Code tasks:

**Implementation Task:**
```
TaskCreate:
  subject: "T{N}: {task title}"
  description: |
    {task description}

    **Files:** {files list}
  activeForm: "Implementing {short title}"
```

**Verification Task:**
```
TaskCreate:
  subject: "V{N}: Verify {task title}"
  description: |
    **Verify:** {verify content}
    **Expect:** {expect content}
  activeForm: "Verifying {short title}"
```

### Dependency Setup

After ALL tasks created, set dependencies:

1. Each verification task is blocked by its implementation task:
   ```
   TaskUpdate:
     taskId: {V{N} id}
     addBlockedBy: [{T{N} id}]
   ```

2. If task has `**Depends on:**`, add those as blockers:
   - "Depends on: Task 2" → V{N} is also blocked by V2
   - "Depends on: Task 2, Task 3" → V{N} is blocked by V2 AND V3

## Output

After creating all tasks, run `TaskList` and display summary:

```
Created {X} tasks from plan:

Implementation:
- T1: {subject} (pending)
- T2: {subject} (pending, blocked by V1)
...

Verification:
- V1: {subject} (blocked by T1)
- V2: {subject} (blocked by T2, V1)
...

Run `TaskList` to see full status.
```

## Example

Given plan with:
```markdown
### Task 1: Deploy Network
**Files:** `infra/network.tf`
**Verify:** Network exists and is accessible
**Expect:** `terraform output network_id` returns valid ID

### Task 2: Deploy App
**Files:** `infra/app.tf`
**Verify:** App can reach network
**Expect:** `curl -s http://app/health` returns 200
**Depends on:** Task 1
```

Creates:
- T1: Deploy Network
- V1: Verify Deploy Network (blocked by T1)
- T2: Deploy App (blocked by V1)
- V2: Verify Deploy App (blocked by T2, V1)

## Notes

- Plan document remains the permanent record
- Tasks are session-scoped; re-run this skill for new sessions
- This skill is a pure parser - quality comes from the plan
- If verification block is missing, create implementation task only and warn
