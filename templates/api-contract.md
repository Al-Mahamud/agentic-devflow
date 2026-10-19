---
task: T-0000
subtask: 01
service: <vendor name>
base_url: https://api.example.com
auth: <bearer | api-key header | oauth2 client_credentials>
---

# External API — <service> / <operation>

## Endpoint
`POST /v1/<resource>`

## Auth
<header name, token source, rotation, where the secret lives>

## Request
```http
POST /v1/<resource> HTTP/1.1
Authorization: Bearer <token>
Content-Type: application/json
Idempotency-Key: <uuid>
```
```json
{
  "field": "value"
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|

## Success response — 200
```json
{
  "id": "abc123",
  "status": "created"
}
```

## Error responses
| Status | Body | Meaning | Our handling |
|--------|------|---------|--------------|
| 400 | `{"error":"..."}` | validation | surface to user |
| 429 | `{"error":"rate_limited"}` | rate limit | backoff + retry |
| 5xx | | vendor down | retry N times, then queue |

## Operational
- Rate limit:
- Timeout: <ms>   Retries: <n, strategy>
- Idempotent?: <yes/no — how>
- Webhook/callback?: <yes/no>
- Sandbox environment:

## Mapping into our data model
| Vendor field | Our table.column | Transform |
|--------------|------------------|-----------|

## Failure mode
<what the user sees, and what we persist, when this API is unavailable>
