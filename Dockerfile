FROM		andreptb/maven:3.3.9-alpine

MAINTAINER	Joel Chen <http://lnkd.in/bwwnBWR>

ENV		GOPATH /go
ENV		SRCPATH ${GOPATH}/src/github.com/adnanh
ENV		WEBHOOK_VERSION 2.3.8

RUN		apk add --update curl go git libc-dev gcc libgcc openssh-client && \
		curl -L -o /tmp/webhook-${WEBHOOK_VERSION}.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
		mkdir -p ${SRCPATH} && tar -xvzf /tmp/webhook-${WEBHOOK_VERSION}.tar.gz -C ${SRCPATH} && \
		mv -f ${SRCPATH}/webhook-* ${SRCPATH}/webhook && \
		cd ${SRCPATH}/webhook && go get -d && go build -o /usr/local/bin/webhook && \
		apk del --purge curl go libc-dev gcc libgcc && \
		rm -rf /var/cache/apk/* && \
		rm -rf ${GOPATH}

EXPOSE		9000

ENTRYPOINT	["/usr/local/bin/webhook"]