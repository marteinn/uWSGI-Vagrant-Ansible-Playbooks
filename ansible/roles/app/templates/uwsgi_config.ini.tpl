[uwsgi]
uid = {{ deploy_user }}
gid = www-data

project = {{ app_name }}
base = {{ web_dir }}

home = {{ venv_dir }}
chdir = {{ web_dir }}
module = wsgi:application

{% if app_dev == '1' %}
python-autoreload = 3
{% else %}
touch-reload = {{ app_dir }}/uwsgi_config.ini
{% endif %}

master = true
processes = 2

socket = /var/uwsgi/{{ app_name }}.sock
chmod-socket = 664
chown-socket = {{ deploy_user }}:www-data
vacuum = true
