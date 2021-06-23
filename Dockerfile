FROM agners/archlinuxarm as build

RUN pacman -Suy --noconfirm &&\
    pacman -S --noconfirm git sudo go base-devel shadow

RUN useradd -m yay &&\
    mkdir /build &&\
    chown yay:yay -R /build

USER yay
RUN cd /build &&\
    git clone https://aur.archlinux.org/yay.git &&\
    cd yay &&\
    makepkg &&\
    mv yay-*.pkg.tar.* yay.pkg.tar

FROM agners/archlinuxarm

COPY --from=build /build/yay/yay.pkg.tar /

RUN pacman -Suy --noconfirm &&\
    pacman -S --noconfirm git sudo base-devel shadow &&\
    pacman -U --noconfirm /yay.pkg.tar

RUN useradd -m yay &&\
    echo "yay ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER yay

WORKDIR /home/yay
ENTRYPOINT [ "/bin/bash" ]