FROM mongo:3.2

RUN apt-get update \
    && apt-get install -y \
        python \
        python-dev \
        gcc \
        curl \
        unzip \
        libffi-dev \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# get Python drivers MongoDB, Consul, and Manta
RUN curl -Ls -o get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install \
        PyMongo==3.2.2 \
        python-Consul==0.4.7 \
        manta==2.5.0 \
        mock==2.0.0

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

# add stopping timeouts for MongoDB
ENV MONGO_SECONDARY_CATCHUP_PERIOD 8
ENV MONGO_STEPDOWN_TIME 60
ENV MONGO_ELECTION_TIMEOUT 30

COPY etc/* /etc/
ENV CONTAINERPILOT file:///etc/containerpilot.json

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# override the parent entrypoint
ENTRYPOINT []

CMD [ \
    "containerpilot", \
    "mongod", \
    "--replSet=joyent" \
]
