# -*- coding: utf-8 -*-
"""
Created on Sun May 25 14:19:27 2025

@author: harsh
"""
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import pandas as pd
import numpy as np

app = Flask(__name__)
CORS(app)


db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="tiger",
    database="hotel_db"
)
cursor = db.cursor(dictionary=True)

@app.route("/login", methods=["POST"])
def login():
    data = request.json
    username = data.get("Name")
    password = data.get("Password")

    if not username or not password:
        return jsonify({"success": False, "message": "Username and password required"}), 400

    # Check if user exists
    cursor.execute("SELECT * FROM USERS WHERE Name = %s", (username,))
    user = cursor.fetchone()

    if user is None:
        return jsonify({
        "success": False,
        "message": "User not found. Please register first."}), 404
    # User exists, check password
    else:
        if user['Password'] == password:
            return jsonify({
            "success": True,
            "message": "Login successful",
            "userID": user['userID']
        })
        else:
            return jsonify({
            "success": False,
            "message": "Incorrect password"
        }), 401

def get_bookings_df():
    cursor.execute("""
        SELECT id, hotel, room_type, check_in, check_out, price, created_at, user_id
        FROM BOOKINGS
    """)
    rows = cursor.fetchall()
    if not rows:
        return pd.DataFrame()
    
    df = pd.DataFrame(rows)
    df["check_in"] = pd.to_datetime(df["check_in"])
    df["check_out"] = pd.to_datetime(df["check_out"])
    df["created_at"] = pd.to_datetime(df["created_at"])
    df["price"] = df["price"].astype(float)
    return df

@app.route("/reserve", methods=["POST"])
def reserve():
    data = request.json
    query = """
        INSERT INTO Bookings (hotel, room_type, check_in, check_out, price, user_id)
        VALUES (%s, %s, %s, %s, %s, %s)
    """
    values = (
        data.get("hotel"),
        data.get("room_type"),
        data.get("check_in"),
        data.get("check_out"),
        data.get("price"),
        data.get("user_id")
    )
    user_id = data.get("user_id")
    hotelname = data.get("hotel")
    try:
        
        cursor.execute(query, values)
        db.commit()
        cursor.execute("UPDATE USERS SET no_of_bookings = no_of_bookings + 1 WHERE userID = %s", (user_id,))
        db.commit()
        cursor.execute("UPDATE HOTELS SET no_of_rooms_booked = no_of_rooms_booked + 1 WHERE hotel_name = %s", (hotelname,))
        db.commit()
        return jsonify({"message": "Reservation successful"})
    except mysql.connector.Error as err:
        return jsonify({"message": f"Database error: {err}"}), 500

@app.route("/analytics/overview", methods=["GET"])
def analytics_overview():
    df = get_bookings_df()
    if df.empty:
        return jsonify({"per_hotel": [], "per_day": []})

    df["nights"] = (df["check_out"] - df["check_in"]).dt.days.replace(0, 1)
    df["price_per_night"] = df["price"] / df["nights"]

    per_hotel = (
        df.groupby("hotel")
        .agg(
            bookings=("id", "count"),
            total_revenue=("price", "sum"),
            avg_price_per_booking=("price", "mean")
        )
        .reset_index()
    )

    daily_rows = []
    for _, row in df.iterrows():
        dates = pd.date_range(row["check_in"], row["check_out"] - pd.Timedelta(days=1))
        daily_price = row["price_per_night"]
        daily_rows.append(
            pd.DataFrame(
                {
                    "date": dates,
                    "hotel": row["hotel"],
                    "price_per_night": daily_price,
                }
            )
        )

    if daily_rows:
        daily_df = pd.concat(daily_rows, ignore_index=True)
    else:
        daily_df = pd.DataFrame(columns=["date", "hotel", "price_per_night"])

    per_day = (
        daily_df.groupby("date")
        .agg(
            rooms_booked=("hotel", "count"),
            revenue=("price_per_night", "sum")
        )
        .reset_index()
    )

    occupancy_threshold = per_day["rooms_booked"].median() if not per_day.empty else 0
    per_day["occupancy_level"] = np.where(
        per_day["rooms_booked"] >= occupancy_threshold, "high", "normal"
    )

    return jsonify(
        {
            "per_hotel": per_hotel.to_dict(orient="records"),
            "per_day": per_day.to_dict(orient="records"),
        }
    )

