-- Kalakaar Film Casting & Event Management Database
-- MySQL Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS kalakaar_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kalakaar_db;

-- Profiles table for talent submissions
CREATE TABLE IF NOT EXISTS profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    submission_id VARCHAR(50) UNIQUE NOT NULL,
    submission_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- Personal Information
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    location VARCHAR(255) NOT NULL,
    
    -- Professional Information
    category ENUM('actor', 'model', 'dancer', 'influencer', 'singer', 'comedian', 'other') NOT NULL,
    experience VARCHAR(20) NOT NULL,
    skills TEXT NOT NULL,
    languages TEXT NOT NULL,
    bio TEXT NOT NULL,
    
    -- Physical Attributes
    height INT,
    weight INT,
    eye_color VARCHAR(50),
    hair_color VARCHAR(50),
    
    -- Portfolio
    profile_photo VARCHAR(500),
    portfolio_photos TEXT,
    showreel VARCHAR(500),
    social_media TEXT,
    
    -- Availability
    availability ENUM('immediately', '2weeks', '1month', '3months', 'negotiable') NOT NULL,
    work_types TEXT,
    
    -- Preferences
    newsletter BOOLEAN DEFAULT FALSE,
    
    -- Status and Tracking
    status ENUM('pending_review', 'under_review', 'approved', 'rejected', 'archived') DEFAULT 'pending_review',
    ip_address VARCHAR(45),
    user_agent TEXT,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_status (status),
    INDEX idx_category (category),
    INDEX idx_submission_date (submission_date)
);

-- Contact submissions table
CREATE TABLE IF NOT EXISTS contact_submissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    message TEXT NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    status ENUM('new', 'read', 'replied', 'archived') DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

-- Events table for managing events
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    event_type ENUM('audition', 'workshop', 'fashion_show', 'corporate', 'red_carpet', 'product_launch') NOT NULL,
    date DATE NOT NULL,
    time TIME,
    location VARCHAR(500),
    venue VARCHAR(255),
    client VARCHAR(255),
    budget DECIMAL(10,2),
    status ENUM('planning', 'confirmed', 'ongoing', 'completed', 'cancelled') DEFAULT 'planning',
    
    -- Event Details
    expected_attendees INT,
    requirements TEXT,
    special_instructions TEXT,
    
    -- Media
    event_images TEXT,
    event_videos TEXT,
    
    -- Staff Assignment
    assigned_staff TEXT,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_date (date),
    INDEX idx_status (status),
    INDEX idx_event_type (event_type)
);

-- Talent categories for portfolio management
CREATE TABLE IF NOT EXISTS talent_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(100),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default talent categories
INSERT IGNORE INTO talent_categories (name, description, icon, display_order) VALUES
('Actors', 'Professional actors for film, TV, and theater', 'fas fa-video', 1),
('Models', 'Fashion and commercial models', 'fas fa-camera', 2),
('Dancers', 'Professional dancers and choreographers', 'fas fa-music', 3),
('Influencers', 'Social media influencers and content creators', 'fas fa-star', 4),
('Singers', 'Vocal artists and musicians', 'fas fa-microphone', 5),
('Comedians', 'Stand-up comedians and entertainers', 'fas fa-laugh', 6);

-- Services table
CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category ENUM('casting', 'event_management') NOT NULL,
    icon VARCHAR(100),
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default services
INSERT INTO services (title, description, category, icon, display_order) VALUES
('Film & TV Casting', 'Professional casting for movies, television shows, and web series. We connect directors with the perfect talent for their vision.', 'casting', 'fas fa-video', 1),
('Model & Commercial Casting', 'Commercial casting for advertisements, fashion campaigns, and brand endorsements. Finding faces that represent your brand perfectly.', 'casting', 'fas fa-camera', 2),
('Audition Coordination', 'Complete audition management from scheduling to feedback. Streamlined processes for efficient talent evaluation.', 'casting', 'fas fa-clipboard-list', 3),
('Portfolio Management', 'Professional portfolio development and management for actors and models. Creating compelling presentations that showcase talent.', 'casting', 'fas fa-briefcase', 4),
('Corporate Events', 'Complete event management for corporate conferences, product launches, and team building activities.', 'event_management', 'fas fa-users', 5),
('Celebrity Appearances', 'Coordinating celebrity appearances for events, brand endorsements, and promotional activities.', 'event_management', 'fas fa-star', 6),
('Fashion Shows', 'Complete fashion show production from model casting to runway management and audience coordination.', 'event_management', 'fas fa-tshirt', 7),
('Red Carpet Events', 'Premium red carpet event management for movie premieres, award ceremonies, and high-profile gatherings.', 'event_management', 'fas fa-carpet', 8);

