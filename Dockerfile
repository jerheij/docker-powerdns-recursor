FROM centos:latest
COPY entry.sh /entry.sh
RUN dnf check-update ; \
    dnf update -y

RUN dnf install epel-release -y && \
    dnf install pdns-recursor -y && \
    dnf clean all && \
    chmod +x /*.sh
EXPOSE 53
ENTRYPOINT ["/entry.sh"]
CMD ["pdns_recursor", "--daemon=no"]
