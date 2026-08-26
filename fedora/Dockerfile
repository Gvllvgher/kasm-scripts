ARG BASE_TAG="1.19.0-rolling-weekly"
ARG BASE_IMAGE="core-fedora-43"
FROM kasmweb/$BASE_IMAGE:$BASE_TAG

USER root

ENV DISTRO=fedora43
ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

ENV SKIP_CLEAN=true \
    KASM_RX_HOME=$STARTUPDIR/kasmrx \
    DONT_PROMPT_WSL_INSTALL="No_Prompt_please"

RUN dnf install -y vlc \
	zsh \
	tmux \
	xz \
	firefox \
	neovim \
	iputils \
	bind-utils \
	flatpak

RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install flathub com.bitwarden.desktop -y

# Install starship prompt
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# Allow kasm-user sudo access
RUN echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
