FROM alpine:edge

ADD start_runit /sbin/
RUN sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf && \
	echo 'rc_provide="loopback net"' >> /etc/rc.conf && \
	sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf &&\
	mkdir /etc/container_environment &&\
        chmod a+x /sbin/start_runit && mkdir /etc/service && mkdir /etc/runit_init.d && \
        echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
        apk --update upgrade && apk add runit && rm -rf /var/cache/apk/*

CMD ["/sbin/start_runit"]
