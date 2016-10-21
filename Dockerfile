FROM alpine:3.4

MAINTAINER Marcel Dias <marceldiass@gmail.com>
LABEL Description="It is an AlpineLinux 3.4 with Oracle Server JRE 8 image"
LABEL SERVER-JRE-VERSION="8u112-b15"

# Java Version and other ENV
ENV JAVA_VERSION_MAJOR=8 \
   JAVA_VERSION_MINOR=112 \
   JAVA_VERSION_BUILD=15 \
   JAVA_PACKAGE=server-jre \
   JAVA_HOME=/opt/jdk \
   PATH=${PATH}:/opt/jdk/bin \
   GLIBC_VERSION=2.23-r3 \
   LANG=C.UTF-8

# do all in one step
RUN apk upgrade --update && \
    apk add --update curl ca-certificates bash sudo && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do \
      curl -sSL https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; \
    done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    mkdir /opt && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
        | tar -xzf - -C /opt && \
        ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk && \
    apk del curl glibc-i18n && \
    rm -rf /tmp/* /var/cache/apk/*

CMD ["java", "-version"]
