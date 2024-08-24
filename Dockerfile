FROM python:3.11.9-slim-bookworm

RUN apt-get update && apt-get install -y build-essential gcc g++
RUN apt-get install -y nginx
RUN apt-get install -y procps
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -r nginx

WORKDIR /app

COPY app/requirements.txt /app/
RUN pip install -U pip
RUN pip install -U setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ /app/

COPY nginx.conf /etc/nginx/nginx.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5001

CMD ["/start.sh"]
