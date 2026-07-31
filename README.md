# Hotel Reservation System

A Flask-based hotel reservation platform for managing users, bookings, analytics, and manager workflows.

## Project Structure

```text
Hotel-Reservation-System/
├── backend/
│   ├── app.py
│   ├── routes/
│   ├── models/
│   ├── static/
│   ├── templates/
│   ├── requirements.txt
│   └── config.py
├── frontend/
│   ├── css/
│   ├── js/
│   └── assets/
├── database/
│   └── hotel_reservation.sql
├── docs/
│   ├── Screenshots/
│   ├── ER_Diagram.png
│   ├── Architecture.png
│   ├── DatabaseSchema.png
│   └── API.md
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── workflows/
├── requirements.txt
├── README.md
├── CONTRIBUTING.md
├── CHANGELOG.md
└── LICENSE
```

## Features

- User login and booking flow
- Room reservation and booking management
- Manager dashboard and analytics endpoints
- SQL schema for hotel reservation data

## Tech Stack

- Python 3.11+
- Flask
- MySQL
- Pandas and NumPy
- HTML, CSS, and JavaScript

## Getting Started

1. Create and activate a virtual environment:
   - `python -m venv .venv`
   - `.venv\Scripts\activate`
2. Install dependencies:
   - `pip install -r requirements.txt`
   - `pip install -r backend/requirements.txt`
3. Create the MySQL database and import the SQL schema:
   - `database/hotel_reservation.sql`
4. Start the Flask app:
   - `python backend/app.py`

## Branching Strategy

- `main`: production-ready code
- `develop`: integration branch for ongoing work
- `feature/*`: new feature branches for upcoming changes
