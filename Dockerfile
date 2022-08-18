FROM ghcr.io/puppeteer/puppeteer:latest

USER root

WORKDIR /root/

RUN wget -q https://github.com/google/fonts/archive/main.tar.gz -O gf.tar.gz

RUN tar -xf gf.tar.gz

RUN mkdir -p /usr/share/fonts/truetype/google-fonts

RUN find $PWD/fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1

RUN rm -f gf.tar.gz

RUN fc-cache -f && rm -rf /var/cache/*

RUN apt-get update \
    && apt-get install -y fonts-noto fonts-noto-color-emoji \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

USER pptruser

CMD ["google-chrome-stable"]