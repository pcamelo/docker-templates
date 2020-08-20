# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:bionic-1.0.0
LABEL maintainer="example@example.com"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Container config
ENV PROJECT_NAME=project-name
ENV PYTHON_MAJOR_VERSION=3
ENV PYTHON_MINOR_VERSION=7
ENV DEPENDENCIES="git libxml2-dev libxslt1-dev"

# Container build
ENV PYTHON_VERSION=${PYTHON_MAJOR_VERSION}.${PYTHON_MINOR_VERSION}

RUN echo "******** Adding deadsnakes PPA ********" && \
    apt-get update && \
    add-apt-repository -k hkp://keyserver.ubuntu.com:80 -y ppa:deadsnakes/ppa && \
    echo "******** Installing base dependencies ********" && \
    apt-get update && \
    install_clean \
        python${PYTHON_VERSION} \
        python${PYTHON_MAJOR_VERSION}-pip \
        ${DEPENDENCIES} && \
    echo "******** Setting python${PYTHON_VERSION} as default python executable ********" && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --install /usr/bin/python${PYTHON_MAJOR_VERSION} python${PYTHON_MAJOR_VERSION} /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --config python && \
    update-alternatives --config python${PYTHON_MAJOR_VERSION} && \
    echo "******** Setting up ${PROJECT_NAME} project executable  ********" && \
    mkdir /etc/service/${PROJECT_NAME}

COPY ./src /opt/${PROJECT_NAME}
RUN echo "******** Install python dependencies  ********" && \
    pip3 install --upgrade pip setuptools wheel && \
    pip3 install -r /opt/${PROJECT_NAME}/requirements.txt

COPY entrypoint.sh /etc/service/${PROJECT_NAME}/run

RUN chmod +x /etc/service/${PROJECT_NAME}/run && \
    echo "******** Clean up APT  ********" && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Exposed port
EXPOSE 80