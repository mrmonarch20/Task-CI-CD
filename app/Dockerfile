
FROM python:3.11-slim

# create a non-root user
RUN useradd -m appuser

# Set Working Directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Use the non-root user to run the app
USER appuser

# Expose the port that the app runs on
EXPOSE 5000

# Start the Flask app
CMD ["python", "app.py"]
