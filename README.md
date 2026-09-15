# FitFlow Redesign

A human-centered redesign of the FitFlow fitness app, addressing personalization,
social accountability and nutrition-logging friction identified during user research.

## Project Background
FitFlow's user retention had dropped, with app store ratings falling from 4.6 to 3.8 stars.
This project follows a structured HCI process — from stakeholder identification and user
research, through to technology selection and architecture design — to redesign the app
around AI-powered personalization, social features, and simplified nutrition tracking.

## Tech Stack
- **Frontend:** React Native + React Native Web (iOS, Android, Web)
- **Backend:** Node.js / Express
- **Databases:** PostgreSQL (structured/health data), Firebase Firestore (real-time social data)
- **Auth:** Firebase Auth
- **AI/ML:** TensorFlow Lite (on-device), ML Kit (computer vision for nutrition logging)

## Folder Structure

fitflow-redesign/
├── frontend/ # React Native app (iOS, Android, Web)
├── backend/ # Node.js/Express core API
├── ai-service/ # AI personalization + computer vision microservices
├── docs/ # Comparison tables, decision matrix, architecture diagram, ADR


## Documentation
See the `/docs` folder for:
- `activity1-frontend-comparison.md` — Flutter vs React Native vs KMP vs Swift comparison
- `activity2-backend-db-auth-comparison.md` — Backend, database and auth comparison
- `activity3-decision-matrix.md` — Weighted technology stack decision matrix
- `activity4-architecture-diagram.png` — High-level system architecture
- `adr/activity4-adr.md` — Architecture Decision Record

## Getting Started
1. Clone the repo
2. `cd frontend && npm install && npm start`
3. `cd backend && npm install && npm run dev`

## Author
Gunasekara A G A G D — BSc (Hons) Information Technology, SLIIT
IT3060 — Human Computer Interaction, Lab Exercise 05