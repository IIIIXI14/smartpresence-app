# 🗄️ SmartPresence Supabase Setup

This directory contains all the database schema, configuration, and setup files for the SmartPresence WiFi-based attendance tracking system.

## 📁 File Structure

```
supabase/
├── schema.sql          # Complete database schema with tables, indexes, RLS
├── seed.sql            # Sample data for testing and development
├── config.md           # Project configuration and API keys
├── README.md           # This file
└── edge-functions/     # Serverless functions (Week 4)
    └── mark-attendance.ts
```

## 🚀 Quick Start

### 1. Setup Database Schema

1. Go to your [Supabase Dashboard](https://app.supabase.com/project/nprxcyncgigwcffpthtc)
2. Navigate to **SQL Editor**
3. Copy the contents of `schema.sql`
4. Paste and run the SQL commands
5. Verify tables are created in **Table Editor**

### 2. Add Sample Data (Optional)

1. In the same SQL Editor
2. Copy the contents of `seed.sql`
3. Paste and run to add test users and networks
4. Check **Table Editor** to see the data

### 3. Test Connection

Use the test query in `config.md` to verify your setup:

```sql
SELECT 'Users count:' as info, COUNT(*) as count FROM public.users
UNION ALL
SELECT 'Networks count:', COUNT(*) FROM public.networks
UNION ALL
SELECT 'Attendance records count:', COUNT(*) FROM public.attendance;
```

## 🗄️ Database Schema Overview

### Core Tables

| Table | Purpose | Key Features |
|-------|---------|--------------|
| `users` | User profiles and authentication | Role-based access, device MAC tracking |
| `attendance` | Attendance records | WiFi detection, duration calculation |
| `networks` | WiFi networks | Location tracking, admin management |
| `admin_settings` | App configuration | Key-value settings for admins |

### Relationships

```
users (1) ←→ (many) attendance
users (1) ←→ (many) networks (created_by)
users (1) ←→ (many) admin_settings (admin access)
```

### Security Features

- **Row Level Security (RLS)** enabled on all tables
- **Role-based access** (user/admin)
- **Service role** for admin scanner app
- **Automatic timestamps** and audit trails

## 🔐 Authentication Setup

### 1. Enable Email Auth

1. Go to **Authentication → Settings**
2. Enable **Email provider**
3. Configure email templates (optional)

### 2. Configure RLS Policies

The schema includes comprehensive RLS policies:

- Users can only access their own data
- Admins have broader access
- Service role has full access for scanner app

### 3. Test Authentication

```javascript
// Test in browser console
const { data, error } = await supabase.auth.signUp({
  email: 'test@example.com',
  password: 'password123'
});
```

## 📊 Data Management

### Sample Users

The seed data includes:

- **Regular Users**: Alice, Bob, Charlie, Diana
- **Admin User**: admin@smartpresence.com
- **Test Networks**: Office, Conference, Lobby, Cafeteria

### Attendance Records

Sample attendance data includes:
- Today's records with check-in/check-out times
- Historical data for testing
- Various locations and durations

## 🔧 Configuration

### Environment Variables

See `config.md` for complete configuration details:

- Project URL and API keys
- Environment file templates
- Dashboard links

### API Endpoints

The schema supports these operations:

- **User Management**: CRUD operations with RLS
- **Attendance Tracking**: Insert/query with real-time updates
- **Network Management**: Admin-only operations
- **Settings**: Key-value configuration

## 📈 Performance Optimization

### Indexes

The schema includes optimized indexes for:

- User lookups by email and device MAC
- Attendance queries by user and timestamp
- Network searches by SSID and BSSID

### Functions

- **Automatic timestamp updates**
- **Duration calculation** for attendance records
- **Audit trail** maintenance

## 🚨 Important Notes

### Security

- ✅ Never expose service role key in client code
- ✅ Use RLS policies for data protection
- ✅ Regularly backup your database
- ✅ Monitor API usage and costs

### Development

- ✅ Test with seed data before production
- ✅ Use separate databases for dev/staging/prod
- ✅ Keep schema changes version controlled
- ✅ Document any custom functions or policies

## 🆘 Troubleshooting

### Common Issues

1. **RLS Policy Errors**
   ```sql
   -- Check if user is authenticated
   SELECT auth.uid();
   
   -- Test with service role
   SET request.jwt.claim.role = 'service_role';
   ```

2. **Connection Issues**
   - Verify API keys in `config.md`
   - Check project status in dashboard
   - Test with simple query first

3. **Real-time Problems**
   - Enable real-time in dashboard
   - Check subscription channels
   - Verify table permissions

### Support Resources

- [Supabase Documentation](https://supabase.com/docs)
- [PostgreSQL Reference](https://www.postgresql.org/docs/)
- [RLS Best Practices](https://supabase.com/docs/guides/auth/row-level-security)

## 📋 Week 2 Checklist

- [x] Database schema created
- [x] RLS policies configured
- [x] Sample data added
- [x] Authentication enabled
- [x] Mobile app client configured
- [x] Documentation complete

## 🚀 Next Steps

After completing Week 2 setup:

1. **Week 3**: Build React Native frontend
2. **Week 4**: Develop Android scanner app
3. **Week 5**: Testing and deployment

---

**Status**: ✅ Week 2 Complete  
**Last Updated**: Database schema and configuration ready  
**Next**: Move to Week 3 - React Native App Development 