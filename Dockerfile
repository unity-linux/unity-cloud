FROM jmiahman/mageia-rpmbuilder:latest
MAINTAINER JMiahMan <JMiahMan@Unity-Linux.org>
RUN dnf -y install --setopt=install_weak_deps=False 'dnf-command(copr)'
RUN dnf copr enable jmiahman/Unity-Linux -y
RUN dnf -y reinstall --setopt=install_weak_deps=False systemd
RUN dnf -y install --setopt=install_weak_deps=False systemd grub2 wget curl openssh-clients openssh-server dhcp-client cloud-init cloud-utils*
RUN dnf -y install --setopt=install_weak_deps=False dnf-plugins-core mock mgarepo rpmdevtools rpm-sign cracklib-dicts rpmlint intltool
RUN dnf update -y
RUN dnf clean all
RUN useradd builder -G mock -M -d /rpmbuild
RUN useradd live
RUN echo "config_opts['cache_topdir'] = '/rpmbuild/cache'" >> /etc/mock/site-defaults.cfg
RUN echo "root:Unity!" | chpasswd
RUN passwd -d root
VOLUME [ "/rpmbuild" ]
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/bin/bash"]
