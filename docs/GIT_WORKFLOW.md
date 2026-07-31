# Git & Branching Workflow Guidelines

This document outlines the Git branching strategy, commit conventions, Pull Request (PR) standards, and release management rules for the Hotel Reservation System project.

---

## Table of Contents

1. [Branching Strategy](#branching-strategy)
2. [Branch Naming Conventions](#branch-naming-conventions)
3. [Commit Message Standards](#commit-message-standards)
4. [Pull Request (PR) Process](#pull-request-pr-process)
5. [Release & Tagging](#release--tagging)

---

## Branching Strategy

The repository follows a modified Git Flow strategy:

```text
  main (production)
   ▲
   │ (Release / Hotfix Merge)
  develop (integration)
   ▲
   ├── feature/user-auth
   ├── feature/dynamic-pricing
   └── bugfix/booking-dates-fix
```

### Primary Branches

- **`main`**: Represents the production-ready state of the application. Code in `main` must always be tested, stable, and deployable. Direct commits to `main` are strictly prohibited.
- **`develop`**: Serves as the primary integration branch for ongoing development. All new features and bug fixes target `develop` first.

### Supporting Branches

- **`feature/*`**: Used for developing new features or functionality. Created from `develop` and merged back into `develop`.
- **`bugfix/*`**: Used for addressing non-urgent bugs found during development. Created from `develop` and merged back into `develop`.
- **`hotfix/*`**: Used to quickly fix critical bugs in production. Created from `main` and merged into both `main` and `develop`.

---

## Branch Naming Conventions

All branch names must follow a structured naming pattern with lowercase letters and hyphen separators:

- `feature/<short-description>`: e.g., `feature/manager-analytics`, `feature/room-filtering`
- `bugfix/<short-description>`: e.g., `bugfix/sql-connection-leak`, `bugfix/invalid-date-picker`
- `hotfix/<short-description>`: e.g., `hotfix/login-auth-bypass`
- `docs/<short-description>`: e.g., `docs/update-api-spec`

---

## Commit Message Standards

Commit messages must be concise, descriptive, and follow the **Conventional Commits** format:

```text
<type>(<scope>): <short summary>

[optional body]
```

### Allowed Types

- `feat`: A new feature added to the application.
- `fix`: A bug fix.
- `docs`: Documentation updates only.
- `style`: Formatting, missing semi-colons, white-space changes (no functional code changes).
- `refactor`: Code restructuring without changing external behavior or adding features.
- `test`: Adding missing tests or refactoring existing unit tests.
- `chore`: Updating build scripts, package dependencies, or configuration.

### Examples

```bash
git commit -m "feat(api): add peak demand forecasting endpoint"
git commit -m "fix(auth): handle missing password parameter gracefully"
git commit -m "docs(readme): add detailed database setup steps"
```

---

## Pull Request (PR) Process

1. **Create Branch**: Create a feature or bugfix branch from `develop`.
2. **Local Testing**: Verify all application features, Flask routes, and database interactions locally.
3. **Open Pull Request**:
   - Target branch: `develop` (unless it's a `hotfix` targeting `main`).
   - Title: Short descriptive title matching conventional commits format.
   - Fill out the PR template provided in `.github/PULL_REQUEST_TEMPLATE.md`.
4. **Code Review**: At least one peer review approval is required prior to merging.
5. **Merge Strategy**: Use **Squash and Merge** or **Rebase and Merge** to maintain a clean linear history on `develop`.

---

## Release & Tagging

- When a milestone is reached on `develop`, create a release PR into `main`.
- Once merged to `main`, tag the commit using Semantic Versioning (`vX.Y.Z`):
  ```bash
  git tag -a v1.1.0 -m "Release v1.1.0: Added Manager Analytics & Dynamic Pricing"
  git push origin v1.1.0
  ```
