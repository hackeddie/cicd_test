# Dockerfile

FROM continuumio/miniconda3

# Set the working directory
WORKDIR /src

# Copy the environment file and create the environment
COPY conda_env.yml .
RUN conda env create -f conda_env.yml

# Activate the environment
RUN echo "source activate ml_classification_project" > ~/.bashrc

# Copy the app code into the container
COPY data/ src/ tests/ .

# Train the model when building the image
RUN python src/train_sklearn.py

# Set the entry point to run pytest
CMD ["pytest"]
