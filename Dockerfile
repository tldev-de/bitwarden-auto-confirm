FROM debian:12-slim AS downloader

RUN apt update && apt install -y curl unzip

# install bitwarden cli
RUN curl -s -L -o /tmp/bw.zip "https://bitwarden.com/download/?app=cli&platform=linux" && unzip /tmp/bw.zip && rm /tmp/bw.zip && mv bw /usr/local/bin/bw && chmod +x /usr/local/bin/bw

FROM debian:12-slim

# install dependencies
RUN apt update && apt install -y jq && apt clean

# get bitwarden cli
COPY --from=downloader /usr/local/bin/bw /usr/local/bin/bw

# Change to non-root privilege
RUN useradd -ms /bin/bash nonroot
USER nonroot

COPY *.sh /

ENV SYNC_INTERVAL=600

CMD ["/loop.sh"]