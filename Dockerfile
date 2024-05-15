FROM python:3

# Создаем директорию для сохранения ключей GPG
RUN mkdir -p /etc/apt/trusted.gpg.d

# Экспортируем все ключи GPG в файл /etc/apt/trusted.gpg.d/docker.gpg
RUN apt-key exportall > /etc/apt/trusted.gpg.d/docker.gpg

# Устанавливаем необходимые пакеты, включая wget
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Копируем файлы приложения и устанавливаем зависимости Python
WORKDIR /code/dvc
COPY . /code/dvc
RUN pip install --no-cache-dir -r requirements.txt

# Опционально, выполните миграции базы данных
# RUN python manage.py migrate

# Запускаем приложение
CMD ["bash", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]


