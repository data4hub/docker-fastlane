FROM ruby

ENV FASTLANE_VERSION=2.54.0

RUN gem install fastlane:$FASTLANE_VERSION -NV

ENTRYPOINT ["fastlane"]
