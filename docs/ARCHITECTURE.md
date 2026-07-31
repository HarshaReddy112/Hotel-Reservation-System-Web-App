# System Architecture & Technical Specifications

This document describes the high-level architecture, module breakdown, data models, analytical pipelines, and component relationships of the Hotel Reservation System application.

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Component Diagram](#component-diagram)
3. [Database Relational Architecture](#database-relational-architecture)
4. [Analytics & Demand Forecasting Engine](#analytics--demand-forecasting-engine)
5. [Frontend Architecture](#frontend-architecture)

---

## Architecture Overview

The Hotel Reservation System is structured as a classic 3-tier architecture:

```text
┌─────────────────────────────────────────────────────────┐
│                    Presentation Tier                    │
│      HTML5, CSS3, JavaScript (Fetch API, Visuals)       │
└────────────────────────────┬────────────────────────────┘
                             │ HTTP Requests (REST / JSON)
                             ▼
┌─────────────────────────────────────────────────────────┐
│                    Application Tier                     │
│    Flask Backend (API Routes, Pandas Analytics, CORS)   │
└────────────────────────────┬────────────────────────────┘
                             │ SQL Queries (mysql.connector)
                             ▼
┌─────────────────────────────────────────────────────────┐
│                       Data Tier                         │
│             MySQL Database (`hotel_db`)                 │
└─────────────────────────────────────────────────────────┘
```

- **Presentation Tier**: HTML5 templates, CSS style files, and client-side JavaScript located in `frontend/` and served via Flask in `backend/templates/` and `backend/static/`.
- **Application Tier**: Python Flask server (`backend/app.py`) providing RESTful APIs for user login, room reservation, dashboard metrics, manager workflows, and dynamic pricing predictions.
- **Data Tier**: MySQL relational database storing persistent data across users, managers, hotels, rooms, and bookings.

---

## Component Diagram

```text
Hotel-Reservation-System/
├── backend/
│   ├── app.py                 # Primary Flask application entry point
│   ├── config.py              # Application settings & database connection configs
│   ├── routes/                # Blueprint and legacy route handlers
│   │   └── legacy_routes.py   # Legacy route implementations
│   ├── models/                # Data access object schemas
│   ├── static/                # Static CSS & JS files served by Flask
│   └── templates/             # HTML templates served by Flask
├── database/
│   └── hotel_reservation.sql  # MySQL DDL and baseline seed data
└── docs/                      # Documentation specifications
```

---

## Database Relational Architecture

The MySQL database `hotel_db` consists of 5 core entities:

```text
┌───────────────┐          ┌───────────────┐          ┌───────────────┐
│    MANAGER    │          │    HOTELS     │          │     ROOMS     │
├───────────────┤          ├───────────────┤          ├───────────────┤
│ manager_id PK │◄─────────┤ hotel_id   PK │          │ room_no    PK │
│ name       PK │          │ hotel_name    │          │ room_type     │
│ age           │          │ manager       │          │ floor         │
│ gender        │          │ manager_id FK │          │ cost          │
│ salary        │          └───────────────┘          │ amenities     │
│ user_id       │                                     └───────▲───────┘
│ password      │                                             │
└───────────────┘                                             │
                                                              │
┌───────────────┐                                     ┌───────┴───────┐
│     USERS     │                                     │   BOOKINGS    │
├───────────────┤                                     ├───────────────┤
│ userID     PK │◄────────────────────────────────────┤ id         PK │
│ Name          │                                     │ hotel         │
│ Password      │                                     │ room_type  FK │
│ no_of_bookings│                                     │ check_in      │
└───────────────┘                                     │ check_out     │
                                                      │ price         │
                                                      │ created_at    │
                                                      │ user_id    FK │
                                                      └───────────────┘
```

### Table Relationships
- **`HOTELS` to `MANAGER`**: Linked via foreign key `(manager_id, manager)` referencing `(manager_id, name)` in `MANAGER`.
- **`BOOKINGS` to `USERS`**: Linked via foreign key `user_id` referencing `userID` in `USERS`.
- **`BOOKINGS` to `ROOMS`**: Linked via foreign key `room_type` referencing `room_no` in `ROOMS`.

---

## Analytics & Demand Forecasting Engine

The backend integrates **Pandas** and **NumPy** to perform dynamic occupancy analytics and demand forecasting:

### 1. Moving Average & Occupancy Signal
- `get_bookings_df()` extracts all historical reservation data from `BOOKINGS` and converts `check_in`/`check_out` dates into datetime objects.
- `predict_peak_dates()` expands booking date ranges into daily rows and calculates a 7-day rolling moving average (`demand_ma`) of daily room bookings.

### 2. Category Classification & Dynamic Pricing Multiplier
- Based on demand moving averages, future dates (14-day projection window) are categorized into:
  - **`PEAK`**: Predicted demand >= `1.30 * mean_demand` -> Price Multiplier = **`1.30x`** (+30% surcharge)
  - **`BUSY`**: Predicted demand >= `1.10 * mean_demand` -> Price Multiplier = **`1.15x`** (+15% surcharge)
  - **`NORMAL`**: Standard demand -> Price Multiplier = **`1.00x`** (base rate)

---

## Frontend Architecture

- **User Flow**:
  - `index.html`: Landing page with hero banner and featured offers.
  - `catalog.html`: Available hotel properties showcase.
  - `Rooms_list.html`: Interactive room selection grid.
  - `checkout.html`: Booking summary & checkout confirmation.
  - `user_dashboard.html`: User profile overview and past reservation list.
- **Manager Flow**:
  - `manager.html`: Manager authentication portal.
  - `manager_dashboard.html`: Revenue analytics, booking distribution, and occupancy level metrics.
  - `manager_catalog.html`: Property management controls.
