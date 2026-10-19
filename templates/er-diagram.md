---
task: T-0000
subtask: 01
---

# ER — <what changes>

## Diagram
```mermaid
erDiagram
    USERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_ITEMS : contains
    ORDERS {
        uuid id PK
        uuid user_id FK
        string status
        timestamptz confirmed_at "nullable"
    }
```
> Existing tables in plain style, NEW/CHANGED tables noted below. Never draw a new table without its neighbours.

## What is new or changed
| Table | New/Changed | Columns | Constraints | Indexes |
|-------|-------------|---------|-------------|---------|

## Relationships to existing schema
| From | To | Cardinality | FK / join column | Source of truth |
|------|----|-------------|------------------|-----------------|

## Migration
- Forward:
- Backfill of existing rows:
- Reversible?:
- Downtime / lock risk:

## Source
Existing schema read from `memory/data-model/<file>.md`.
