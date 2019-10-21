FROM centos:7
COPY entry.sh /entry.sh
RUN sed -i 's~enabled=1~enabled=0~g' /etc/yum/pluginconf.d/fastestmirror.conf && \
    rm -f /var/cache/yum/timedhosts.txt && \
    yum check-update ; \
    yum update -y

RUN yum install epel-release -y && \
    yum install pdns-recursor -y && \
    yum clean all && \
    chmod +x /*.sh
EXPOSE 53
ENTRYPOINT ["/entry.sh"]
CMD ["pdns_recursor", "--daemon=no"]
