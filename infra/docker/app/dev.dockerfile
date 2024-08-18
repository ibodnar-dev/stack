FROM python:3.11-slim

WORKDIR /code

COPY ../../../app/config/requirements/base.txt base.txt
COPY ../../../app/config/requirements/dev.txt requirements.txt

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY ../../../app/src /code/app

CMD ["fastapi", "run", "app/main.py", "--port", "8081"]
