FROM fedora:27

ARG MNT="dmitry sevostyanov"
ARG YUM=yum

MAINTAINER $MNT

RUN \
    $YUM install -y --setopt=tsflags=nodocs \
	git \
	golang \
	make \
	tar \
    && \
    $YUM clean all

ENV \
    SUMMARY="Golang S2I" \
    DESCRIPTION="Description of $SUMMARY" \
    # Path to be used in other layers to place s2i scripts into
    S2I_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    # The $HOME is not set by default, but some applications needs this variable
    HOME=/opt/app-root/src

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="golang s2i" \
      io.openshift.s2i.scripts-url=image://$S2I_SCRIPTS_PATH \
      io.s2i.scripts-url=image://$S2I_SCRIPTS_PATH \
      version="1" \
      release="1" \
      maintainer="$MNT" \
      io.openshift.tags="builder,go"

ENV \
    GOPATH=$HOME/go \
    GOBIN=$HOME/go/bin \
    SOURCE=$HOME/go/src

ENV \
    PATH=$GOBIN:$PATH

COPY s2i ${S2I_SCRIPTS_PATH}/

CMD ${S2I_SCRIPTS_PATH}/usage
