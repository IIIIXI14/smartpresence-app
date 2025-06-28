# 📱 SmartPresence - WiFi-Based Attendance App

A modern, full-stack attendance tracking system that uses WiFi MAC address detection for seamless attendance management.

## 🎯 Project Overview

SmartPresence revolutionizes attendance tracking by leveraging WiFi technology to automatically detect when users are present in designated areas, eliminating the need for manual check-ins.

### Key Features
- **🔐 Secure Authentication** - Supabase-powered user management
- **📱 Mobile App** - React Native app for users to view attendance
- **📡 Admin Scanner** - Android app for MAC address detection
- **☁️ Cloud Database** - Supabase backend with real-time sync
- **📊 Analytics** - Attendance reports and insights

## 🏗️ Architecture

```
smartpresence/
├── mobile-app/             # React Native frontend (User app)
├── admin-scanner-app/      # Android scanner (MAC detector)
├── supabase/               # Database schema & Edge Functions
├── docs/                   # Documentation & planning
└── README.md              # This file
```

## 🚀 Quick Start

### Prerequisites
- Node.js v18+
- Expo CLI
- Supabase account
- Android Studio (for admin scanner)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/smartpresence.git
   cd smartpresence
   ```

2. **Setup Mobile App**
   ```bash
   cd mobile-app
   npm install
   expo start
   ```

3. **Setup Supabase**
   - Create project at [supabase.com](https://supabase.com)
   - Add environment variables to mobile app
   - Run database migrations

4. **Setup Admin Scanner** (Week 3)
   ```bash
   cd admin-scanner-app
   # Android Studio setup instructions
   ```

## 📋 Development Roadmap

### ✅ Week 1: Project Planning & Setup
- [x] Project structure setup
- [x] GitHub repository
- [x] Supabase project creation
- [ ] Tool installation verification

### 🔄 Week 2: Database & Authentication
- [ ] Database schema design
- [ ] Supabase tables & RLS
- [ ] User authentication flow
- [ ] Mobile app auth integration

### 📱 Week 3: Mobile App Development
- [ ] User interface design
- [ ] Attendance viewing screens
- [ ] Profile management
- [ ] Real-time updates

### 📡 Week 4: Admin Scanner App
- [ ] Android app development
- [ ] MAC address detection
- [ ] Attendance recording
- [ ] Admin dashboard

### 🚀 Week 5: Testing & Deployment
- [ ] End-to-end testing
- [ ] Performance optimization
- [ ] Production deployment
- [ ] Documentation completion

## 🛠️ Tech Stack

### Frontend
- **React Native** - Cross-platform mobile development
- **Expo** - Development platform & tools
- **React Navigation** - Navigation between screens
- **Supabase Client** - Database & auth integration

### Backend
- **Supabase** - Backend-as-a-Service
- **PostgreSQL** - Database
- **Edge Functions** - Serverless functions
- **Real-time subscriptions** - Live updates

### Admin Scanner
- **Android Native** - MAC address detection
- **Kotlin** - Programming language
- **Android Studio** - Development environment

## 🔐 Environment Variables

Create `.env` files in respective directories:

### Mobile App (.env)
```env
EXPO_PUBLIC_SUPABASE_URL=your_supabase_url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
```

### Admin Scanner (.env)
```env
SUPABASE_URL=your_supabase_url
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

## 📱 User Roles

| Role | Permissions | Access |
|------|-------------|---------|
| **User** | View own attendance, profile management | Mobile app |
| **Admin** | Register SSID/BSSID, view all logs | Admin scanner + web dashboard |
| **Scanner Device** | Record attendance via MAC detection | Admin scanner app |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📧 Email: support@smartpresence.com
- 📖 Documentation: [docs/](docs/)
- 🐛 Issues: [GitHub Issues](https://github.com/your-username/smartpresence/issues)

---

**Built with ❤️ for seamless attendance management** 