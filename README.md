# FitFlow Redesign

A human-centered redesign of the FitFlow fitness app, addressing personalization,
social accountability and nutrition-logging friction identified during user research.

## Project Background
FitFlow's user retention had dropped, with app store ratings falling from 4.6 to 3.8 stars.
This project follows a structured HCI process — from stakeholder identification and user
research, through to technology selection and architecture design — to redesign the app
around AI-powered personalization, social features, and simplified nutrition tracking.

## Tech Stack
- **Frontend App:** Flutter (Android, iOS, Web) + Material 3 + Provider (Runs Standalone with built-in mock data)
- **Planned Backend:** Node.js + Express (TypeScript), PostgreSQL (Prisma ORM), Firebase Admin SDK

## Folder Structure

```text
fitflow-redesign/
├── frontend/    # Flutter mobile & web app (Primary app for Lab 06)
├── backend/     # Node.js/Express TypeScript API (Planned architecture)
├── ai-service/  # AI microservices architecture
└── docs/        # Comparison tables, decision matrix, architecture diagram, ADR
```

## Documentation
See the `/docs` folder for:
- `activity1-frontend-comparison.md` — Frontend technology comparison
- `activity2-backend-db-auth-comparison.md` — Backend, database and auth comparison
- `activity3-decision-matrix.md` — Weighted technology stack decision matrix
- `activity4-architecture-diagram.png` — High-level system architecture
- `adr/activity4-adr.md` — Architecture Decision Record

## How to Run the App ( Getting Started )

### 📱 Running the Flutter App (Lab 06)
The app runs completely **standalone** using built-in realistic mock data (`FitnessProvider`). No external backend server or database setup is required to run and test the app.

```bash
# 1. Navigate to the frontend directory
cd frontend

# 2. Get Flutter packages
flutter pub get

# 3. Run the application
flutter run
```

> **Android Studio:** Open the project, select your device (e.g. `emulator-5554` or Chrome), and click **Run (▶)**.

---

### ⚙️ Backend API (Optional / System Architecture)
*(Planned Express API server for production data sync)*

```bash
cd backend
npm install
npm run dev
```

## Author
Gunasekara A G A G D — BSc (Hons) Information Technology, SLIIT  
IT3060 — Human Computer Interaction, Lab Exercise 06