@app.route("/bookings", methods=["GET"])
def get_reservations():
    cursor.execute("SELECT * FROM Bookings")
    results = cursor.fetchall()
    # Format results as list of dicts for easier consumption
    reservations_list = [
        {
            "id": row["id"],
            "hotel": row["hotel"],
            "room_type": row["room_type"],
            "check_in": row["check_in"].strftime("%Y-%m-%d"),
            "check_out": row["check_out"].strftime("%Y-%m-%d"),
            "price": float(row["price"]),
            "created_at": row["created_at"].strftime("%Y-%m-%d %H:%M:%S")
        }
        for row in results
    ]
    return jsonify(reservations_list)

@app.route("/booked-rooms", methods=["GET"])
def get_booked_rooms():
    check_in = request.args.get("check_in")
    check_out = request.args.get("check_out")
    hotel_name = request.args.get("hotel")

    if not check_in or not check_out or not hotel_name:
        return jsonify({"message": "Missing required parameters"}), 400

    query = """
        SELECT room_type
        FROM bookings
        WHERE NOT (check_out <= %s OR check_in >= %s)
        AND hotel = %s;
    """
    cursor.execute(query, (check_in, check_out, hotel_name))
    results = cursor.fetchall()

    booked_rooms = [row["room_type"] for row in results]
    return jsonify(booked_rooms)

@app.route("/loginm", methods=["POST"])
def loginm():
    data = request.json
    user_id = data.get("user_id")
    password = data.get("password")

    if not user_id or not password:
        return jsonify({"success": False, "message": "UserID and password required"}), 400

    # Check if user exists
    cursor.execute("SELECT * FROM MANAGER WHERE USER_ID = %s", (user_id,))
    user = cursor.fetchone()

    if user is None:
        return jsonify({
        "success": False,
        "message": "User not found. Please register first."}), 404
    # User exists, check password
    else:
        if user['password'] == password:
            return jsonify({
            "success": True,
            "message": "Login successful",
            "manager_id": user['manager_id']
        })
        else:
            return jsonify({
            "success": False,
            "message": "Incorrect password"
        }), 401

@app.route("/manager/bookings", methods=["GET"])
def manager_bookings():
    manager_id = request.args.get("manager_id")
    if not manager_id:
        return jsonify({"message": "manager_id parameter is required"}), 400

    # Get hotels managed by this manager
    cursor.execute("SELECT hotel_name FROM HOTELS WHERE manager_id = %s", (manager_id,))
    hotels = cursor.fetchall()
    hotel_names = [h["hotel_name"] for h in hotels]

    if not hotel_names:
        return jsonify([])

    # Use %s placeholders dynamically for SQL IN
    format_strings = ",".join(["%s"] * len(hotel_names))

    query = f"""
        SELECT * FROM BOOKINGS
        WHERE hotel IN ({format_strings})
    """
    cursor.execute(query, tuple(hotel_names))
    bookings = cursor.fetchall()

    # Format bookings for JSON response
    bookings_list = [
        {
            "id": b["id"],
            "hotel": b["hotel"],
            "room_type": b["room_type"],
            "check_in": b["check_in"].strftime("%Y-%m-%d"),
            "check_out": b["check_out"].strftime("%Y-%m-%d"),
            "price": float(b["price"]),
            "created_at": b["created_at"].strftime("%Y-%m-%d %H:%M:%S"),
            "user_id": b["user_id"]
        }
        for b in bookings
    ]

    return jsonify(bookings_list)


        
if __name__ == "__main__":
    app.run(debug=True)



