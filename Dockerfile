FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK "30"
ENV ANDROID_BUILD_TOOLS "29.0.3"
ENV ANDROID_SDK_TOOLS "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"

RUN apt-get --quiet update --yes && apt-get --quiet install --yes \
    wget tar unzip xxd lib32stdc++6 lib32z1 build-essential ruby ruby-dev && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet --output-document=android-sdk.zip ${ANDROID_SDK_TOOLS} && \
    unzip -d android-sdk-linux android-sdk.zip && \
    rm -f android-sdk.zip 

RUN mkdir ~/.android && \
    touch ~/.android/repositories.cfg

RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses

# RUN gem install rake bundler:1.17.2 fastlane -NV

#COPY execute.sh /execute.sh

#COPY Gemfile/* ./

#RUN gem install bundle && gem install bundler:1.17.2 && bundle install
