FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# تثبيت XFCE + XRDP + أدوات أساسية
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies xrdp sudo nano wget curl \
    firefox dbus-x11 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# إعداد كلمة السر للمستخدم root (بدلها!)
RUN echo "root:StrongPass123!" | chpasswd
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

# إعدادات xrdp
RUN echo "startxfce4" > /root/.xsession && chmod +x /root/.xsession

EXPOSE 3389

CMD ["/usr/sbin/xrdp", "--nodaemon"]
