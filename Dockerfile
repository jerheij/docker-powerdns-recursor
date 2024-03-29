FROM oraclelinux:8
HEALTHCHECK --interval=35s --timeout=4s CMD host -W 1 -t AAAA www.google.com localhost
COPY entry.sh /entry.sh
RUN dnf check-update ; \
    dnf update -y && \
    dnf install oracle-epel-release-el8 -y && \
    dnf install pdns-recursor bind-utils -y && \
    dnf remove geolite2* -y && \
    dnf clean all && \
    chmod +x /*.sh
EXPOSE 53
ENTRYPOINT ["/entry.sh"]
CMD ["pdns_recursor", "--daemon=no"]
