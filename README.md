# Kalakaar Film Casting & Event Management Website

A complete responsive website for a professional casting and event management agency, built with HTML, CSS, JavaScript, and PHP.

## 🌟 Features

### Core Features
- **Responsive Design**: Works perfectly on all devices (desktop, tablet, mobile)
- **Hero Section**: Auto-rotating image slider with call-to-action buttons
- **About Section**: Mission statement, services, and company values
- **Services Section**: Tabbed interface for casting and event management services
- **Portfolio/Talent Showcase**: Filterable gallery of actors, models, dancers, and influencers
- **Gallery Section**: Lightbox-enabled photo gallery
- **Testimonials**: Auto-rotating client testimonials carousel
- **Contact Form**: Functional contact form with email notifications
- **Profile Submission**: Comprehensive form for talent to submit their profiles
- **SEO Optimized**: Meta tags, semantic HTML, and optimized performance

### Interactive Features
- Smooth scrolling navigation
- Mobile hamburger menu
- Form validation with real-time feedback
- File upload with preview
- Image lightbox gallery
- Progress indicators
- Loading states
- Success/error notifications
- Auto-save functionality (optional)

## 🛠️ Technologies Used

### Frontend
- **HTML5**: Semantic markup and structure
- **CSS3**: Modern styling with animations and transitions
- **JavaScript (ES6+)**: Interactive features and form handling
- **Font Awesome**: Icon library
- **Google Fonts**: Typography (Poppins)

### Backend
- **PHP**: Server-side form processing
- **JSON**: Data storage for profiles and submissions
- **Email**: PHP mail function for notifications

## 📁 Project Structure

```
kalakaar-film-casting/
├── index.html                 # Homepage
├── submit.html               # Profile submission page
├── css/
│   ├── style.css             # Main stylesheet
│   └── submit.css            # Submit page specific styles
├── js/
│   ├── script.js             # Main JavaScript functionality
│   └── submit.js             # Submit page specific JavaScript
├── php/
│   ├── contact.php           # Contact form handler
│   └── submit-profile.php   # Profile submission handler
├── images/
│   ├── hero1.jpg
│   ├── hero2.jpg
│   ├── hero3.jpg
│   ├── about-image.jpg
│   ├── talent/
│   ├── gallery/
│   └── testimonials/
├── uploads/
│   └── profiles/            # Uploaded profile photos
├── data/
│   └── profiles.json        # Stored profile data
├── logs/
│   ├── contact_submissions.json
│   └── profile_submissions.json
└── README.md                # This file
```

## 🚀 Setup Instructions

### Prerequisites
- PHP 7.4 or higher
- Web server (Apache, Nginx, or XAMPP)
- PHP mail function configured (or SMTP for email sending)

### Local Development Setup

1. **Download/Clone the Project**
   ```bash
   git clone <repository-url>
   cd kalakaar-film-casting
   ```

2. **Set Up Local Server**
   - Using XAMPP:
     - Place the project folder in `htdocs/`
     - Start Apache server
     - Access via `http://localhost/kalakaar-film-casting`
   
   - Using other servers:
     - Configure your web server to point to the project directory

3. **Create Required Directories**
   ```bash
   mkdir -p uploads/profiles
   mkdir -p data
   mkdir -p logs
   chmod 755 uploads/ data/ logs/
   chmod 777 uploads/profiles/
   ```

4. **Configure Email Settings**
   - Edit `php/contact.php` and `php/submit-profile.php`
   - Update the `$to` variable with your actual email address
   - For production, configure SMTP settings in `php.ini`

5. **Add Sample Images**
   - Add placeholder images to the `images/` directory:
     - `hero1.jpg`, `hero2.jpg`, `hero3.jpg` for hero slider
     - `about-image.jpg` for about section
     - Images in `talent/`, `gallery/`, and `testimonials/` subdirectories

## 🌐 Deployment Instructions

### Option 1: Traditional Hosting (cPanel/Plesk)

