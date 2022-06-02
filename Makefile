build:
	sudo docker build -t icarus-cpp-rtsp_server-image .

run: build
	sudo docker run -p 8554:8554 --rm --device /dev/video0 --name icarus-cpp-rtsp_server icarus-cpp-rtsp_server-image