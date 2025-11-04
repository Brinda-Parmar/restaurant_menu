# Restaurant Order Management App

A mini restaurant ordering application built using Flutter.  
Users can browse menu categories, add items to the cart, and place an order — simulating a Kitchen Order Ticket (KOT).

---

## ✨ Core Features

### 🧾 Menu Page
- Display menu categories (Starters, Main Course, Desserts)
- Expand category → show items with **image, name & price**
- Load menu data from **local JSON**

### 🛒 Cart Page
- Increment / Decrement item quantity
- Remove items from cart
- Calculate:
    - Subtotal
    - Tax (5%)
    - Final total
- “Place Order” button
- "Clear Cart" button

### ✅ Order Confirmation Page
- Show order summary
- Auto-generated **unique KOT number**
- Estimated preparation time

### ⚙️ Settings Page
- Toggle **Light / Dark theme**
- Save theme preference locally

---

## 🧠 State Management

This project uses **BLoC (flutter_bloc)** to separate UI from business logic:

| BLoC | Responsibility |
|------|---------------|
| MenuBloc | Load menu data |
| CartBloc | Manage cart state |
| ThemeBloc | Handle light/dark theme persistence |

---

## 📦 Local Storage

- **SQLite** is used to store cart items persistently
- **shared_preferences** for theme storage

