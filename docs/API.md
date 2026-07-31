# API Documentation & Reference Manual

This document provides a comprehensive REST API specification for the Hotel Reservation System backend service.

---

## Table of Contents

1. [Authentication Endpoints](#authentication-endpoints)
2. [Reservation Endpoints](#reservation-endpoints)
3. [Analytics & Pricing Endpoints](#analytics--pricing-endpoints)
4. [User Dashboard Endpoints](#user-dashboard-endpoints)
5. [Manager Workflows](#manager-workflows)

---

## Authentication Endpoints

### 1. User Login
- **URL**: `/login`
- **Method**: `POST`
- **Content-Type**: `application/json`

#### Request Body
```json
{
  "Name": "John",
  "Password": "123456"
}
```

#### Success Response (`200 OK`)
```json
{
  "success": true,
  "message": "Login successful",
  "userID": 1001
}
```

#### Error Responses
- `400 Bad Request`: `{"success": false, "message": "Username and password required"}`
- `401 Unauthorized`: `{"success": false, "message": "Incorrect password"}`
- `404 Not Found`: `{"success": false, "message": "User not found. Please register first."}`

---

### 2. Manager Login
- **URL**: `/loginm`
- **Method**: `POST`
- **Content-Type**: `application/json`

#### Request Body
```json
{
  "user_id": "kkjohnson",
  "password": "pass123"
}
```

#### Success Response (`200 OK`)
```json
{
  "success": true,
  "message": "Login successful",
  "manager_id": 1
}
```

---

## Reservation Endpoints

### 1. Create Reservation
- **URL**: `/reserve`
- **Method**: `POST`
- **Content-Type**: `application/json`

#### Request Body
```json
{
  "hotel": "Grand Palace",
  "room_type": 102,
  "check_in": "2025-06-20",
  "check_out": "2025-06-23",
  "price": 3900.00,
  "user_id": 1001
}
```

#### Success Response (`200 OK`)
```json
{
  "message": "Reservation successful"
}
```

---

### 2. Check Booked Rooms
- **URL**: `/booked-rooms`
- **Method**: `GET`
- **Query Parameters**:
  - `check_in` (string, required): `YYYY-MM-DD`
  - `check_out` (string, required): `YYYY-MM-DD`
  - `hotel` (string, required): Hotel name

#### Success Response (`200 OK`)
```json
[101, 106, 207]
```

---

### 3. Fetch All Bookings
- **URL**: `/bookings`
- **Method**: `GET`

#### Success Response (`200 OK`)
```json
[
  {
    "id": 11,
    "hotel": "Heritage Inn",
    "room_type": 109,
    "check_in": "2025-06-17",
    "check_out": "2025-06-20",
    "price": 3975.0,
    "created_at": "2025-06-01 17:29:25"
  }
]
```

---

## Analytics & Pricing Endpoints

### 1. Special Offers
- **URL**: `/offers`
- **Method**: `GET`

#### Success Response (`200 OK`)
```json
[
  {
    "key": "summer_savings",
    "title": "Summer savings",
    "description": "Save up to 25% on stays booked this week.",
    "room_ids": [102, 207, 115],
    "discount": 0.2,
    "hotel": "Grand Palace"
  }
]
```

---

### 2. Analytics Overview
- **URL**: `/analytics/overview`
- **Method**: `GET`

#### Success Response (`200 OK`)
```json
{
  "per_hotel": [
    {
      "hotel": "Grand Palace",
      "bookings": 1,
      "total_revenue": 4452.0,
      "avg_price_per_booking": 4452.0
    }
  ],
  "per_day": [
    {
      "date": "2025-06-08T00:00:00.000",
      "rooms_booked": 2,
      "revenue": 5341.0,
      "occupancy_level": "high"
    }
  ]
}
```

---

### 3. Dynamic Pricing Forecast
- **URL**: `/pricing/prediction`
- **Method**: `GET`

#### Success Response (`200 OK`)
```json
[
  {
    "date": "2025-06-30",
    "category": "PEAK",
    "price_multiplier": 1.3
  },
  {
    "date": "2025-07-01",
    "category": "NORMAL",
    "price_multiplier": 1.0
  }
]
```

---

## User Dashboard Endpoints

### 1. User Dashboard Data
- **URL**: `/dashboard-data`
- **Method**: `GET`
- **Query Parameters**:
  - `user_id` (integer, required): ID of the user

#### Success Response (`200 OK`)
```json
{
  "success": true,
  "profile": {
    "userID": 1001,
    "name": "John",
    "bookingsCount": 4,
    "passwordHint": "••••••••"
  },
  "bookings": [
    {
      "id": 12,
      "hotel": "Mountain Lodge",
      "room_number": 109,
      "check_in": "2025-06-08",
      "check_out": "2025-06-10",
      "price": 2725.0,
      "created_at": "2025-06-01 17:33:36",
      "room_type_name": "Standard",
      "room_cost": 1250.0
    }
  ]
}
```

---

## Manager Workflows

### 1. Manager Bookings List
- **URL**: `/manager/bookings`
- **Method**: `GET`
- **Query Parameters**:
  - `manager_id` (integer, required): ID of the manager

#### Success Response (`200 OK`)
```json
[
  {
    "id": 14,
    "hotel": "Grand Palace",
    "room_type": 110,
    "check_in": "2025-06-24",
    "check_out": "2025-06-27",
    "price": 4452.0,
    "created_at": "2025-06-02 12:42:18",
    "user_id": 1001
  }
]
```
