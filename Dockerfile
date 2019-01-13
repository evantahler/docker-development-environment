FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openssh-server x11-apps git

## Get SSH working with the password 'root'
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#AllowTcpForwarding\s+.*/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#X11Forwarding\s+.*/X11Forwarding yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#X11UseLocalhost\s+.*/X11UseLocalhost no/g' /etc/ssh/sshd_config

## Install system tools
RUN apt-get install -y htop iftop wget curl bash vim

## Install NVM, node & yarn
ENV NODE_VERSION 10

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
# RUN source ~/.bashrc
RUN . /root/.nvm/nvm.sh && nvm install $NODE_VERSION
RUN apt-get install -y gnupg gnupg2 gnupg1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

## Install rbenv and ruby
ENV RUBY_VERSION 2.5.1

RUN apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# RUN source ~/.bashrc
RUN /root/.rbenv/bin/rbenv install $RUBY_VERSION
RUN /root/.rbenv/bin/rbenv global $RUBY_VERSION
RUN /root/.rbenv/bin/rbenv exec gem install bundler

## Start SSH
EXPOSE 22 80 8080 3000 5000 9000
CMD ["/usr/sbin/sshd", "-D"]
