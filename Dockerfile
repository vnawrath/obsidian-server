FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# Install additional packages if needed
RUN apt-get update && apt-get install -y \
    firefox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set default resolution
ENV VNC_RESOLUTION=1280x720

# Expose port 80 for noVNC web access
EXPOSE 80
