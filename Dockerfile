FROM python:3.11-slim
LABEL maintainer="Soxoj <soxoj@protonmail.com>"
WORKDIR /app
RUN pip install --no-cache-dir --upgrade pip
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      gcc \
      build-essential \
      pkg-config \
      musl-dev \
      libxml2 \
      libxml2-dev \
      libxslt-dev \
      libcairo2-dev \
      libpango1.0-dev \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/*
COPY . .
RUN YARL_NO_EXTENSIONS=1 python3 -m pip install --no-cache-dir .
# For production use, set FLASK_HOST to a specific IP address for security
ENV FLASK_HOST=0.0.0.0
ENTRYPOINT ["maigret"]
