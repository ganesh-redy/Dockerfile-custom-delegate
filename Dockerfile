# Use the existing Harness delegate image
FROM us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.06.86100

# Switch to root to install tools
USER root

# Fix conflict: Replace curl-minimal with full curl
# Install python3, pip, vim, unzip (pip is in python3-pip package)
RUN microdnf install -y python3 python3-pip vim unzip && microdnf clean all

# Install ansible using pip
RUN python3 -m pip install --no-cache-dir ansible
# Return to original delegate user
USER 1001

# No need to set WORKDIR, CMD or HEALTHCHECK – inherited from base
