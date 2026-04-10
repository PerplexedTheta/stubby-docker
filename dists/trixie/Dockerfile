FROM stubby AS initial

FROM debian:trixie

COPY files/stubby.example.yml /
COPY files/entrypoint.sh /

RUN /usr/bin/apt update && \
    /usr/bin/apt install -y openssl ca-certificates stubby iputils-ping bind9-dnsutils passwd adduser && \
    /usr/bin/rm -rf /var/lib/apt/lists/* && \
    /usr/sbin/adduser --system stubby --group --no-create-home --gecos '' --disabled-password && \
    /usr/bin/mkdir -p /var/cache/stubby && \
    /usr/bin/chown -R stubby:stubby /var/cache/stubby && \
    /usr/sbin/update-ca-certificates

EXPOSE 53/tcp 53/udp

CMD ["/entrypoint.sh"]
