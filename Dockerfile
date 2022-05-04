FROM ibm-semeru-runtimes:open-8u322-b06-jdk-focal

RUN apt-get -yq update \
    && apt-get -yq install ca-certificates curl gnupg lsb-release wget \ 
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get -yq update \
    && apt-get -yq upgrade \
    && apt-get -yq install python3 python3-pip \
    && apt-get -yq clean

RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade awscli

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/$(wget -q -O - https://storage.googleapis.com/kubernetes-release/release/stable.txt -O -)/bin/linux/amd64/kubectl -O kubectl \
    && chmod +x ./kubectl \ 
    && mv ./kubectl /usr/local/bin/kubectl \
    && mkdir -p ~/.kube
