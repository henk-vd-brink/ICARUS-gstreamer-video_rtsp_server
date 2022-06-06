CFLAGS = -Wall $(shell pkg-config --cflags --libs gstreamer-1.0 gstreamer-rtsp-server-1.0)

all:
	gcc src/main.cpp -o main $(CFLAGS)