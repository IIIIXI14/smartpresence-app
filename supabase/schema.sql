-- =====================================================
-- SmartPresence Database Schema
-- Week 2: Architecture & Supabase Setup
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- USERS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS public.users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  role TEXT CHECK (role IN ('admin', 'user')) DEFAULT 'user',
  device_mac TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- ATTENDANCE LOGS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS public.attendance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  wifi_ssid TEXT,
  device_mac TEXT,
  location_name TEXT,
  check_in_time TIMESTAMPTZ DEFAULT NOW(),
  check_out_time TIMESTAMPTZ,
  duration_minutes INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- NETWORKS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS public.networks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ssid TEXT NOT NULL,
  bssid TEXT NOT NULL UNIQUE,
  location TEXT,
  is_active BOOLEAN DEFAULT true,
  created_by UUID REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- ADMIN SETTINGS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS public.admin_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  setting_key TEXT UNIQUE NOT NULL,
  setting_value TEXT,
  description TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- Users table indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users(email);
CREATE INDEX IF NOT EXISTS idx_users_device_mac ON public.users(device_mac);
CREATE INDEX IF NOT EXISTS idx_users_role ON public.users(role);

-- Attendance table indexes
CREATE INDEX IF NOT EXISTS idx_attendance_user_id ON public.attendance(user_id);
CREATE INDEX IF NOT EXISTS idx_attendance_timestamp ON public.attendance(timestamp);
CREATE INDEX IF NOT EXISTS idx_attendance_device_mac ON public.attendance(device_mac);
CREATE INDEX IF NOT EXISTS idx_attendance_wifi_ssid ON public.attendance(wifi_ssid);

-- Networks table indexes
CREATE INDEX IF NOT EXISTS idx_networks_ssid ON public.networks(ssid);
CREATE INDEX IF NOT EXISTS idx_networks_bssid ON public.networks(bssid);
CREATE INDEX IF NOT EXISTS idx_networks_is_active ON public.networks(is_active);

-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- =====================================================

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.networks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_settings ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- RLS POLICIES
-- =====================================================

-- Users table policies
CREATE POLICY "Users can view own profile" ON public.users
  FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Users can update own profile" ON public.users
  FOR UPDATE USING (auth.uid()::text = id::text);

CREATE POLICY "Allow service role full access" ON public.users
  FOR ALL USING (auth.role() = 'service_role');

-- Attendance table policies
CREATE POLICY "Users can view own attendance" ON public.attendance
  FOR SELECT USING (auth.uid()::text = user_id::text);

CREATE POLICY "Allow service role to insert attendance" ON public.attendance
  FOR INSERT WITH CHECK (auth.role() = 'service_role');

CREATE POLICY "Allow service role to update attendance" ON public.attendance
  FOR UPDATE USING (auth.role() = 'service_role');

-- Networks table policies
CREATE POLICY "Anyone can view active networks" ON public.networks
  FOR SELECT USING (is_active = true);

CREATE POLICY "Admins can manage networks" ON public.networks
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.id::text = auth.uid()::text 
      AND users.role = 'admin'
    )
  );

-- Admin settings policies
CREATE POLICY "Only admins can access settings" ON public.admin_settings
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.id::text = auth.uid()::text 
      AND users.role = 'admin'
    )
  );

-- =====================================================
-- FUNCTIONS
-- =====================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updated_at
CREATE TRIGGER update_users_updated_at 
  BEFORE UPDATE ON public.users 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_networks_updated_at 
  BEFORE UPDATE ON public.networks 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to calculate attendance duration
CREATE OR REPLACE FUNCTION calculate_attendance_duration()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.check_out_time IS NOT NULL AND NEW.check_in_time IS NOT NULL THEN
        NEW.duration_minutes = EXTRACT(EPOCH FROM (NEW.check_out_time - NEW.check_in_time)) / 60;
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for attendance duration calculation
CREATE TRIGGER calculate_attendance_duration_trigger
  BEFORE INSERT OR UPDATE ON public.attendance
  FOR EACH ROW EXECUTE FUNCTION calculate_attendance_duration();

-- =====================================================
-- COMMENTS
-- =====================================================

COMMENT ON TABLE public.users IS 'User profiles and authentication data';
COMMENT ON TABLE public.attendance IS 'Attendance records with WiFi detection';
COMMENT ON TABLE public.networks IS 'WiFi networks for attendance tracking';
COMMENT ON TABLE public.admin_settings IS 'Application settings and configuration';

COMMENT ON COLUMN public.users.device_mac IS 'MAC address of user device for attendance tracking';
COMMENT ON COLUMN public.attendance.device_mac IS 'MAC address detected during attendance';
COMMENT ON COLUMN public.attendance.wifi_ssid IS 'WiFi network SSID where attendance was recorded';
COMMENT ON COLUMN public.networks.bssid IS 'WiFi network BSSID (MAC address of router)'; 