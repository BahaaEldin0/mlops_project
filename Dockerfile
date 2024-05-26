# # Use the official Python image as base
# FROM python:3.10.14

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container
# COPY requirements.txt .

# # Install the dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the Flask app files into the container
# COPY server.py .
# COPY Model_200.joblib .
# COPY Model_NN1.h5 .

# # Expose the port that the Flask app runs on
# EXPOSE 5000

# # Command to run the Flask app when the container starts
# CMD ["python", "server.py"]

# Use the base Miniconda3 image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /app

# Copy the environment file into the container
COPY env.yaml /app/env.yaml

# Install Miniconda
RUN /opt/conda/bin/conda init bash && \
    /opt/conda/bin/conda config --add channels conda-forge && \
    /opt/conda/bin/conda update conda -y && \
    /opt/conda/bin/conda env update -n base -f /app/env.yaml

# Add conda bin to path
ENV PATH /opt/conda/bin:$PATH

# Copy the server.py file into the container
COPY server.py /app/server.py
COPY Model_NN1.h5 .
# Set entrypoint to run server.py
ENTRYPOINT ["python", "server.py"]
