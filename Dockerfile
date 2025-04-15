FROM python:3.12

# Create user
RUN useradd -m -u 1000 user

# Set user and environment
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set working directory
WORKDIR $HOME/app

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Copy all files (including requirements.txt) first
COPY --chown=user . .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose any secrets here if needed using --mount (optional)

# Entrypoint
ENTRYPOINT ["/bin/bash", "/home/user/app/docker-entrypoint.sh"]
