# Dockerfile

FROM continuumio/miniconda3

# Set the working directory
WORKDIR /app

# Copy the environment file and create the environment
COPY environment.yml .
RUN conda env create -f environment.yml

# Activate the environment
RUN echo "source activate ml_classification_project" > ~/.bashrc

# Copy the app code into the container
COPY . .

# Train the model when building the image
RUN python src/train_sklearn.py

# Set the entry point to run pytest
CMD ["pytest"]
