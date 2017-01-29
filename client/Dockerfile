FROM bitnami/node:7.4.0-r0

# Add an user to prevent errors from npm install
RUN useradd yoshi -m && \
    sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
    echo "yoshi ALL=NOPASSWD: ALL" >> /etc/sudoers

# Set the user
USER yoshi

WORKDIR /app

# Main command
CMD ["npm", "start"]
