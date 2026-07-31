# Coding Standards & Guidelines

This document outlines the coding standards, code style, structural patterns, and quality practices for the Hotel Reservation System repository. All contributors are expected to adhere to these guidelines when making modifications or adding new features.

---

## Table of Contents

1. [Backend Development (Python & Flask)](#backend-development-python--flask)
2. [Database Standards (SQL & MySQL)](#database-standards-sql--mysql)
3. [Frontend Development (HTML, CSS & JavaScript)](#frontend-development-html-css--javascript)
4. [Error Handling & API Responses](#error-handling--api-responses)
5. [Code Formatting & Linting](#code-formatting--linting)

---

## Backend Development (Python & Flask)

### Code Style (PEP 8)
- Follow standard [PEP 8](https://peps.python.org/pep-0008/) style guidelines for code structure, variable naming, and indentation.
- Use **4 spaces** per indentation level. Do not use tabs.
- Function and variable names must use `snake_case` (e.g., `predict_peak_dates()`, `user_id_int`).
- Class names must use `PascalCase` (e.g., `BookingModel`).
- Constant names must use uppercase `SNAKE_CASE` (e.g., `PAGE_TEMPLATES`).

### Flask Route Definitions
- Define explicit HTTP methods on all endpoints using the `methods` parameter (e.g., `@app.route("/login", methods=["POST"])`).
- Keep route handler functions modular. Heavy business logic or analytical computations should be abstracted into helper functions (e.g., `get_bookings_df()`, `predict_peak_dates()`).
- Always validate incoming payload parameter presence before processing (e.g., `request.json`, `request.args`).

### Parameterized Database Queries
- **Never** perform string formatting or concatenation when building SQL queries with user inputs.
- Always use parameterized queries with placeholder syntax `%s` provided by `mysql.connector`.

```python
# GOOD: Parameterized query prevents SQL Injection
cursor.execute("SELECT * FROM USERS WHERE Name = %s", (username,))

# BAD: Vulnerable to SQL Injection
cursor.execute(f"SELECT * FROM USERS WHERE Name = '{username}'")
```

---

## Database Standards (SQL & MySQL)

### Naming Conventions
- Table names must be plural or entity-focused in uppercase or lowercase depending on schema declaration (`users`, `hotels`, `manager`, `rooms`, `bookings`).
- Column names should use consistent casing (`userID`, `Name`, `check_in`, `check_out`, `price`, `user_id`).
- Primary Keys must be explicitly designated on each table. Foreign Key references must define clear constraint names and target tables (e.g., `CONSTRAINT bookings_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (userID)`).

### Transactions & Commits
- Explicitly call `db.commit()` after mutating statements (`INSERT`, `UPDATE`, `DELETE`).
- Wrap multi-statement transactional operations (e.g., inserting a reservation while incrementing user and hotel booking counters) inside `try/except` blocks to handle MySQL errors cleanly.

---

## Frontend Development (HTML, CSS & JavaScript)

### HTML & Structure
- Use standard HTML5 semantic elements (`<header>`, `<nav>`, `<main>`, `<section>`, `<footer>`).
- Assign unique and descriptive `id` attributes to interactive DOM elements to support API integration and browser testing.

### CSS Styling
- Maintain styling separation using modular CSS stylesheets in `frontend/css/` or embedded style blocks.
- Prefer CSS variable definitions for key colors, fonts, and layout spacing tokens.
- Ensure responsive UI designs using flexbox and grid layouts.

### JavaScript Standards
- Write ES6+ JavaScript. Use `const` and `let` instead of `var`.
- Use `async/await` or standard `fetch()` Promises for asynchronous API calls.
- Always check `response.ok` or inspect JSON `success` flags when handling backend responses.

```javascript
// Example API Fetch Standard
async function fetchOffers() {
  try {
    const response = await fetch('/offers');
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    const offers = await response.json();
    renderOffers(offers);
  } catch (error) {
    console.error('Failed to load offers:', error);
  }
}
```

---

## Error Handling & API Responses

### Consistent JSON Response Structure
All JSON API endpoints must return structured JSON payloads with meaningful HTTP status codes:

- **200 OK**: Successful GET request or standard operation response.
- **201 Created**: Successful creation of a new resource.
- **400 Bad Request**: Missing parameters or invalid request format.
- **401 Unauthorized**: Authentication failure (e.g., incorrect password).
- **404 Not Found**: Target resource or user not found.
- **500 Internal Server Error**: Uncaught database or server exceptions.

#### Standard Response Format
```json
{
  "success": true,
  "message": "Operation completed successfully",
  "data": {}
}
```

---

## Code Formatting & Linting

Before pushing code changes:
1. Run a Python linter (e.g. `flake8` or `black`) to ensure style conformance.
2. Check JavaScript files for syntax errors using `eslint` or browser devtools console checks.
3. Validate HTML structure using standard HTML validation tools.
