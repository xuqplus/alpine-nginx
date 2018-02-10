FROM alpine

MAINTAINER xuqplus

RUN apk --update add openssl-dev pcre-dev zlib-dev wget build-base && \
        adduser -D nginx && \
        wget https://raw.githubusercontent.com/xuqplus/alpine-nginx/master/source/nginx-1.12.2.tar.gz && \
        tar xzvf nginx-1.12.2.tar.gz && \
        cd nginx-1.12.2 && \
        ./configure \
            --prefix=/var/lib/nginx \
            --sbin-path=/usr/sbin/nginx \
            --modules-path=/usr/lib/nginx/modules \
            --conf-path=/etc/nginx/nginx.conf \
            --pid-path=/run/nginx/nginx.pid \
            --lock-path=/run/nginx/nginx.lock \
            --user=nginx \
            --group=nginx \
            --with-threads \
            --with-http_ssl_module \
            --with-http_v2_module \
            --with-http_realip_module \
            --with-http_addition_module \
            --with-http_sub_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_mp4_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_auth_request_module \
            --with-http_random_index_module \
            --with-http_secure_link_module \
            --with-http_degradation_module \
            --with-http_slice_module \
            --with-http_stub_status_module \
            --with-mail=dynamic \
            --with-mail_ssl_module \
            --with-stream \
            --with-stream_ssl_module \
            --with-stream_realip_module \
            --with-stream_ssl_preread_module && \
        make install && \
        apk del build-base && \
        rm -rf /nginx-1.12.2* && \
        rm -rf /var/cache/apk/*

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
