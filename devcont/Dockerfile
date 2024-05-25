FROM ubuntu AS dev
WORKDIR /workspace
SHELL ["/bin/bash", "-c"]

# Setup neovim config in container
COPY kickstart.nvim/ /root/.config/nvim/

COPY packages.txt /tmp

# Download zellij terminal multiplexer into container
ADD https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz /tmp

# Use local region mirror for install packages
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirrors.gbnetwork.com/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources && \
    apt update

# Install kickstart.nvim dependencies
RUN apt install -y git make unzip gcc ripgrep npm fzf neovim fish curl && \
    xargs -a /tmp/packages.txt apt install -y && \
    tar -xzf /tmp/zellij-x86_64-unknown-linux-musl.tar.gz -C /bin && \
    mkdir -p /root/.config/nvim

# Setup neovim
RUN git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable /lazy/lazy.nvim && nvim "+Lazy! install" +MasonToolsInstallSync +q!

# Start container with Zellij terminal multiplexer
CMD ["zellij", "options", "--default-shell", "fish"]

FROM dev AS dev-python
WORKDIR /workspace
SHELL ["/bin/bash", "-c"]

# Copy python module requirements into container
COPY requirements.txt /tmp

# Install kickstart.nvim and python dependencies
RUN apt install -y python3 python3-pip && \
    pip install -r /tmp/requirements.txt --break-system-packages

CMD ["zellij", "options", "--default-shell", "fish"]