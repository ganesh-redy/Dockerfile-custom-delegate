# Use the existing Harness delegate image
FROM us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.06.86100

# Switch to root to install tools
USER root

# Install packages that don't conflict with curl-minimal
RUN microdnf install -y python3 python3-pip vim unzip wget && \
    microdnf clean all

# Install ansible using pip
RUN python3 -m pip install --no-cache-dir ansible

# Install Google Cloud SDK using wget (avoid curl conflicts)
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-linux-x86_64.tar.gz && \
    mv google-cloud-sdk /opt/ && \
    echo 'export PATH="/opt/google-cloud-sdk/bin:$PATH"' >> /etc/profile.d/gcloud.sh && \
    rm google-cloud-cli-linux-x86_64.tar.gz

# Return to original delegate user
USER 1001

# Add gcloud to PATH for the delegate user
ENV PATH="/opt/google-cloud-sdk/bin:$PATH"
~                                                                                                                                                                                                
