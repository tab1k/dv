FROM python:3

# Add Debian package repository keys directly
RUN apt-get update && apt-get install -y gnupg
RUN wget -qO - https://deb.debian.org/debian-archive-keyring.gpg | gpg --dearmor > /usr/share/keyrings/debian-archive-keyring.gpg

# Install necessary packages
RUN apt-get update && apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Copy application files and install dependencies
WORKDIR /code/dvc
COPY . /code/dvc
RUN pip install --no-cache-dir -r requirements.txt

# Optional: Run database migrations
# RUN python manage.py migrate

# Start the application
CMD ["bash", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]



