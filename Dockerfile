FROM ibm-semeru-runtimes:open-17.0.11_9-jdk-jammy

#prepare the apt-get install helm
RUN apt-get -yq update \
	&& apt-get -yq install gpg \
	&& curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null \
	&& apt-get install apt-transport-https --yes \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

RUN apt-get -yq update \
    && apt-get -yq install ca-certificates curl gnupg lsb-release wget \ 
    && apt-get -yq install python3 python3-pip \
	&& apt-get -yq install helm=3.9.4-1

RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade awscli

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/$(wget -q -O - https://storage.googleapis.com/kubernetes-release/release/stable.txt -O -)/bin/linux/amd64/kubectl -O kubectl \
    && chmod +x ./kubectl \ 
    && mv ./kubectl /usr/local/bin/kubectl \
    && mkdir -p ~/.kube

COPY --chmod=755 ./aws-oidc-auth.sh /usr/local/bin