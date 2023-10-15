FROM alpine:3.12.12
RUN apk --no-cache add curl aws-cli git jq docker

RUN curl -Lo copilot "https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux" && chmod +x copilot && mv copilot /usr/local/bin/copilot && copilot --help


