-- Supabase SQL Schema for SBHSS Science Club
-- Run this in your Supabase SQL Editor to create the required tables

-- Enable Row Level Security (recommended for production)
-- Note: You'll need to configure RLS policies based on your authentication needs

-- Members Table
CREATE TABLE IF NOT EXISTS members (
    id TEXT PRIMARY KEY,
    role TEXT NOT NULL DEFAULT 'MEMBER' CHECK (role IN ('GUEST', 'MEMBER', 'ADMIN')),
    status TEXT NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    joined_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    father_name TEXT NOT NULL,
    mother_name TEXT NOT NULL,
    present_address TEXT NOT NULL,
    permanent_address TEXT NOT NULL,
    birth_cert_no TEXT NOT NULL,
    dob DATE NOT NULL,
    blood_group TEXT NOT NULL,
    class TEXT NOT NULL,
    roll TEXT NOT NULL,
    mobile TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Projects Table
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('COMPLETED', 'ONGOING', 'UPCOMING')),
    image TEXT NOT NULL,
    researchers TEXT[] NOT NULL DEFAULT '{}',
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Announcements Table
CREATE TABLE IF NOT EXISTS announcements (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('PUBLIC', 'INTERNAL')),
    priority TEXT CHECK (priority IN ('HIGH', 'NORMAL')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Gallery Table
CREATE TABLE IF NOT EXISTS gallery (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    category TEXT NOT NULL CHECK (category IN ('Event', 'Experiment', 'Competition')),
    image TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Weekly Fact Table (single row)
CREATE TABLE IF NOT EXISTS weekly_fact (
    id INTEGER PRIMARY KEY DEFAULT 1,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT single_row CHECK (id = 1)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_members_mobile ON members(mobile);
CREATE INDEX IF NOT EXISTS idx_members_status ON members(status);
CREATE INDEX IF NOT EXISTS idx_announcements_date ON announcements(date DESC);
CREATE INDEX IF NOT EXISTS idx_announcements_type ON announcements(type);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at triggers to all tables
DROP TRIGGER IF EXISTS update_members_updated_at ON members;
CREATE TRIGGER update_members_updated_at
    BEFORE UPDATE ON members
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_projects_updated_at ON projects;
CREATE TRIGGER update_projects_updated_at
    BEFORE UPDATE ON projects
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_announcements_updated_at ON announcements;
CREATE TRIGGER update_announcements_updated_at
    BEFORE UPDATE ON announcements
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_gallery_updated_at ON gallery;
CREATE TRIGGER update_gallery_updated_at
    BEFORE UPDATE ON gallery
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_weekly_fact_updated_at ON weekly_fact;
CREATE TRIGGER update_weekly_fact_updated_at
    BEFORE UPDATE ON weekly_fact
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) Policies
-- Uncomment and customize these based on your authentication setup

-- Enable RLS on all tables
-- ALTER TABLE members ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE weekly_fact ENABLE ROW LEVEL SECURITY;

-- Example: Allow anonymous read access to public data
-- CREATE POLICY "Public projects are viewable by everyone" ON projects
--     FOR SELECT USING (true);

-- CREATE POLICY "Public announcements are viewable by everyone" ON announcements
--     FOR SELECT USING (type = 'PUBLIC');

-- CREATE POLICY "Gallery is viewable by everyone" ON gallery
--     FOR SELECT USING (true);

-- CREATE POLICY "Weekly fact is viewable by everyone" ON weekly_fact
--     FOR SELECT USING (true);

-- For now, allow all operations (disable RLS or create permissive policies)
-- This is suitable for development but should be locked down for production

-- Grant permissions (for development - adjust for production)
GRANT ALL ON members TO anon, authenticated;
GRANT ALL ON projects TO anon, authenticated;
GRANT ALL ON announcements TO anon, authenticated;
GRANT ALL ON gallery TO anon, authenticated;
GRANT ALL ON weekly_fact TO anon, authenticated;

-- Grant sequence permissions
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
