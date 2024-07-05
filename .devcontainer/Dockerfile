 
FROM gradle:jdk8-jammy

USER root


# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt update
RUN apt install -y automake bison flex g++ git libboost-all-dev libevent-dev libssl-dev libtool make pkg-config wget
RUN wget "http://archive.apache.org/dist/thrift/0.17.0/thrift-0.17.0.tar.gz"
RUN echo "b272c1788bb165d99521a2599b31b97fa69e5931d099015d91ae107a0b0cc58f  thrift-0.17.0.tar.gz" | sha256sum -c -
RUN tar xf thrift-0.17.0.tar.gz
RUN cd thrift-0.17.0
RUN sudo mkdir -p /opt/thrift-0.17.0
RUN ./bootstrap.sh
RUN ./configure \
    --prefix=/opt/thrift-0.17.0 \
    --without-cpp \
    --without-qt5 \
    --without-c_glib \
    --without-java \
    --without-kotlin \
    --without-erlang \
    --without-nodejs \
    --without-nodets \
    --without-lua \
    --without-python-sys-prefix \
    --without-python_prefix \
    --without-python_exec_prefix \
    --without-python \
    --without-py3 \
    --without-perl \
    --without-php \
    --without-php_extension \
    --without-dart \
    --without-ruby \
    --without-go \
    --without-swift \
    --without-rs \
    --without-haxe \
    --without-netstd \
    --without-d     
RUN make -j
RUN make install
RUN /opt/thrift-0.17.0/bin/thrift -version

ENV THRIFT_HOME=/opt/thrift-0.17.0

# Allow for a consistant java home location for settings - image is changing over time
RUN if [ ! -d "/docker-java-home" ]; then ln -s "${JAVA_HOME}" /docker-java-home; fi

COPY . /warpOne
WORKDIR /warpOne
# ENTRYPOINT ["./gradlew", "pack"]