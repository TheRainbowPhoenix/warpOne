 
FROM gradle:jdk8

USER root
RUN apk update && apk add thrift

COPY . /warpOne
WORKDIR /warpOne
ENTRYPOINT ["./gradlew", "pack"]