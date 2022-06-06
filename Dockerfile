FROM ubuntu:18.04

ENV HOME /home/gstreamer_user

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe
 
RUN apt-get update \
    && apt-get install -y \
        cmake \
        git \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libgstreamer-plugins-bad1.0-dev \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-libav \
        gstreamer1.0-doc \
        gstreamer1.0-tools \
        gstreamer1.0-x \
        gstreamer1.0-alsa \
        gstreamer1.0-gl \
        gstreamer1.0-gtk3 \
        gstreamer1.0-qt5 \ 
        gstreamer1.0-pulseaudio \
        libgstrtspserver-1.0-0 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoclean

WORKDIR ${HOME}/opt

RUN git clone git://anongit.freedesktop.org/gstreamer/gst-rtsp-server \
        && cd gst-rtsp-server \
        && git checkout remotes/origin/1.2 \
        && ./autogen.sh --noconfigure && GST_PLUGINS_GOOD_DIR=$(pkg-config --variable=pluginsdir gstreamer-plugins-bad-1.0) ./configure \
        && make \
        && make install

WORKDIR ${HOME}

ADD Makefile ${HOME}/Makefile
COPY src ${HOME}/src

RUN gcc -Wall src/main.cpp -o main $(pkg-config --cflags --libs gstreamer-1.0 gstreamer-rtsp-server-1.0)
# RUN make

ENV GST_DEBUG=2

CMD ["./main", "( v4l2src device=/dev/video0 ! video/x-raw,height=360,width=640 ! decodebin ! videoconvert ! videoconvert ! video/x-raw,format=I420 ! x264enc tune=zerolatency byte-stream=true bitrate=2000 ! rtph264pay name=pay0 pt=96 )"]

