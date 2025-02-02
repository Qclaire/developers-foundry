#!/bin/bash

# Update and install necessary packages
sudo apt update -y
sudo apt upgrade -y
sudo apt remove -y apache2
sudo apt remove -y nginx
sudo apt install -y nginx

DD_API_KEY=${var.data-dog-api-key} DD_SITE="${data-dog-site}" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"


sudo systemctl start nginx
sudo systemctl enable nginx

sudo usermod -a -G www-data ubuntu
sudo chown -R ubuntu:www-data /var/www/html
sudo chmod 2775 /var/www/html
find /var/www/html -type d -exec sudo chmod 2775 {} \;
find /var/www/html -type f -exec sudo chmod 0664 {} \;

cat << 'EOF' | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Current Time</title>
</head>
<body>
    <h1>Welcome to NGINX on Ubuntu!</h1>
    <p>The current time is: <span id="current-time"></span></p>
    <script>
        function updateTime() {
            const now = new Date();
            document.getElementById('current-time').textContent = now.toLocaleTimeString();
        }
        setInterval(updateTime, 1000);
        updateTime();
    </script>
</body>
</html>
EOF

sudo systemctl restart nginx
