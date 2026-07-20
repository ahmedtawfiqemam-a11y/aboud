FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# تثبيت كل المتطلبات
RUN apt-get update && apt-get install -y \
    software-properties-common curl wget git \
    build-essential libmagic1 libmagic-dev \
    ffmpeg portaudio19-dev \
    golang-go \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y \
    python3.11 python3.11-dev python3.11-distutils \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# تثبيت pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

WORKDIR /app

# سكريبت التشغيل - بيجيب الكود وقت التشغيل بس
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]
