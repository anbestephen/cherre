FROM python:3.6-slim

# Set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
ARG PROJECT=cherre
ARG PROJECT_DIR=/var/www/${PROJECT}

RUN mkdir -p $PROJECT_DIR

# Copy project
COPY . $PROJECT_DIR/
COPY docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
# give permission for nginx to read static files
RUN chown -R "$USER":www-data /var/www/${PROJECT}/staticfiles \
    && chmod -R 0755 /var/www/${PROJECT}/staticfiles

WORKDIR $PROJECT_DIR
EXPOSE 8000
ENTRYPOINT ["/docker-entrypoint.sh"]
