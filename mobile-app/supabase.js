import { createClient } from '@supabase/supabase-js';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Supabase configuration
const supabaseUrl = 'https://nprxcyncgigwcffpthtc.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wcnhjeW5jZ2lnd2NmZnB0aHRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTExMzgwNjUsImV4cCI6MjA2NjcxNDA2NX0.bZDrij2D2rdM0X3FP-iBpsGbMhUPtLC_ULonwATQx60';

// Create Supabase client
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    storage: AsyncStorage,
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
  },
});

// =====================================================
// AUTHENTICATION FUNCTIONS
// =====================================================

/**
 * Sign up a new user with email and password
 */
export const signUp = async (email, password, name) => {
  try {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          name: name,
        },
      },
    });

    if (error) throw error;

    // Create user profile in our users table
    if (data.user) {
      const { error: profileError } = await supabase
        .from('users')
        .insert([
          {
            id: data.user.id,
            name: name,
            email: email,
            role: 'user',
          },
        ]);

      if (profileError) {
        console.error('Error creating user profile:', profileError);
      }
    }

    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

/**
 * Sign in with email and password
 */
export const signIn = async (email, password) => {
  try {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

/**
 * Sign out the current user
 */
export const signOut = async () => {
  try {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
    return { error: null };
  } catch (error) {
    return { error };
  }
};

/**
 * Get current user session
 */
export const getCurrentUser = async () => {
  try {
    const { data: { user }, error } = await supabase.auth.getUser();
    if (error) throw error;
    return { user, error: null };
  } catch (error) {
    return { user: null, error };
  }
};

// =====================================================
// USER PROFILE FUNCTIONS
// =====================================================

/**
 * Get user profile from our users table
 */
export const getUserProfile = async (userId) => {
  try {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single();

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

/**
 * Update user profile
 */
export const updateUserProfile = async (userId, updates) => {
  try {
    const { data, error } = await supabase
      .from('users')
      .update(updates)
      .eq('id', userId)
      .select()
      .single();

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

// =====================================================
// ATTENDANCE FUNCTIONS
// =====================================================

/**
 * Get user's attendance records
 */
export const getUserAttendance = async (userId, limit = 50) => {
  try {
    const { data, error } = await supabase
      .from('attendance')
      .select(`
        *,
        networks (
          ssid,
          location
        )
      `)
      .eq('user_id', userId)
      .order('check_in_time', { ascending: false })
      .limit(limit);

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

/**
 * Get today's attendance for a user
 */
export const getTodayAttendance = async (userId) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const { data, error } = await supabase
      .from('attendance')
      .select('*')
      .eq('user_id', userId)
      .gte('check_in_time', today.toISOString())
      .order('check_in_time', { ascending: false });

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

// =====================================================
// NETWORK FUNCTIONS
// =====================================================

/**
 * Get all active networks
 */
export const getActiveNetworks = async () => {
  try {
    const { data, error } = await supabase
      .from('networks')
      .select('*')
      .eq('is_active', true)
      .order('location', { ascending: true });

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    return { data: null, error };
  }
};

// =====================================================
// REAL-TIME SUBSCRIPTIONS
// =====================================================

/**
 * Subscribe to real-time attendance updates for a user
 */
export const subscribeToAttendance = (userId, callback) => {
  return supabase
    .channel('attendance_changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'attendance',
        filter: `user_id=eq.${userId}`,
      },
      callback
    )
    .subscribe();
};

/**
 * Subscribe to user profile changes
 */
export const subscribeToProfile = (userId, callback) => {
  return supabase
    .channel('profile_changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'users',
        filter: `id=eq.${userId}`,
      },
      callback
    )
    .subscribe();
};

// =====================================================
// UTILITY FUNCTIONS
// =====================================================

/**
 * Format attendance duration
 */
export const formatDuration = (minutes) => {
  if (!minutes) return 'N/A';
  
  const hours = Math.floor(minutes / 60);
  const mins = minutes % 60;
  
  if (hours > 0) {
    return `${hours}h ${mins}m`;
  }
  return `${mins}m`;
};

/**
 * Format date for display
 */
export const formatDate = (dateString) => {
  const date = new Date(dateString);
  return date.toLocaleDateString('en-US', {
    weekday: 'short',
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
};

/**
 * Format time for display
 */
export const formatTime = (dateString) => {
  const date = new Date(dateString);
  return date.toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
  });
};

export default supabase; 