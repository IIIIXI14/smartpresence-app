# 🔧 SmartPresence Supabase Configuration

## 📋 Project Details

- **Project Name**: SmartPresence
- **Project URL**: https://nprxcyncgigwcffpthtc.supabase.co
- **Database**: PostgreSQL
- **Region**: [Auto-detected]

## 🔑 API Keys

### Public Keys (Safe for client-side)
```env
EXPO_PUBLIC_SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzgwNjUsImV4cCI6MjA2NjcxNDA2NX0.bZDrij2D2rdM0X3FP-iBpsGbMhUPtLC_ULonwATQx60
```

### Service Role Key (Keep Secret!)
```env
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MTEzODA2NSwiZXhwIjoyMDY2NzE0MDY1fQ.n-GktF8zjBfPnWwtjgvvdpQBdcepYhjIReqAuJ_SeZA
```

## 🗄️ Database Tables

### 1. `users` Table
- `id` (UUID, Primary Key)
- `name` (TEXT, Required)
- `email` (TEXT, Unique, Required)
- `role` (TEXT, 'admin' or 'user', Default: 'user')
- `device_mac` (TEXT, Optional)
- `created_at` (TIMESTAMPTZ)
- `updated_at` (TIMESTAMPTZ)

### 2. `attendance` Table
- `id` (UUID, Primary Key)
- `user_id` (UUID, Foreign Key to users.id)
- `timestamp` (TIMESTAMPTZ)
- `wifi_ssid` (TEXT)
- `device_mac` (TEXT)
- `location_name` (TEXT)
- `check_in_time` (TIMESTAMPTZ)
- `check_out_time` (TIMESTAMPTZ)
- `duration_minutes` (INTEGER)
- `created_at` (TIMESTAMPTZ)

### 3. `networks` Table
- `id` (UUID, Primary Key)
- `ssid` (TEXT, Required)
- `bssid` (TEXT, Required, Unique)
- `location` (TEXT)
- `is_active` (BOOLEAN, Default: true)
- `created_by` (UUID, Foreign Key to users.id)
- `created_at` (TIMESTAMPTZ)
- `updated_at` (TIMESTAMPTZ)

### 4. `admin_settings` Table
- `id` (UUID, Primary Key)
- `setting_key` (TEXT, Required, Unique)
- `setting_value` (TEXT)
- `description` (TEXT)
- `updated_at` (TIMESTAMPTZ)

## 🔐 Row Level Security (RLS) Policies

### Users Table
- Users can only view and update their own profile
- Service role has full access

### Attendance Table
- Users can only view their own attendance records
- Service role can insert and update attendance records

### Networks Table
- Anyone can view active networks
- Only admins can manage networks

### Admin Settings Table
- Only admins can access settings

## 🚀 Quick Setup Commands

### 1. Run Schema
```sql
-- Copy and paste the contents of schema.sql into Supabase SQL Editor
```

### 2. Run Seed Data (Optional)
```sql
-- Copy and paste the contents of seed.sql into Supabase SQL Editor
```

### 3. Test Connection
```javascript
// Test in browser console or mobile app
const { data, error } = await supabase
  .from('users')
  .select('*')
  .limit(1);

console.log('Connection test:', { data, error });
```

## 📊 Dashboard Links

- **Supabase Dashboard**: https://app.supabase.com/project/nprxcyncgigwcffpthtc
- **Database Editor**: https://app.supabase.com/project/nprxcyncgigwcffpthtc/editor
- **Authentication**: https://app.supabase.com/project/nprxcyncgigwcffpthtc/auth/users
- **API Documentation**: https://app.supabase.com/project/nprxcyncgigwcffpthtc/api

## 🔧 Environment Files

### Mobile App (`mobile-app/.env`)
```env
EXPO_PUBLIC_SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzgwNjUsImV4cCI6MjA2NjcxNDA2NX0.bZDrij2D2rdM0X3FP-iBpsGbMhUPtLC_ULonwATQx60
```

### Admin Scanner (`admin-scanner-app/.env`)
```env
SUPABASE_URL=https://nprxcyncgigwcffpthtc.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MTEzODA2NSwiZXhwIjoyMDY2NzE0MDY1fQ.n-GktF8zjBfPnWwtjgvvdpQBdcepYhjIReqAuJ_SeZA
```

## 📝 Notes

- **Security**: Never expose the service role key in client-side code
- **Backup**: Consider backing up your database regularly
- **Monitoring**: Use Supabase dashboard to monitor usage and performance
- **Updates**: Keep your Supabase client libraries updated

## 🆘 Troubleshooting

### Common Issues

1. **Connection Failed**
   - Verify project URL is correct
   - Check if API keys are copied correctly
   - Ensure project is not paused

2. **RLS Policy Errors**
   - Check if user is authenticated
   - Verify user has correct role permissions
   - Test with service role key if needed

3. **Real-time Issues**
   - Ensure real-time is enabled in Supabase dashboard
   - Check if user is subscribed to correct channels
   - Verify table has RLS policies configured

---

**Last Updated**: Week 2 Setup  
**Status**: ✅ Ready for Development 