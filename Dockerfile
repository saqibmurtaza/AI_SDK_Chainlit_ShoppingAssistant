FROM python:3.12

# Create user
RUN useradd -m -u 1000 user

# Switch to the new user
USER user

# Set environment
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set working directory
WORKDIR $HOME/app

# Upgrade pip first
RUN pip install --no-cache-dir --upgrade pip

# ✅ Copy the whole project into the container
COPY --chown=user . .

# Install all Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run using your entrypoint script
ENTRYPOINT ["/bin/bash", "/home/user/app/docker-entrypoint.sh"]
