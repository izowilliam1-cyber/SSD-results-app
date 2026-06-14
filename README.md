# SSD Results App 📱

> Check South Sudan exam results (PLE, S4, S8) with instant notifications, countdown timer, and leaderboard

## 🎯 Features

- ✅ **Fast Results Check** - Get results in 2 seconds (vs 5-20min on *113#)
- ✅ **Push Notifications** - Instant alerts when results are published
- ✅ **Multi-Network** - Works on Airtel, MTN, Zain, not just Digitel
- ✅ **Leaderboard** - See top performers in real-time
- ✅ **Countdown Timer** - Track time to next exam
- ✅ **Offline Mode** - Works without internet (cached results)

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│                 SSD Results App                   │
├─────────────────────────────────────────────────┤
│  Mobile (Flutter)  │  Web (React/Next.js)       │
├────────────────────┴──────────────────────────────┤
│         Python Flask Backend API                  │
│    (Firebase Realtime DB + Cloud Functions)      │
├─────────────────────────────────────────────────┤
│  MOESTI API    │  Digitel *113# USSD (Fallback)  │
└─────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
ssd-results-app/
├── backend/           # Python Flask API
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .env.example
├── mobile/            # Flutter mobile app
│   ├── lib/
│   ├── pubspec.yaml
├── web/               # React/Next.js web app
│   └── package.json
└── README.md
```

## 🚀 Quick Start

### Backend

```bash
cd backend
pip install -r requirements.txt
cp .env.example .env
python app.py
```

### Mobile (Flutter)

```bash
cd mobile
flutter pub get
flutter run
```

### Web (Next.js)

```bash
cd web
npm install
npm run dev
```

## 🔑 Firebase Setup

1. Create Firebase project
2. Download service account key
3. Save as `backend/firebase-key.json`
4. Enable Realtime Database

## 📊 Digitel *113# Integration

The app provides a fallback to Digitel's USSD service:
- **Dial**: `*113#` on Digitel SIM
- **Cost**: ~100 SSP per check
- **Speed**: 5-20 minutes

Our app improvement:
- **Free** to check (optional paid SMS alerts ~50 SSP)
- **Speed**: 2 seconds via push notification
- **Networks**: Works on all operators (Airtel, MTN, Zain, Digitel)

## 📝 TODO

- [ ] Integrate MOESTI API
- [ ] Digitel *113# fallback button
- [ ] Push notifications
- [ ] SMS alerts
- [ ] School marketplace
- [ ] Leaderboard algorithm
- [ ] Authentication
- [ ] Admin dashboard

## 👨‍💻 Author

Isaac (@izowilliam1-cyber)