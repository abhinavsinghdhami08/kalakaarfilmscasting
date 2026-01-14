<?php
/**
 * Database Setup Script for Kalakaar Website
 * This script will create the database and tables automatically
 */

// Prevent direct access from browser for security
if (!defined('SETUP_MODE')) {
    die('This script can only be run from command line or during setup');
}

// Database Configuration
$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'kalakaar_db';

echo "=== Kalakaar Database Setup ===\n\n";

try {
    // Connect to MySQL without database
    $pdo = new PDO("mysql:host=$db_host", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "✓ Connected to MySQL server\n";
    
    // Create database if it doesn't exist
    $pdo->exec("CREATE DATABASE IF NOT EXISTS `$db_name` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    echo "✓ Database '$db_name' created or already exists\n";
    
    // Select the database
    $pdo->exec("USE `$db_name`");
    
    // Read and execute SQL file
    $sqlFile = __DIR__ . '/database.sql';
    if (!file_exists($sqlFile)) {
        throw new Exception("Database SQL file not found: $sqlFile");
    }
    
    $sql = file_get_contents($sqlFile);
    
    // Split SQL into individual statements
    $statements = array_filter(array_map('trim', explode(';', $sql)));
    
    foreach ($statements as $statement) {
        if (!empty($statement)) {
            $pdo->exec($statement);
        }
    }
    
    echo "✓ Database tables created successfully\n";
    
    // Create directories
    $directories = [
        __DIR__ . '/uploads',
        __DIR__ . '/uploads/profiles',
        __DIR__ . '/uploads/site',
        __DIR__ . '/data',
        __DIR__ . '/logs'
    ];
    
    foreach ($directories as $dir) {
        if (!file_exists($dir)) {
            mkdir($dir, 0755, true);
            echo "✓ Created directory: $dir\n";
        } else {
            echo "✓ Directory already exists: $dir\n";
        }
    }
    
    // Create .htaccess for uploads directory
    $htaccessContent = "
# Prevent direct access to uploaded files
<FilesMatch '\.(php|phtml|php3|php4|php5|pl|py|cgi|sh|exe)$'>
    Order Allow,Deny
    Deny from all
</FilesMatch>

# Allow image files
<FilesMatch '\.(jpg|jpeg|png|gif|webp)$'>
    Order Allow,Deny
    Allow from all
</FilesMatch>

# Prevent directory listing
Options -Indexes
";
    
    file_put_contents(__DIR__ . '/uploads/.htaccess', $htaccessContent);
    echo "✓ Created uploads/.htaccess security file\n";
    
    // Test database connection
    $testDb = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    $testDb->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Check if tables exist
    $tables = $testDb->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
    echo "✓ Database connection test successful\n";
    echo "✓ Created " . count($tables) . " tables\n";
    
    echo "\n=== Setup Complete ===\n";
    echo "Database '$db_name' is ready for use!\n";
    echo "\nNext steps:\n";
    echo "1. Update config/database.php with your database credentials\n";
    echo "2. Update email settings in config/database.php\n";
    echo "3. Test the website forms\n";
    echo "4. Set up admin panel for managing submissions\n";
    
} catch (Exception $e) {
    echo "✗ Setup failed: " . $e->getMessage() . "\n";
    echo "\nPlease check:\n";
    echo "1. MySQL server is running\n";
    echo "2. Database credentials are correct\n";
    echo "3. Database user has CREATE privileges\n";
    echo "4. File permissions allow writing\n";
    exit(1);
}
?>
