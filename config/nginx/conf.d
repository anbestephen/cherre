upstream develop_server {
    server app:8000;
}

server {
    listen 8000;
    server_name localhost;

    location / {
        proxy_read_timeout 300;
        proxy_pass http://develop_server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }

    location /static/ {
        autoindex on;
        alias /var/www/my_project/staticfiles;
    }
}
