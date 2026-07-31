# Hotel Reservation System

A modern Flask-based web application and management platform for hotel reservations, user bookings, analytics, manager workflows, and dynamic demand-based pricing.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Project Directory Structure](#project-directory-structure)
- [Documentation Index](#documentation-index)
- [Getting Started & Installation](#getting-started--installation)
- [Branching Strategy](#branching-strategy)
- [License](#license)

---

## Project Overview

The Hotel Reservation System provides an end-to-end web platform allowing users to discover properties, explore room categories, reserve rooms, and view personal reservation dashboards. Hotel managers can analyze revenue metrics, monitor property occupancy, manage room availability, and leverage machine learning/data analytics algorithms for dynamic pricing.

---

## Key Features

- **User Authentication & Dashboard**: Seamless login flow, account profile summary, and historical reservation tracking.
- **Interactive Room Reservation**: Real-time room availability verification based on check-in and check-out date ranges.
- **Manager Portal & Workflows**: Manager-specific dashboards showcasing hotel bookings, room performance, and revenue aggregation.
- **Analytics & Demand Forecasting Engine**: Pandas and NumPy data pipelines calculating 7-day moving averages for peak demand identification and dynamic price multiplier application.
- **Special Offers & Discounts**: Curated package promotions with dynamic room discount structures.

---

## Tech Stack

- **Backend**: Python 3.11+, Flask, Flask-CORS
- **Data & Analytics**: Pandas, NumPy, MySQL Connector
- **Database**: MySQL 8.0+
- **Frontend**: HTML5, CSS3, JavaScript (ES6+), Jinja2 Templates

---

## Project Directory Structure

```text
Hotel-Reservation-System/
├── backend/
│   ├── app.py                 # Main Flask server entry point & API endpoints
│   ├── config.py              # Application settings & database connection configs
│   ├── requirements.txt       # Backend dependencies
│   ├── routes/                # Blueprint and route implementations
│   │   └── legacy_routes.py   # Legacy endpoint implementations
│   ├── models/                # Data access models
│   ├── static/                # Static assets (CSS, JS, images)
│   └── templates/             # HTML Jinja2 web templates
├── database/
│   └── hotel_reservation.sql  # MySQL schema dump & initial seed data
├── docs/                      # Technical project documentation
│   ├── API.md                 # REST API reference manual
│   ├── ARCHITECTURE.md        # Technical architecture & entity diagrams
│   ├── CODING_STANDARDS.md    # Code style & development guidelines
│   ├── GIT_WORKFLOW.md        # Git branching strategy & commit conventions
│   └── SECURITY_GUIDELINES.md # Hardening & security best practices
├── frontend/                  # Standalone client-side HTML, CSS, and JS files
│   ├── css/
│   ├── js/
│   └── assets/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── workflows/
├── requirements.txt           # Primary project requirements
├── README.md                  # Project overview & quickstart guide
├── CONTRIBUTING.md            # Contribution summary
├── CHANGELOG.md               # Version history
└── LICENSE                    # Project license
```

---

## Documentation Index

Detailed specifications, guidelines, and reference manuals are located in the [`docs/`](docs/) directory:

- [API Reference Manual](docs/API.md): Endpoint routes, request schemas, parameters, and status codes.
- [Coding Standards & Guidelines](docs/CODING_STANDARDS.md): Python (PEP 8), SQL, JavaScript, and HTML/CSS standards.
- [Git & Branching Workflow](docs/GIT_WORKFLOW.md): Branch naming, Conventional Commits, and Pull Request workflows.
- [Security Guidelines](docs/SECURITY_GUIDELINES.md): Password hashing recommendations, database security, CORS, and SQL injection prevention.
- [System Architecture](docs/ARCHITECTURE.md): Architectural layout, MySQL entity relationships, and demand forecasting pipeline.

---

## Getting Started & Installation

### Prerequisites

- Python 3.11+ installed
- MySQL Server 8.0+ running locally or remotely

### Step-by-Step Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/HarshaReddy112/Hotel-Reservation-System-Web-App.git
   cd Hotel-Reservation-System-Web-App
   ```

2. **Create and Activate Virtual Environment**:
   - **Windows (PowerShell)**:
     ```powershell
     python -m venv .venv
     .\.venv\Scripts\Activate.ps1
     ```
   - **macOS / Linux**:
     ```bash
     python3 -m venv .venv
     source .venv/bin/activate
     ```

3. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   pip install -r backend/requirements.txt
   ```

4. **Initialize Database**:
   - Create a MySQL database named `hotel_db`:
     ```sql
     CREATE DATABASE hotel_db;
     ```
   - Import the schema and baseline data from `database/hotel_reservation.sql`:
     ```bash
     mysql -u root -p hotel_db < database/hotel_reservation.sql
     ```

5. **Run the Application**:
   ```bash
   python backend/app.py
   ```
   The Flask server will start at `http://127.0.0.1:5000`.

---

## Branching Strategy

The repository follows a structured branching model:

- **`main`**: Production-ready branch.
- **`develop`**: Integration branch for active development.
- **`feature/*`**: Feature branches for isolated implementation work.

For detailed branch rules, see [Git & Branching Workflow](docs/GIT_WORKFLOW.md).

---

## License

This project is open source and available under the terms of the [LICENSE](LICENSE).
