# 🔧 Supabase Setup Guide

## 📋 Project Information

### Project Details
- **Project Name**: SmartPresence
- **Description**: WiFi-based attendance tracking system
- **Database**: PostgreSQL
- **Region**: [Choose closest to your users]

### 🔑 API Keys & URLs

> ⚠️ **IMPORTANT**: Replace these placeholder values with your actual Supabase project credentials

```env
# Project URL
SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co

# API Keys
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzgwNjUsImV4cCI6MjA2NjcxNDA2NX0.bZDrij2D2rdM0X3FP-iBpsGbMhUPtLC_ULonwATQx60
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MTEzODA2NSwiZXhwIjoyMDY2NzE0MDY1fQ.n-GktF8zjBfPnWwtjgvvdpQBdcepYhjIReqAuJ_SeZA

# Database Password
DB_PASSWORD=14harshal08
```

### 📱 Environment Files

#### Mobile App (`mobile-app/.env`)
```env
EXPO_PUBLIC_SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzgwNjUsImV4cCI6MjA2NjcxNDA2NX0.bZDrij2D2rdM0X3FP-iBpsGbMhUPtLC_ULonwATQx60
```

#### Admin Scanner (`admin-scanner-app/.env`)
```env
SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MTEzODA2NSwiZXhwIjoyMDY2NzE0MDY1fQ.n-GktF8zjBfPnWwtjgvvdpQBdcepYhjIReqAuJ_SeZA

```

---

## 🚀 Setup Instructions

### 1. Create Supabase Project

1. Go to [https://app.supabase.com](https://app.supabase.com)
2. Sign up/Login to your account
3. Click **"New Project"**
4. Fill in project details:
   - **Name**: `SmartPresence`
   - **Database Password**: Use a secure password (save this!)
   - **Region**: Choose closest to your users
5. Click **"Create new project"**
6. Wait for initialization (~1 minute)

### 2. Get Project Credentials

1. Go to **Settings** → **API**
2. Copy the following:
   - **Project URL**
   - **anon public** key
   - **service_role** key (keep this secret!)

### 3. Database Schema (Week 2)

The following tables will be created in Week 2:

```sql
-- Users table (extends Supabase auth.users)
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  role TEXT DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- WiFi Networks table
CREATE TABLE public.wifi_networks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  ssid TEXT NOT NULL,
  bssid TEXT NOT NULL UNIQUE,
  location_name TEXT,
  is_active BOOLEAN DEFAULT true,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Attendance Records table
CREATE TABLE public.attendance_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.profiles(id) NOT NULL,
  wifi_network_id UUID REFERENCES public.wifi_networks(id) NOT NULL,
  check_in_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  check_out_time TIMESTAMP WITH TIME ZONE,
  duration_minutes INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Admin Settings table
CREATE TABLE public.admin_settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  setting_key TEXT UNIQUE NOT NULL,
  setting_value TEXT,
  description TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 4. Row Level Security (RLS)

Enable RLS on all tables and create policies:

```sql
-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wifi_networks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_settings ENABLE ROW LEVEL SECURITY;

-- Policies will be created in Week 2
```

---

## 🔐 Security Best Practices

### API Key Management
- ✅ Use **anon key** for mobile app (public)
- ✅ Use **service_role key** only for admin scanner (private)
- ✅ Never expose service_role key in client-side code
- ✅ Store keys in environment variables

### Database Security
- ✅ Enable Row Level Security (RLS) on all tables
- ✅ Create specific policies for each user role
- ✅ Use parameterized queries to prevent SQL injection
- ✅ Regularly backup your database

### Environment Variables
- ✅ Never commit `.env` files to git
- ✅ Use different keys for development and production
- ✅ Rotate keys periodically

---

## 📊 Project Dashboard

### Useful Links
- **Dashboard**: [https://app.supabase.com/project/your-project-id](https://app.supabase.com/project/your-project-id)
- **API Docs**: [https://supabase.com/docs](https://supabase.com/docs)
- **Database**: [https://app.supabase.com/project/your-project-id/editor](https://app.supabase.com/project/your-project-id/editor)

### Monitoring
- **Database**: Monitor query performance and usage
- **Auth**: Track user signups and logins
- **Storage**: Monitor file uploads (if needed)
- **Edge Functions**: Monitor function execution (Week 4)

---

## 🆘 Troubleshooting

### Common Issues

1. **Connection Failed**
   - Check if project URL is correct
   - Verify API keys are copied correctly
   - Ensure project is not paused

2. **Authentication Errors**
   - Verify anon key is used for public operations
   - Check if RLS policies are configured correctly
   - Ensure user is authenticated before accessing protected data

3. **Database Errors**
   - Check if tables exist
   - Verify column names and types
   - Ensure proper relationships between tables

### Support Resources
- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Discord](https://discord.supabase.com)
- [GitHub Issues](https://github.com/supabase/supabase/issues)

---

**Next Step**: Complete this setup, then move to **Week 2: Database Schema & Authentication** 