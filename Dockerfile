# Use the official Ubuntu 20.04 LTS base image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils && \
    apt-get install -y xrdp && \
    apt-get install -y supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a new user 'ubuntu' with password 'ubuntu'
RUN useradd -m -s /bin/bash ubuntu && echo 'ubuntu:ubuntu' | chpasswd

# Grant sudo privileges to the 'ubuntu' user (optional)
RUN apt-get update && apt-get install -y sudo && \
    echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Configure xrdp to use xfce4
RUN echo 'xfce4-session' > /home/ubuntu/.xsession && \
    chown ubuntu:ubuntu /home/ubuntu/.xsession

# Update xrdp startup script to start xfce4
RUN sed -i.bak '/fi/a #xrdp multiple users configuration \nstartxfce4' /etc/xrdp/startwm.sh

# Expose RDP port
EXPOSE 3389

# Start supervisord to manage services
CMD ["/usr/bin/supervisord", "-n"]
