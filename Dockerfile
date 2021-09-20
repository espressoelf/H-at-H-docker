FROM openjdk:11-jre-slim

ARG HatH_VERSION=1.6.1
ARG HatH_SHA256=b8889b2c35593004be061064fcb6d690ff8cbda9564d89f706f7e3ceaf828726

WORKDIR /hath
ADD build/start.sh .
ADD https://repo.e-hentai.org/hath/HentaiAtHome_$HatH_VERSION.zip .

RUN apt update \
    && apt install -y unzip sqlite3 \
    && rm /var/lib/apt/lists/* \
    && echo -n ""$HatH_SHA256" HentaiAtHome_$HatH_VERSION.zip" | sha256sum -c \
    && unzip HentaiAtHome_$HatH_VERSION.zip \
    && rm HentaiAtHome_$HatH_VERSION.zip \
    && mkdir -p /hath/data \
    && mkdir -p /hath/download \
    && chmod +x start.sh

ENV HatH_ARGS --cache-dir=/hath/data/cache --data-dir=/hath/data/data --download-dir=/hath/download --log-dir=/hath/data/log --temp-dir=/hath/data/temp

CMD ["/hath/start.sh"]


