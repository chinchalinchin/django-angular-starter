# TODO: Migrations
python debug.py

if [ "$ENVIRONMENT" == "container" ]
then
    python manage.py collectstatic --noinput
    gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
fi