-- Gallery table for managing images
CREATE TABLE IF NOT EXISTS gallery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    image_path VARCHAR(500) NOT NULL,
    thumbnail_path VARCHAR(500),
    category ENUM('events', 'portfolio', 'behind_scenes', 'testimonials') NOT NULL,
    tags TEXT,
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_category (category),
    INDEX idx_is_active (is_active)
);

-- Testimonials table
CREATE TABLE IF NOT EXISTS testimonials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    client_title VARCHAR(255),
    client_company VARCHAR(255),
    testimonial_text TEXT NOT NULL,
    client_image VARCHAR(500),
    rating INT DEFAULT 5,
    category ENUM('talent', 'client', 'event') NOT NULL,
    is_featured BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_category (category),
    INDEX idx_is_featured (is_featured),
    INDEX idx_is_active (is_active)
);

-- Admin users table
CREATE TABLE IF NOT EXISTS admin_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role ENUM('super_admin', 'admin', 'staff') DEFAULT 'staff',
    permissions TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default admin user (password: password)
INSERT INTO admin_users (username, email, password_hash, full_name, role) VALUES
('admin', 'admin@kalakaar-casting.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'super_admin');

-- Settings table for website configuration
CREATE TABLE IF NOT EXISTS settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    setting_type ENUM('string', 'text', 'number', 'boolean', 'json') DEFAULT 'string',
    description TEXT,
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default settings
INSERT IGNORE INTO settings (setting_key, setting_value, setting_type, description, is_public) VALUES
('site_name', 'Kalakaar Film Casting & Event Management', 'string', 'Website name', TRUE),
('header_name', 'Kalakaar', 'string', 'Header / brand name', TRUE),
('tagline', 'Discover Talent, Create Excellence', 'string', 'Homepage tagline', TRUE),
('site_description', 'Professional casting services and event management for actors, models, and corporate clients.', 'text', 'Homepage description', TRUE),
('site_email', 'info@kalakaar-casting.com', 'string', 'Contact email', TRUE),
('site_phone', '+91 98765 43210', 'string', 'Contact phone', TRUE),
('site_address', '123 Film Nagar, Andheri West, Mumbai', 'string', 'Physical address', TRUE),
('social_instagram', 'https://instagram.com/kalakaar_film_casting', 'string', 'Instagram URL', TRUE),
('theme_primary', '#FF6B35', 'string', 'Primary theme color', TRUE),
('theme_secondary', '#F7931E', 'string', 'Secondary theme color', TRUE),
('site_logo', '', 'string', 'Site logo path', TRUE),
('site_dp', '', 'string', 'Site display picture path', TRUE),
('hero_image_1', '', 'string', 'Hero image 1 path', TRUE),
('hero_image_2', '', 'string', 'Hero image 2 path', TRUE),
('hero_image_3', '', 'string', 'Hero image 3 path', TRUE),
('about_image', '', 'string', 'About section image path', TRUE),
('talent_showcase_items', '[]', 'json', 'Talent showcase items', TRUE),
('event_gallery_items', '[]', 'json', 'Events gallery items', TRUE),
('auto_reply_enabled', '1', 'boolean', 'Enable auto-reply emails', FALSE),
('max_file_size', '5242880', 'number', 'Max file size in bytes (5MB)', FALSE),
('allowed_file_types', '["jpg","jpeg","png"]', 'json', 'Allowed file types', FALSE);

-- Audit log table for tracking changes
CREATE TABLE IF NOT EXISTS audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(100),
    record_id INT,
    old_values TEXT,
    new_values TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_table_name (table_name),
    INDEX idx_created_at (created_at),
    
    FOREIGN KEY (user_id) REFERENCES admin_users(id) ON DELETE SET NULL
);

