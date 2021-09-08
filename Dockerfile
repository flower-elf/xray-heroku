FROM alpine:latest
ADD configure.sh /configure.sh
RUN apk add --no-cache ca-certificates wget \
 && chmod +x /configure.sh
CMD /configure.sh
