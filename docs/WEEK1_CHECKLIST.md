# ✅ Week 1: Project Planning & Setup Checklist

## 🎯 Goal
Prepare all accounts, tools, and project structure to kickstart full-stack development.

---

## 📋 Setup Tasks

### 🗂️ 1. Project Structure
- [x] Create main project folders
  - [x] `mobile-app/` - React Native frontend
  - [x] `admin-scanner-app/` - Android scanner app
  - [x] `supabase/` - Database & Edge Functions
  - [x] `docs/` - Documentation
- [x] Move existing Expo project to `mobile-app/`
- [x] Create comprehensive README.md
- [x] Setup project-wide .gitignore

### ⚙️ 2. Tools & Account Setup

#### GitHub Repository
- [x] Create GitHub account (if not exists)
- [x] Create new repository: `smartpresence-app`
- [x] Choose repository visibility (Public/Private)
- [x] Initialize local git repository
- [x] Push initial commit

#### Supabase Setup
- [x] Create Supabase account at [supabase.com](https://supabase.com)
- [x] Create new project: `SmartPresence`
- [x] Set secure database password
- [x] Choose database region (closest to users)
- [x] Wait for project initialization (~1 minute)
- [x] Save project credentials:
  - [x] Project URL
  - [x] Anon key (for mobile app)
  - [x] Service role key (for admin scanner)

#### Development Tools
- [x] Install Node.js v18+ from [nodejs.org](https://nodejs.org/)
- [x] Verify Node.js installation: `node -v`
- [x] Install Expo CLI: `npm install -g expo-cli`
- [x] Verify Expo CLI: `expo --version`
- [x] Install VS Code (if not already installed)
- [x] Install VS Code extensions:
  - [x] React Native Tools
  - [x] Supabase
  - [x] GitLens
  - [x] Prettier
- [x] Install Android Studio (for admin scanner development)
- [x] Install Supabase CLI (optional): `npm install -g supabase`

### 🧰 3. Local Development Setup

#### Node.js & Expo Verification
```bash
# Check Node.js version
node -v  # Should show v18 or higher

# Check npm version
npm -v

# Check Expo CLI
expo --version

# Check if Expo CLI is working
expo doctor
```

#### Git Repository Setup
```bash
# Initialize git repository
git init

# Add all files
git add .

# Initial commit
git commit -m "Initial commit: Week 1 project setup"

# Add remote origin (replace with your GitHub repo URL)
git remote add origin https://github.com/your-username/smartpresence.git

# Push to GitHub
git push -u origin main
```

### 📱 4. Mobile App Verification

#### Test Existing Expo Project
```bash
cd mobile-app

# Install dependencies
npm install

# Start Expo development server
expo start

# Test on device/simulator
# - Scan QR code with Expo Go app
# - Or press 'a' for Android emulator
# - Or press 'i' for iOS simulator
```

### 🔑 5. Environment Configuration

#### Create Environment Files
- [x] Create `mobile-app/.env` file
- [x] Add Supabase credentials to mobile app
- [x] Test Supabase connection

#### Environment Variables Template
```env
# mobile-app/.env
EXPO_PUBLIC_SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzgwNjUsImV4cCI6MjA2NjcxNDA2NX0.bZDrij2D2rdM0X3FP-iBpsGbMhUPtLC_ULonwATQx60
```

### 📊 6. Project Documentation

#### Create Planning Documents
- [x] Main README.md
- [x] Database schema planning
- [x] API endpoint planning
- [x] User flow diagrams
- [x] Technical architecture diagram

#### User Roles Definition
- [x] Define User role (mobile app access)
- [x] Define Admin role (scanner + dashboard access)
- [x] Define Scanner Device role (MAC detection)

---

## ✅ Week 1 Deliverables

### Completed ✅
- [x] Project folder structure
- [x] Comprehensive README.md
- [x] Project-wide .gitignore
- [x] User roles definition
- [x] Development roadmap
- [x] Tech stack documentation
- [x] GitHub repository creation
- [x] Supabase project setup
- [x] Tool installation verification
- [x] Environment configuration
- [x] Initial git commit and push

---

## 🚀 Week 2: Database & Authentication (COMPLETED ✅)

### Week 2 Deliverables ✅
- [x] **Database Schema** (`supabase/schema.sql`)
  - [x] Users table with role-based access
  - [x] Attendance records table with WiFi tracking
  - [x] Networks table for WiFi management
  - [x] Admin settings table
  - [x] Comprehensive RLS policies
  - [x] Performance indexes
  - [x] Database functions and triggers

- [x] **Seed Data** (`supabase/seed.sql`)
  - [x] Test users (Alice, Bob, Charlie, Diana, Admin)
  - [x] Sample WiFi networks
  - [x] Attendance records for testing
  - [x] Admin settings configuration

- [x] **Supabase Client** (`mobile-app/supabase.js`)
  - [x] Client configuration with your credentials
  - [x] Authentication functions (signUp, signIn, signOut)
  - [x] User profile management
  - [x] Attendance data functions
  - [x] Real-time subscriptions
  - [x] Utility functions for formatting

- [x] **Configuration** (`supabase/config.md`)
  - [x] Project details and API keys
  - [x] Database table schemas
  - [x] RLS policy documentation
  - [x] Dashboard links and troubleshooting

- [x] **Documentation** (`supabase/README.md`)
  - [x] Setup instructions
  - [x] Schema overview
  - [x] Security features
  - [x] Performance optimization

- [x] **Dependencies Installed**
  - [x] @supabase/supabase-js
  - [x] @react-native-async-storage/async-storage

### Week 2 Setup Instructions ✅

1. **Run Database Schema**:
   - Go to [Supabase Dashboard](https://app.supabase.com/project/nprxcyncgigwcffpthtc)
   - Navigate to **SQL Editor**
   - Copy and paste contents of `supabase/schema.sql`
   - Execute the SQL commands

2. **Add Sample Data** (Optional):
   - In the same SQL Editor
   - Copy and paste contents of `supabase/seed.sql`
   - Execute to add test data

3. **Test Connection**:
   - The mobile app is now configured with Supabase
   - Ready for Week 3 development

---

## 🚀 Next Steps (Week 3)

Once Week 2 is complete, we'll move to:

1. **React Native Frontend Development**
   - Login/Register screens
   - Dashboard with attendance view
   - Profile management
   - Real-time updates

2. **Navigation Setup**
   - React Navigation configuration
   - Protected routes
   - Tab navigation

3. **UI Components**
   - Modern, responsive design
   - Loading states
   - Error handling

---

## 📝 Notes

- **Repository**: https://github.com/IIIIXI14/smartpresence-app.git
- **Supabase Project**: https://app.supabase.com/project/nprxcyncgigwcffpthtc
- **Environment Variables**: Configured and ready
- **Database Schema**: Complete with RLS policies
- **Mobile App**: Ready for Week 3 development

---

**Status**: ✅ Week 1 & 2 Complete  
**Completion**: 100%  
**Next**: Week 3 - React Native App Development 