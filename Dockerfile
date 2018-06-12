### base image
FROM ubuntu

### meta data
MAINTAINER yujidispyaaa

### update sources
RUN apt-get clean
RUN apt-get update

### install basic apps
RUN apt-get install -y git
RUN apt-get install -y locales
RUN apt-get install -y nano
RUN apt-get install -y tmux
RUN apt-get install -y wget
RUN apt-get install -y locate
RUN apt-get install -y curl

### install app and modules
RUN apt-get install -y lua5.3
RUN apt-get install -y luajit
RUN apt-get install -y liblua5.3.0
RUN apt-get install -y liblua5.3-dev
RUN apt-get install -y libluajit-5.1-dev
RUN apt-get install -y libperl-dev
RUN apt-get install -y perl
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y ruby
RUN apt-get install -y ruby-dev
# RUN apt-get install -y g++-5

### make install vim
# get vim src
WORKDIR ~
RUN git clone https://github.com/vim/vim
WORKDIR vim
# path
RUN export vi_cv_path_python3=/usr/bin/python3
RUN export vi_cv_path_python=/usr/bin/python
RUN ln -s /usr/include/lua5.3 /usr/include/lua
# configure
RUN ./configure \
  --prefix=/usr \
  --with-features=huge \
  --with-luajit \
  --with-x \
  --enable-cscope \
  --enable-fail-if-missing \
  --enable-fontset \
  --enable-gui=auto \
  --enable-gtk2-check \
  --enable-luainterp \
  --enable-multibyte \
  --enable-perlinterp \
  --enable-pythoninterp \
  --enable-python3interp \
  --enable-rubyinterp
# make
RUN make
RUN make install
RUN vim --version
# plug install
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# cd /
WORKDIR /


### git clone and file add
RUN git clone https://github.com/git/git/
# この辺どうしようかな
ADD .bashrc /root/.bashrc
ADD .vimrc /root/.vimrc
ADD trades /root/trades

WORKDIR /


### install python3 modules




