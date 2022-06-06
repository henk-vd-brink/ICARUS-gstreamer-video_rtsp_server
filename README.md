## About the Project
This repository contains a containerized gstreamer rtsp server.

default src: /dev/video0 \
default sink: rtsp-server at 127.0.0.1:8554/test

Note: the number of possible streams is dependent on the input source, e.g., usb only supports 1 stream.

## Getting Started

### Preqrequisites
- Linux device
- Docker
- USB camera

### Installation
```
git clone https://github.com/henk-vd-brink/ICARUS-gstreamer-video_rtsp_server.git
cd ICARUS-gstreamer-video_rtsp_server
```

### Build
```
docker build -t icarus-rs-image.
```

### Run
```
docker run --name icarus-rs -p 8554:8554 --device /dev/video0 -d icarus-rs-image
```

## Additional Information

Open stream with VLC:
```
rtsp://127.0.0.1:8554/test
```

Open stream with gstreamer
```
gst-launch-1.0 -v rtspsrc location=rtsp://<ip_address>:8554/test latency=0 buffer-mode=auto ! decodebin ! videoconvert ! autovideosink sync=false
```

### Inspect Camera

Possible caps
```
v4l2-ctl -d /dev/video0 --list-formats-ext
```