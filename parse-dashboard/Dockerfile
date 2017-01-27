FROM node:4.4.2

# Install our container command line tools
RUN apt-get update \
    && apt-get install -y \
        curl \
        unzip \
        git-core \
    && rm -rf /var/lib/apt/lists/*

# Pull project
RUN git clone https://github.com/ParsePlatform/parse-dashboard.git /parse-dashboard

WORKDIR /parse-dashboard

RUN cd /parse-dashboard \
 && npm install \
 && npm run build \
 && npm cache clear \
 && rm -rf ~/.npm \
 && rm -rf /var/lib/apt/lists/*

# Install Containerpilot
# Releases at https://github.com/joyent/containerpilot/releases
ENV CONTAINERPILOT_VERSION 2.4.3
RUN export CP_SHA1=2c469a0e79a7ac801f1c032c2515dd0278134790 \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz

# Install Consul
# Releases at https://releases.hashicorp.com/consul
RUN export CONSUL_VERSION=0.6.4 \
    && export CONSUL_CHECKSUM=abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627 \
    && curl --retry 7 --fail -vo /tmp/consul.zip "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" \
    && echo "${CONSUL_CHECKSUM}  /tmp/consul.zip" | sha256sum -c \
    && unzip /tmp/consul -d /usr/local/bin \
    && rm /tmp/consul.zip \
    && mkdir /config

COPY etc/* /etc/
ENV CONTAINERPILOT file:///etc/containerpilot.json

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/bin/containerpilot", "npm", "run", "dashboard"]
