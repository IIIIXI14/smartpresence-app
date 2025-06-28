-- =====================================================
-- SmartPresence Seed Data
-- Week 2: Test data for development
-- =====================================================

-- Clear existing data (optional - uncomment if needed)
-- DELETE FROM public.attendance;
-- DELETE FROM public.networks;
-- DELETE FROM public.users;

-- =====================================================
-- INSERT TEST USERS
-- =====================================================

INSERT INTO public.users (name, email, role, device_mac) VALUES
  ('Alice Johnson', 'alice@smartpresence.com', 'user', 'AA:BB:CC:DD:EE:01'),
  ('Bob Smith', 'bob@smartpresence.com', 'user', 'AA:BB:CC:DD:EE:02'),
  ('Charlie Brown', 'charlie@smartpresence.com', 'user', 'AA:BB:CC:DD:EE:03'),
  ('Diana Prince', 'diana@smartpresence.com', 'user', 'AA:BB:CC:DD:EE:04'),
  ('Admin User', 'admin@smartpresence.com', 'admin', NULL)
ON CONFLICT (email) DO NOTHING;

-- =====================================================
-- INSERT TEST NETWORKS
-- =====================================================

INSERT INTO public.networks (ssid, bssid, location, created_by, is_active) VALUES
  ('SmartPresence-Office', '00:11:22:33:44:55', 'Main Office Building', 
   (SELECT id FROM public.users WHERE email = 'admin@smartpresence.com'), true),
  ('SmartPresence-Conference', '00:11:22:33:44:66', 'Conference Room A', 
   (SELECT id FROM public.users WHERE email = 'admin@smartpresence.com'), true),
  ('SmartPresence-Lobby', '00:11:22:33:44:77', 'Building Lobby', 
   (SELECT id FROM public.users WHERE email = 'admin@smartpresence.com'), true),
  ('SmartPresence-Cafeteria', '00:11:22:33:44:88', 'Employee Cafeteria', 
   (SELECT id FROM public.users WHERE email = 'admin@smartpresence.com'), true)
ON CONFLICT (bssid) DO NOTHING;

-- =====================================================
-- INSERT SAMPLE ATTENDANCE RECORDS
-- =====================================================

-- Get user IDs for reference
DO $$
DECLARE
    alice_id UUID;
    bob_id UUID;
    charlie_id UUID;
    diana_id UUID;
    office_network_id UUID;
    conf_network_id UUID;
    lobby_network_id UUID;
    cafe_network_id UUID;
BEGIN
    -- Get user IDs
    SELECT id INTO alice_id FROM public.users WHERE email = 'alice@smartpresence.com';
    SELECT id INTO bob_id FROM public.users WHERE email = 'bob@smartpresence.com';
    SELECT id INTO charlie_id FROM public.users WHERE email = 'charlie@smartpresence.com';
    SELECT id INTO diana_id FROM public.users WHERE email = 'diana@smartpresence.com';
    
    -- Get network IDs
    SELECT id INTO office_network_id FROM public.networks WHERE ssid = 'SmartPresence-Office';
    SELECT id INTO conf_network_id FROM public.networks WHERE ssid = 'SmartPresence-Conference';
    SELECT id INTO lobby_network_id FROM public.networks WHERE ssid = 'SmartPresence-Lobby';
    SELECT id INTO cafe_network_id FROM public.networks WHERE ssid = 'SmartPresence-Cafeteria';
    
    -- Insert sample attendance records for today
    INSERT INTO public.attendance (user_id, wifi_ssid, device_mac, location_name, check_in_time, check_out_time) VALUES
      -- Alice's attendance today
      (alice_id, 'SmartPresence-Office', 'AA:BB:CC:DD:EE:01', 'Main Office Building', 
       NOW() - INTERVAL '8 hours', NOW() - INTERVAL '1 hour'),
      
      -- Bob's attendance today
      (bob_id, 'SmartPresence-Conference', 'AA:BB:CC:DD:EE:02', 'Conference Room A', 
       NOW() - INTERVAL '9 hours', NOW() - INTERVAL '30 minutes'),
      
      -- Charlie's attendance today
      (charlie_id, 'SmartPresence-Lobby', 'AA:BB:CC:DD:EE:03', 'Building Lobby', 
       NOW() - INTERVAL '7 hours', NULL),
      
      -- Diana's attendance today
      (diana_id, 'SmartPresence-Cafeteria', 'AA:BB:CC:DD:EE:04', 'Employee Cafeteria', 
       NOW() - INTERVAL '6 hours', NOW() - INTERVAL '2 hours');
    
    -- Insert some historical attendance records
    INSERT INTO public.attendance (user_id, wifi_ssid, device_mac, location_name, check_in_time, check_out_time) VALUES
      -- Yesterday's records
      (alice_id, 'SmartPresence-Office', 'AA:BB:CC:DD:EE:01', 'Main Office Building', 
       NOW() - INTERVAL '32 hours', NOW() - INTERVAL '24 hours'),
      (bob_id, 'SmartPresence-Conference', 'AA:BB:CC:DD:EE:02', 'Conference Room A', 
       NOW() - INTERVAL '33 hours', NOW() - INTERVAL '25 hours'),
      (charlie_id, 'SmartPresence-Lobby', 'AA:BB:CC:DD:EE:03', 'Building Lobby', 
       NOW() - INTERVAL '31 hours', NOW() - INTERVAL '23 hours'),
      
      -- Day before yesterday
      (alice_id, 'SmartPresence-Office', 'AA:BB:CC:DD:EE:01', 'Main Office Building', 
       NOW() - INTERVAL '56 hours', NOW() - INTERVAL '48 hours'),
      (diana_id, 'SmartPresence-Cafeteria', 'AA:BB:CC:DD:EE:04', 'Employee Cafeteria', 
       NOW() - INTERVAL '54 hours', NOW() - INTERVAL '46 hours');
END $$;

-- =====================================================
-- INSERT ADMIN SETTINGS
-- =====================================================

INSERT INTO public.admin_settings (setting_key, setting_value, description) VALUES
  ('attendance_timeout_minutes', '30', 'Minutes after which a user is considered checked out if no activity'),
  ('max_attendance_duration_hours', '12', 'Maximum hours a user can be marked as present in a day'),
  ('scan_interval_seconds', '60', 'How often the scanner checks for new devices (in seconds)'),
  ('notification_enabled', 'true', 'Whether to send notifications for attendance events'),
  ('auto_checkout_enabled', 'true', 'Whether to automatically check out users when they leave the network')
ON CONFLICT (setting_key) DO UPDATE SET
  setting_value = EXCLUDED.setting_value,
  description = EXCLUDED.description,
  updated_at = NOW();

-- =====================================================
-- VERIFICATION QUERIES (for testing)
-- =====================================================

-- Check if data was inserted correctly
SELECT 'Users count:' as info, COUNT(*) as count FROM public.users
UNION ALL
SELECT 'Networks count:', COUNT(*) FROM public.networks
UNION ALL
SELECT 'Attendance records count:', COUNT(*) FROM public.attendance
UNION ALL
SELECT 'Admin settings count:', COUNT(*) FROM public.admin_settings;

-- Show sample attendance data
SELECT 
  u.name,
  a.wifi_ssid,
  a.location_name,
  a.check_in_time,
  a.check_out_time,
  a.duration_minutes
FROM public.attendance a
JOIN public.users u ON a.user_id = u.id
ORDER BY a.check_in_time DESC
LIMIT 10; 