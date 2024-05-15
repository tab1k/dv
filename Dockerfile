# Используем базовый образ Python 3
FROM python:3

# Обновляем пакеты и устанавливаем wget
RUN apt-get update && apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Устанавливаем ключи для проверки подлинности пакетов Debian
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 \
               --recv-keys 6ED0E7B82643E131 --recv-keys F8D2585B8783D481 \
               --recv-keys 54404762BBB6E853 --recv-keys BDE6D2B9216EC7A8

# Устанавливаем libpq-dev
RUN apt-get update && apt-get install -y --no-install-recommends libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Копируем необходимые файлы в рабочую директорию
COPY . /app

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt

# Команда для запуска приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


