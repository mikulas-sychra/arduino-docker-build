FROM ubuntu
MAINTAINER suculent

RUN apt-get update && apt-get install -y wget unzip git make srecord bc xz-utils gcc curl xvfb

RUN curl https://downloads.arduino.cc/arduino-1.8.3-linux64.tar.xz > ./arduino-1.8.3-linux64.tar.xz \
 && unxz ./arduino-1.8.3-linux64.tar.xz \
 && ls -la \
 && tar -xvf arduino-1.8.3-linux64.tar \
 && rm -rf arduino-1.8.3-linux64.tar \
 && mv ./arduino-1.8.3 /opt/arduino \
 && cd /opt/arduino \
 && ./install.sh

RUN mkdir /opt/arduino-firmware
RUN mkdir /opt/arduino-firmware/test
WORKDIR /opt/arduino-firmware
EXPOSE 22
COPY cmd.sh /opt/
COPY ./test/test.ino /opt/arduino-firmware/test/test.ino
CMD /opt/cmd.sh