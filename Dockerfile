FROM ubuntu:latest

# Set Labels
LABEL org.opencontainers.image.source="https://github.com/simeononsecurity/docker-ffmpeg-mp4-folder"
LABEL org.opencontainers.image.description="Stream From a Folder of MP4 Files to Twitch, YouTube, andor Kick"
LABEL org.opencontainers.image.authors="simeononsecurity"

# Set ENV Variables
ENV DEBIAN_FRONTEND noninteractive
ENV container docker
ENV TERM=xterm
ENV VIDEO_DIR=/videos

# Install necessary dependencies
RUN apt update && \
    apt full-upgrade -y --no-install-recommends && \
    apt install -y \
    ffmpeg \
    wget

# Create videos directory and add a test video
RUN mkdir -p /videos && \
    cd /videos && \
    wget -O test.mp4 https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4

# Copy the shell script into the container
COPY stream_videos.sh /usr/local/bin/

# Set execute permissions for the script
RUN chmod +x /usr/local/bin/stream_videos.sh

# Set the working directory
WORKDIR /videos

# Set the entrypoint to the shell script
ENTRYPOINT ["/usr/local/bin/stream_videos.sh"]
