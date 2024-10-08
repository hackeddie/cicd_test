# syntax=docker/dockerfile:1
FROM python:3.9-slim
# FROM continuumio/miniconda3

# Set the working directory
WORKDIR /mlproject

# Copy the environment file and create the environment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir -p models/
# COPY conda_env.yml .
# RUN conda env create -f conda_env.yml

# # Activate the environment
# SHELL ["conda", "run", "-n", "ml_classification_project", "/bin/bash", "-c"]

# Copy the app code into the container
ADD data/ data
ADD src/ src
ADD tests/ tests

# Train the model when building the image
RUN python3 src/train_sklearn.py

# Set the entry point to run pytest
# CMD ["conda", "run", "-n", "ml_classification_project", "pytest"]
CMD ["python3", "-m", "pytest"]