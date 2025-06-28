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
- [ ] Create GitHub account (if not exists)
- [ ] Create new repository: `smartpresence`
- [ ] Choose repository visibility (Public/Private)
- [ ] Initialize local git repository
- [ ] Push initial commit

#### Supabase Setup
- [ ] Create Supabase account at [supabase.com](https://supabase.com)
- [ ] Create new project: `SmartPresence`
- [ ] Set secure database password
- [ ] Choose database region (closest to users)
- [ ] Wait for project initialization (~1 minute)
- [ ] Save project credentials:
  - [ ] Project URL
  - [ ] Anon key (for mobile app)
  - [ ] Service role key (for admin scanner)

#### Development Tools
- [ ] Install Node.js v18+ from [nodejs.org](https://nodejs.org/)
- [ ] Verify Node.js installation: `node -v`
- [ ] Install Expo CLI: `npm install -g expo-cli`
- [ ] Verify Expo CLI: `expo --version`
- [ ] Install VS Code (if not already installed)
- [ ] Install VS Code extensions:
  - [ ] React Native Tools
  - [ ] Supabase
  - [ ] GitLens
  - [ ] Prettier
- [ ] Install Android Studio (for admin scanner development)
- [ ] Install Supabase CLI (optional): `npm install -g supabase`

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
- [ ] Create `mobile-app/.env` file
- [ ] Add Supabase credentials to mobile app
- [ ] Test Supabase connection

#### Environment Variables Template
```env
# mobile-app/.env
EXPO_PUBLIC_SUPABASE_URL=your_supabase_project_url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 📊 6. Project Documentation

#### Create Planning Documents
- [x] Main README.md
- [ ] Database schema planning
- [ ] API endpoint planning
- [ ] User flow diagrams
- [ ] Technical architecture diagram

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

### Pending 🔄
- [ ] GitHub repository creation
- [ ] Supabase project setup
- [ ] Tool installation verification
- [ ] Environment configuration
- [ ] Initial git commit and push

---

## 🚀 Next Steps (Week 2)

Once Week 1 is complete, we'll move to:

1. **Database Schema Design**
   - Users table
   - Attendance records table
   - WiFi networks table
   - Admin settings table

2. **Supabase Configuration**
   - Create tables with proper relationships
   - Setup Row Level Security (RLS)
   - Create database functions
   - Setup Edge Functions

3. **Authentication Setup**
   - User registration/login flow
   - Role-based access control
   - Mobile app auth integration

---

## 📝 Notes

- **Repository Visibility**: Choose based on your preference (public for open source, private for proprietary)
- **Database Region**: Select closest to your target users for better performance
- **Environment Variables**: Never commit .env files to git
- **Backup**: Consider backing up Supabase credentials securely

---

**Status**: 🔄 In Progress  
**Completion**: 60%  
**Next Review**: After completing pending tasks 