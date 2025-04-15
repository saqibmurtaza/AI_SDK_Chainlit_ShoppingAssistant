FROM python:3.12

RUN useradd -m -u 1000 user
USER user
ENV PATH="/home/user/.local/bin:$PATH"

WORKDIR /app

COPY --chown=user ./requirements.txt requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY --chown=user . /app

# 👇 Mount the secret
RUN --mount=type=secret,id=GOOGLE_APPLICATION_CREDENTIALS_JSON,mode=0444,required=true \
    echo "Secret mounted successfully"

# 👇 Set the custom entrypoint script
COPY --chown=user docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
