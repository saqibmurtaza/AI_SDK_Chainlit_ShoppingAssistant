FROM python:3.12

# Create user
RUN useradd -m -u 1000 user

# Set environment and switch to the new user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set working directory
WORKDIR $HOME/app

# Upgrade pip first
RUN pip install --no-cache-dir --upgrade pip

# ✅ Copy all files AFTER setting workdir — avoids the "not found" error
COPY --chown=user . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run the custom entrypoint script
ENTRYPOINT ["/bin/bash", "/home/user/app/docker-entrypoint.sh"]
