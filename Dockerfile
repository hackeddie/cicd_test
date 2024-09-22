# Dockerfile

FROM continuumio/miniconda3

# Set the working directory
WORKDIR /src

# Copy the environment file and create the environment
COPY conda_env.yml .
RUN conda env create -f conda_env.yml
RUN mkdir -p models/

# Activate the environment
SHELL ["conda", "run", "-n", "ml_classification_project", "/bin/bash", "-c"]

# Copy the app code into the container
ADD data/ data
ADD src/ src
ADD tests/ tests

# Train the model when building the image
RUN python src/train_sklearn.py

# Set the entry point to run pytest
CMD ["conda", "run", "-n", "ml_classification_project", "pytest"]