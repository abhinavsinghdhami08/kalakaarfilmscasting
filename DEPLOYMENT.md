# Database-Enabled Deployment Guide

This guide covers deploying the Kalakaar website with MySQL database backend for enhanced functionality and data management.

## 🚀 Quick Start

### Option 1: Local Development (XAMPP/WAMP)

1. **Start XAMPP/WAMP**
   - Start Apache and MySQL services
   - Open phpMyAdmin (http://localhost/phpmyadmin)

2. **Create Database**
   ```bash
   # Run the setup script from command line
   cd "c:/xampp/htdocs/kalakaar film casting and event management"
   php setup-database.php
   ```

3. **Update Configuration**
   - Edit `config/database.php` with your database credentials
   - Update email settings

4. **Test the Website**
   - Open browser: `http://localhost/kalakaar%20film%20casting%20and%20event%20management/`
   - Test contact form and profile submission

### Option 2: Production Server Deployment

## 📋 Prerequisites

- **Web Server**: Apache/Nginx with PHP 7.4+
- **Database**: MySQL 5.7+ or MariaDB 10.2+
- **PHP Extensions**: PDO, PDO_MySQL, GD, Mail, JSON
- **File Permissions**: Write access to uploads/, data/, logs/

## 🔧 Step-by-Step Deployment

### 1. Server Preparation

#### For Apache:
```bash
# Enable required modules
sudo a2enmod rewrite
sudo a2enmod headers
sudo systemctl restart apache2
```

#### For Nginx:
```nginx
# Add to server block
location ~ \.php$ {
    fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
}
```

### 2. Database Setup

#### Method A: Using Setup Script
```bash
# Clone or upload files to server
cd /var/www/html/kalakaar
php setup-database.php
```

#### Method B: Manual Setup
```sql
-- Create database
CREATE DATABASE kalakaar_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Import schema
mysql -u username -p kalakaar_db < database.sql
```

### 3. Configuration

#### Update Database Credentials
Edit `config/database.php`:
```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'kalakaar_db');
define('DB_USER', 'your_db_user');
define('DB_PASS', 'your_db_password');
```

#### Update Email Settings
```php
define('SMTP_HOST', 'smtp.yourdomain.com');
define('SMTP_USERNAME', 'your_email@yourdomain.com');
define('SMTP_PASSWORD', 'your_email_password');
```

#### Update Application Settings
```php
define('APP_URL', 'https://yourdomain.com');
define('APP_EMAIL', 'info@yourdomain.com');
```

### 4. File Permissions

```bash
# Set appropriate permissions
chmod -R 755 /var/www/html/kalakaar
chmod -R 777 /var/www/html/kalakaar/uploads
chmod -R 777 /var/www/html/kalakaar/data
chmod -R 777 /var/www/html/kalakaar/logs

# Set ownership (replace www-data with your web server user)
chown -R www-data:www-data /var/www/html/kalakaar
```

### 5. Update Form Handlers

Replace the form action URLs in your HTML files:

#### In `index.html`:
```javascript
// Update the fetch URL in js/script.js
fetch('php/contact-db.php', {
```

#### In `submit.html`:
```javascript
// Update the fetch URL in js/submit.js
fetch('php/submit-profile-db.php', {
```

### 6. Security Configuration

#### Create .htaccess for uploads:
```apache
# uploads/.htaccess
<FilesMatch '\.(php|phtml|php3|php4|php5|pl|py|cgi|sh|exe)$'>
    Order Allow,Deny
    Deny from all
</FilesMatch>

Options -Indexes
```

#### Main .htaccess:
```apache
# Security headers
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options DENY
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
</IfModule>

# Hide PHP errors in production
php_flag display_errors off
php_value error_log /path/to/logs/php_errors.log
```

## 🌐 Cloud Deployment Options

### Option 1: Traditional Hosting (cPanel)

1. **Upload Files**
   - Use File Manager or FTP to upload all files
   - Ensure directory structure is maintained

2. **Create Database**
   - Use cPanel > MySQL Databases
   - Create database and user
   - Import `database.sql`

3. **Configure**
   - Edit `config/database.php`
   - Update database credentials

4. **Set Permissions**
   - Use cPanel File Manager to set permissions
   - 755 for directories, 644 for files
   - 777 for uploads/, data/, logs/

### Option 2: Cloud Platform (AWS/DigitalOcean)

#### AWS EC2 Setup:
```bash
# Install LAMP stack
sudo apt update
sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql php-gd

# Secure MySQL
sudo mysql_secure_installation

# Clone repository
git clone <your-repo> /var/www/html/kalakaar

# Setup database
cd /var/www/html/kalakaar
php setup-database.php

# Configure Apache
sudo a2ensite kalakaar.conf
sudo systemctl reload apache2
```

#### DigitalOcean Droplet:
```bash
# Use one-click LAMP stack
# Then follow same steps as AWS
```

### Option 3: Docker Deployment

#### Dockerfile:
```dockerfile
FROM php:8.0-apache

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql gd

# Copy files
COPY . /var/www/html/

# Set permissions
RUN chmod -R 755 /var/www/html/
RUN chmod -R 777 /var/www/html/uploads /var/www/html/data /var/www/html/logs

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
```

#### docker-compose.yml:
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "80:80"
    depends_on:
      - db
    environment:
      - DB_HOST=db
      - DB_NAME=kalakaar_db
      - DB_USER=root
      - DB_PASS=rootpassword

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: kalakaar_db
    volumes:
      - db_data:/var/lib/mysql
      - ./database.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  db_data:
```

## 🔍 Testing & Verification

### 1. Database Connection Test
Create `test-db.php`:
```php
<?php
require_once 'config/database.php';
try {
    $db = getDB();
    echo "✓ Database connection successful!";
    
    // Test query
    $result = $db->query("SELECT COUNT(*) as count FROM profiles");
    $row = $result->fetch();
    echo "✓ Profiles table: " . $row['count'] . " records";
} catch (Exception $e) {
    echo "✗ Database error: " . $e->getMessage();
}
?>
```

### 2. Form Testing
- Test contact form submission
- Test profile submission with file uploads
- Check database for new records
- Verify email notifications

### 3. Security Testing
- Test file upload restrictions
- Verify SQL injection protection
- Check XSS prevention
- Test CSRF protection

## 📊 Database Management

### Backup Strategy
```bash
# Daily backup script
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u username -p kalakaar_db > backup_$DATE.sql
gzip backup_$DATE.sql

# Keep last 7 days
find /path/to/backups -name "*.sql.gz" -mtime +7 -delete
```

### Monitoring
```sql
-- Check recent submissions
SELECT * FROM profiles WHERE created_at > DATE_SUB(NOW(), INTERVAL 1 DAY);

-- Check database size
SELECT 
    table_name,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.tables 
WHERE table_schema = 'kalakaar_db';
```

## 🚨 Troubleshooting

### Common Issues

#### Database Connection Failed
```bash
# Check MySQL service
sudo systemctl status mysql

# Check credentials
mysql -u username -p -h localhost kalakaar_db

# Check PHP extensions
php -m | grep -E "(pdo|mysql)"
```

#### File Upload Issues
```bash
# Check permissions
ls -la uploads/

# Check PHP upload limits
php -i | grep -E "(upload_max_filesize|post_max_size)"
```

#### Email Not Sending
```bash
# Test mail function
php -r "mail('test@example.com', 'Test', 'Test message');"

# Check mail logs
tail -f /var/log/mail.log
```

### Debug Mode
Enable debugging by adding to `config/database.php`:
```php
define('DEBUG_MODE', true);
ini_set('display_errors', 1);
```

## 🔄 Maintenance

### Regular Tasks
1. **Weekly**: Database optimization and backup
2. **Monthly**: Review and clean old submissions
3. **Quarterly**: Security updates and patches
4. **Annually**: Full system audit and updates

### Automated Maintenance
```bash
# Create cron jobs
# crontab -e

# Daily backup at 2 AM
0 2 * * * /path/to/backup-script.sh

# Clean old logs weekly
0 3 * * 0 find /path/to/logs -name "*.log" -mtime +30 -delete

# Optimize database monthly
0 4 1 * * mysql -u username -p -e "OPTIMIZE TABLE kalakaar_db.profiles, kalakaar_db.contact_submissions"
```

## 📈 Performance Optimization

### Database Indexing
```sql
-- Add custom indexes as needed
CREATE INDEX idx_profiles_search ON profiles(category, status, created_at);
CREATE INDEX idx_contacts_recent ON contact_submissions(status, created_at);
```

### Caching
```php
// Add to config/database.php
define('CACHE_ENABLED', true);
define('CACHE_DURATION', 3600); // 1 hour
```

### CDN for Images
```javascript
// Update image URLs to use CDN
const CDN_BASE = 'https://cdn.yourdomain.com/kalakaar/';
```

## 🔐 Security Best Practices

1. **Regular Updates**: Keep PHP, MySQL, and dependencies updated
2. **Strong Passwords**: Use complex database passwords
3. **HTTPS**: Enable SSL/TLS certificates
4. **Firewall**: Configure web application firewall
5. **Monitoring**: Set up intrusion detection
6. **Backups**: Regular automated backups
7. **Access Control**: Limit database access to application only

---

## 📞 Support

For deployment assistance:
- Email: support@kalakaar-casting.com
- Documentation: Check README.md
- Issues: Create GitHub issue for bugs

**Note**: Always test deployment in staging environment before production!
