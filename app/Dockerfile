# Reference Dockerfile for the shared CSO7024 application (lab 6.1).
# Write your own first, then compare against this one.

# Pin the base image. An unpinned base (python:3.12 or python:latest) can change
# under you and break a build that worked yesterday.
FROM python:3.12-slim

# Create a non-root user. Running as root inside a container is a common and
# avoidable security smell.
RUN useradd --create-home --uid 10001 appuser
WORKDIR /app

# Copy and install dependencies BEFORE the application code. This puts the
# slow-changing dependency layer below the fast-changing code layer, so the
# dependency layer is reused from cache when only code changes.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the application code.
COPY calculator.py app.py ./

USER appuser
EXPOSE 8000

# A health check lets Docker and orchestrators know the app is actually working,
# not just that the process is running.
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request,sys; sys.exit(0) if urllib.request.urlopen('http://localhost:8000/health').status==200 else sys.exit(1)"

CMD ["python", "app.py"]
