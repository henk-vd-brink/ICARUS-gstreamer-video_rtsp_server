gst-launch-1.0 -v rtspsrc location=rtsp://192.168.178.200:8554/test latency=0 buffer-mode=auto ! decodebin ! videoconvert ! autovideosink sync=false


build:
	sudo docker build -t icarus-cpp-rtsp_server-image .

run: build
	sudo docker run -p 8554:8554 --rm --device /dev/video0 --name icarus-cpp-rtsp_server icarus-cpp-rtsp_server-image