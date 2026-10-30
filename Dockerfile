# Use slim Python base image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency files first
COPY pyproject.toml uv.lock* ./

# Install uv and project dependencies
RUN pip install --no-cache-dir uv
RUN uv sync --no-dev --no-install-project

# Copy project files
COPY . .

# Expose FastAPI port
EXPOSE 8000

# Start API without reinstalling dependencies
CMD ["uv", "run", "--no-sync", "uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]