-- Create views for common queries

-- Active profiles view
CREATE VIEW active_profiles AS
SELECT 
    id,
    submission_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    phone,
    category,
    experience,
    location,
    status,
    submission_date,
    profile_photo
FROM profiles 
WHERE status IN ('pending_review', 'under_review', 'approved')
ORDER BY submission_date DESC;

-- Recent contact submissions view
CREATE VIEW recent_contact_submissions AS
SELECT 
    id,
    name,
    email,
    phone,
    LEFT(message, 100) AS message_preview,
    status,
    created_at
FROM contact_submissions 
WHERE status != 'archived'
ORDER BY created_at DESC;

-- Upcoming events view
CREATE VIEW upcoming_events AS
SELECT 
    id,
    title,
    event_type,
    date,
    time,
    location,
    status
FROM events 
WHERE date >= CURDATE() AND status IN ('planning', 'confirmed')
ORDER BY date ASC;

-- Create stored procedures for common operations

DELIMITER //

-- Procedure to update profile status
CREATE PROCEDURE UpdateProfileStatus(
    IN p_submission_id VARCHAR(50),
    IN p_new_status VARCHAR(50),
    IN p_admin_user_id INT
)
BEGIN
    DECLARE old_status VARCHAR(50);
    
    -- Get old status
    SELECT status INTO old_status FROM profiles WHERE submission_id = p_submission_id;
    
    -- Update status
    UPDATE profiles 
    SET status = p_new_status, updated_at = CURRENT_TIMESTAMP 
    WHERE submission_id = p_submission_id;
    
    -- Log the change
    INSERT INTO audit_log (user_id, action, table_name, record_id, old_values, new_values)
    VALUES (p_admin_user_id, 'STATUS_CHANGE', 'profiles', 
            (SELECT id FROM profiles WHERE submission_id = p_submission_id),
            old_status, p_new_status);
END //

-- Procedure to get profile statistics
CREATE PROCEDURE GetProfileStatistics()
BEGIN
    SELECT 
        COUNT(*) as total_profiles,
        COUNT(CASE WHEN status = 'pending_review' THEN 1 END) as pending_review,
        COUNT(CASE WHEN status = 'under_review' THEN 1 END) as under_review,
        COUNT(CASE WHEN status = 'approved' THEN 1 END) as approved,
        COUNT(CASE WHEN status = 'rejected' THEN 1 END) as rejected,
        COUNT(CASE WHEN category = 'actor' THEN 1 END) as actors,
        COUNT(CASE WHEN category = 'model' THEN 1 END) as models,
        COUNT(CASE WHEN category = 'dancer' THEN 1 END) as dancers,
        COUNT(CASE WHEN category = 'influencer' THEN 1 END) as influencers
    FROM profiles;
END //

DELIMITER ;

-- Create triggers for automatic logging

DELIMITER //

-- Trigger for profile updates
CREATE TRIGGER profiles_after_update
AFTER UPDATE ON profiles
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO audit_log (action, table_name, record_id, old_values, new_values)
        VALUES ('STATUS_CHANGE', 'profiles', NEW.id, OLD.status, NEW.status);
    END IF;
END //

-- Trigger for contact submissions
CREATE TRIGGER contact_submissions_after_insert
AFTER INSERT ON contact_submissions
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (action, table_name, record_id, new_values)
    VALUES ('INSERT', 'contact_submissions', NEW.id, 
            CONCAT('Name: ', NEW.name, ', Email: ', NEW.email));
END //

DELIMITER ;

-- Create indexes for better performance
CREATE INDEX idx_profiles_composite ON profiles(status, category, submission_date);
CREATE INDEX idx_events_composite ON events(status, date, event_type);
CREATE INDEX idx_gallery_composite ON gallery(category, is_active, display_order);

-- Final setup complete
SELECT 'Kalakaar Database Setup Complete!' as message;
