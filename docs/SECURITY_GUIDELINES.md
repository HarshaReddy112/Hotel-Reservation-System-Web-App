# Security Guidelines & Best Practices

This document details the security policies, hardening guidelines, and recommended practices for securing the Hotel Reservation System application.

---

## Table of Contents

1. [Authentication & Password Hardening](#authentication--password-hardening)
2. [Database Connection Security](#database-connection-security)
3. [SQL Injection Prevention](#sql-injection-prevention)
4. [Cross-Origin Resource Sharing (CORS)](#cross-origin-resource-sharing-cors)
5. [Input Sanitization & Validation](#input-sanitization--validation)
6. [Session & State Security](#session--state-security)
7. [Security Audit Checklist](#security-audit-checklist)

---

## Authentication & Password Hardening

### Password Storage Upgrade Recommendation
- **Current State**: Passwords in the `USERS` and `MANAGER` tables are currently stored in plain text.
- **Mandatory Hardening Goal**: Transition all password storage to salted password hashing algorithms using `Werkzeug` (`generate_password_hash`, `check_password_hash`) or `bcrypt`.

#### Recommended Password Verification Logic
```python
from werkzeug.security import generate_password_hash, check_password_hash

# When registering a user:
hashed_password = generate_password_hash(raw_password, method='scrypt')

# When verifying login:
if user and check_password_hash(user['Password'], entered_password):
    # Proceed with authenticated session
```

---

## Database Connection Security

### Environment Variable Isolation
- **Current State**: Database credentials (e.g. `user="root"`, `password="tiger"`) are hardcoded in `backend/app.py` and `backend/routes/legacy_routes.py`.
- **Security Rule**: Move all database configuration parameters into environment variables using `python-dotenv`.

#### Recommended `backend/config.py` Configuration
```python
import os
from dotenv import load_dotenv

load_dotenv()

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "")
DB_NAME = os.getenv("DB_NAME", "hotel_db")
```

- Add `.env` to `.gitignore` so secrets are never committed to version control.

---

## SQL Injection Prevention

- Use parameterized queries (`%s` placeholders) for every database operation.
- Do not construct SQL queries via `eval()`, string format (`%`), or f-strings.
- For dynamic SQL queries involving table lists or `IN` clauses, build placeholders safely:

```python
# GOOD: Dynamic parameter placeholders
format_strings = ",".join(["%s"] * len(hotel_names))
query = f"SELECT * FROM BOOKINGS WHERE hotel IN ({format_strings})"
cursor.execute(query, tuple(hotel_names))
```

---

## Cross-Origin Resource Sharing (CORS)

- Current global CORS enablement (`CORS(app)`) allows all origins (`*`).
- For production deployments, restrict CORS origins to trusted frontend domains:

```python
CORS(app, origins=["https://your-hotel-frontend-domain.com"])
```

---

## Input Sanitization & Validation

- Validate type, length, and presence of all user inputs before querying the database or passing inputs to system services.
- Ensure date strings (`check_in`, `check_out`) follow strict format standards (`YYYY-MM-DD`) and that `check_out` occurs after `check_in`.
- Cast integer inputs explicitly (e.g., `user_id_int = int(user_id)`) inside `try/except ValueError` blocks to protect against invalid data types.

---

## Session & State Security

- Keep user tokens or session identifiers securely stored on the client side (e.g., `HttpOnly`, `Secure`, `SameSite=Strict` cookies or session storage).
- Implement role-based access checks so that regular users cannot invoke manager-specific endpoints (e.g., `/manager/bookings`, `/manager/dashboard`).

---

## Security Audit Checklist

Before releasing updates to staging or production:

- [ ] Ensure `.env` is listed in `.gitignore`.
- [ ] Confirm no database credentials or API keys are committed in source code.
- [ ] Verify parameterized SQL queries across all route files.
- [ ] Check HTTP response status codes for failed authentication (`401 Unauthorized`, `400 Bad Request`).
- [ ] Validate CORS configurations for targeted environment domains.
