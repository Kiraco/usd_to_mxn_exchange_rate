FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y curl wget gnupg less lsof net-tools git apt-utils -y


# WORKDIR
RUN mkdir /works
WORKDIR /works

# DART
RUN apt-get install apt-transport-https
RUN sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
RUN apt-get install dart -y
ENV PATH="${PATH}:/usr/lib/dart/bin/"
ENV PATH="${PATH}:/root/.pub-cache/bin"

RUN pub global activate webdev
RUN pub global activate stagehand

# FLUTTER
RUN apt-get install xz-utils -y 
RUN wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.7.8+hotfix.4-stable.tar.xz
RUN mkdir /works/development
WORKDIR /works/development
RUN tar xf ../flutter_linux_v1.7.8+hotfix.4-stable.tar.xz
ENV PATH="${PATH}:/works/development/flutter/bin"
RUN flutter precache

#
# FLUTTER EXAMPLE CODE
RUN git clone https://github.com/Kiraco/usd_to_mxn_exchange_rate.git
WORKDIR /works/development/usd_to_mxn_exchange_rate/
RUN flutter packages upgrade
RUN pub get