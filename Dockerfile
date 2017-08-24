FROM ruby

ENV FASTLANE_VERSION=2.54.1
ENV ANDROID_SDK_HOME /opt/android-sdk-linux
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/tools:${ANDROID_SDK_HOME}/platform-tools:/opt/tools

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list && \
    dpkg --add-architecture i386 && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -t jessie-backports openjdk-8-jdk ca-certificates-java -y && \
    apt-get install build-essential libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 nodejs -y && \
    gem install fastlane:$FASTLANE_VERSION -NV && \
    npm install -g yarn && \
    cd /opt && \
    echo "Installing android sdk" && wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O android-sdk.tgz && \
    tar -xvzf android-sdk.tgz && \
    echo "Installing platform-tools" && echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed' && \
    echo "Installing extra-google-m2repository" && echo y | android update sdk --no-ui --all --filter extra-google-m2repository | grep 'package installed' && \
    echo "Installing extra-android-m2repository" && echo y | android update sdk --no-ui --all --filter extra-android-m2repository | grep 'package installed' && \
    echo "Installing android-26" && echo y | android update sdk --no-ui --all --filter android-26 | grep 'package installed' && \
    echo "Installing build-tools-26.0.1" && echo y | android update sdk --no-ui --all --filter build-tools-26.0.1 | grep 'package installed' && \
    echo "Installing android-25" && echo y | android update sdk --no-ui --all --filter android-25 | grep 'package installed' && \
    echo "Installing build-tools-25.0.0" && echo y | android update sdk --no-ui --all --filter build-tools-25.0.0 | grep 'package installed' && \
    echo "Installing android-23" && echo y | android update sdk --no-ui --all --filter android-23 | grep 'package installed' && \
    echo "Installing build-tools-23.0.0" && echo y | android update sdk --no-ui --all --filter build-tools-23.0.0 | grep 'package installed' && \
    echo "Installing build-tools-23.0.1" && echo y | android update sdk --no-ui --all --filter build-tools-23.0.1 | grep 'package installed' && \
    echo "Installing build-tools-23.0.2" && echo y | android update sdk --no-ui --all --filter build-tools-23.0.2 | grep 'package installed' && \
    echo "Installing build-tools-23.0.3" && echo y | android update sdk --no-ui --all --filter build-tools-23.0.3 | grep 'package installed' && \
    echo "Cleaning image..." && \
    rm -f android-sdk.tgz && rm -rf /var/lib/apt-get/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && apt-get clean


ENTRYPOINT ["fastlane"]