1. **Upload Files**
   - Upload all files to your web root directory (`public_html` or `www`)

2. **Set Permissions**
   - Ensure PHP files have execute permissions
   - Set write permissions for `uploads/`, `data/`, and `logs/` directories

3. **Configure Email**
   - Update email addresses in PHP files
   - Test email functionality

4. **Test Website**
   - Verify all pages load correctly
   - Test contact and profile submission forms

### Option 2: Static Hosting with Backend API (Netlify/Vercel + Backend)

1. **Frontend Deployment**
   - Deploy HTML, CSS, and JavaScript files to Netlify or Vercel
   - Configure build settings if needed

2. **Backend Deployment**
   - Deploy PHP files to a server that supports PHP
   - Update API endpoints in JavaScript files to point to your backend

3. **CORS Configuration**
   - Add CORS headers to PHP files if frontend and backend are on different domains

### Option 3: Modern Deployment (Docker)

1. **Create Dockerfile**
   ```dockerfile
   FROM php:8.0-apache
   COPY . /var/www/html/
   RUN chmod -R 755 /var/www/html/
   RUN docker-php-ext-install mysqli
   EXPOSE 80
   ```

2. **Build and Run**
   ```bash
   docker build -t kalakaar-website .
   docker run -p 80:80 kalakaar-website
   ```

## ⚙️ Configuration

### Email Configuration
Update these variables in PHP files:
- `$to` - Recipient email address
- `$from` - Sender email address
- Configure SMTP in `php.ini` for reliable email delivery

### Customization Options

1. **Colors and Branding**
   - Edit CSS variables in `css/style.css`:
     ```css
     :root {
         --primary-color: #FF6B35;
         --secondary-color: #F7931E;
         --dark-color: #1a1a1a;
         /* ... other variables */
     }
     ```

2. **Content Updates**
   - Update text content in HTML files
   - Replace placeholder images with actual photos
   - Update contact information

3. **Form Fields**
   - Add/remove fields in `submit.html`
   - Update validation in `js/submit.js`
   - Modify PHP handlers accordingly

## 🔧 Maintenance

### Regular Tasks
1. **Monitor Uploads**
   - Clean up old profile photos periodically
   - Monitor disk space usage

2. **Backup Data**
   - Regularly backup `data/` and `logs/` directories
   - Export profile data for safekeeping

3. **Update Content**
   - Keep portfolio and gallery content fresh
   - Update testimonials regularly

### Security Considerations
1. **File Uploads**
   - Implement virus scanning for uploaded files
   - Regular security audits of upload functionality

2. **Data Protection**
   - Implement GDPR compliance if needed
   - Secure sensitive personal information

3. **Regular Updates**
   - Keep PHP version updated
   - Monitor for security vulnerabilities

## 🐛 Troubleshooting

### Common Issues

1. **Email Not Sending**
   - Check PHP mail configuration
   - Verify SMTP settings
   - Check spam folders

2. **File Upload Issues**
   - Check directory permissions
   - Verify PHP upload limits in `php.ini`
   - Ensure sufficient disk space

3. **Form Validation Errors**
   - Check browser console for JavaScript errors
   - Verify PHP error logs
   - Test with different browsers

4. **Images Not Loading**
   - Verify file paths
   - Check image file formats
   - Ensure proper permissions

### Debug Mode
To enable debugging, add this to PHP files:
```php
error_reporting(E_ALL);
ini_set('display_errors', 1);
```

## 📱 Browser Support

- Chrome 60+
- Firefox 55+
- Safari 12+
- Edge 79+
- Mobile Safari (iOS 12+)
- Chrome Mobile (Android 8+)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License. See LICENSE file for details.

## 📞 Support

For support and questions:
- Email: info@kalakaar-casting.com
- Phone: +91 98765 43210
- Address: 123 Film Nagar, Andheri West, Mumbai

---

**Note**: This is a demonstration website. Replace placeholder content, images, and contact information with actual data before deployment.
