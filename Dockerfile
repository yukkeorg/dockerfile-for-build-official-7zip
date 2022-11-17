ARG FROM_IMAGE_TAG
FROM ubuntu:${FROM_IMAGE_TAG}

ARG SEVEN_ZIP_VERSION

RUN apt update -y
RUN apt install -y wget make gcc g++ tar xz-utils

WORKDIR /build
RUN wget --show-progress -O- https://www.7-zip.org/a/7z${SEVEN_ZIP_VERSION}-src.tar.xz | tar xJf -
RUN cd CPP/7zip/Bundles/Alone2/ && make -f makefile.gcc

ENTRYPOINT [ "CPP/7zip/Bundles/Alone2/_o/7zz" ]