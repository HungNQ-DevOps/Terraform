#!/bin/bash

echo "hello world"

# Initial set up
sudo apt-get update -y
sudo apt-get install nginx -y

your_domain="terraform"
user="ubuntu"

# Set up nginx
sudo mkdir -p /var/www/$your_domain/html
sudo chown -R $user:$user /var/www/$your_domain/html
sudo chown -R $user:$user /var/www/$your_domain/html
sudo chmod -R 755 /var/www/$your_domain

cat <<EOF >> /var/www/$your_domain/html/index.html
<html>
    <head>
        <title>Welcome to $your_domain!</title>
    </head>
    <body>
        <h1>Success!  The $your_domain server block is working!</h1>
    </body>
</html>
EOF

sudo chown -R $user:$user /etc/nginx/sites-available/

cat <<EOF >> /etc/nginx/sites-available/$your_domain
server {
        listen 80;
        listen [::]:80;

        root /var/www/$your_domain/html;
        index index.html index.htm index.nginx-debian.html;

        server_name $your_domain www.$your_domain;

        location / {
                try_files \$uri \$uri/ =404;
        }
}
EOF

sudo ln -s /etc/nginx/sites-available/$your_domain /etc/nginx/sites-enabled/

sudo chown -R $user:$user /etc/nginx/

### Edit line 22 and 60
sed -i '22s/.*/        server_names_hash_bucket_size 64;/' /etc/nginx/nginx.conf
sed -i '60s/.*/        include \/etc\/nginx\/sites-enabled\/terraform;/' /etc/nginx/nginx.conf

# Restart ngnix
sudo nginx -t
sudo systemctl restart nginx