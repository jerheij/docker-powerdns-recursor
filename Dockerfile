FROM centos:latest
HEALTHCHECK --interval=35s --timeout=4s CMD host -W 1 -t AAAA www.google.com localhost
COPY entry.sh /entry.sh
RUN dnf check-update ; \
    dnf update -y

RUN dnf install epel-release -y && \
    dnf install pdns-recursor bind-utils -y && \
    dnf remove geolite2* -y && \
    dnf clean all && \
    chmod +x /*.sh
EXPOSE 53
ENTRYPOINT ["/entry.sh"]
CMD ["pdns_recursor", "--daemon=no"]
