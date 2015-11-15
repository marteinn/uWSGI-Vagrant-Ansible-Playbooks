upstream {{ app_name }} {
    server unix:/var/uwsgi/{{ app_name }}.sock;
}

server {
    listen  80;

    server_name {{ app_domain }};
    access_log  {{ logs_dir }}/access.log;
    error_log  {{ logs_dir }}/error.log info;

    error_page 404 /404.html;

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        root /usr/share/nginx/www;
    }

    # Serve static content (for instance through djangos autocollect)
    location /static {
        autoindex on;
        alias {{ web_dir }}/static;
    }

    location / {
        uwsgi_pass  {{ app_name }};
        include     {{ app_dir }}/uwsgi_params;
    }
}
