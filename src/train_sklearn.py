import pandas as pd
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from joblib import dump


def train_model(data_path="data/iris.csv", model_output_path="models/sklearn_model.joblib"):
    # Load dataset
    data = pd.read_csv(data_path)
    X_train, X_test, y_train, y_test = train_test_split(data.drop(columns=["Id", "Species"]), data["Species"], test_size=0.2)

    # Model training
    model = RandomForestClassifier(n_estimators=100)
    model.fit(X_train, y_train)

    # Log accuracy
    accuracy = model.score(X_test, y_test)
    print(f"Model accuracy: {accuracy}")

    # Save the model
    if model_output_path:
        dump(model, model_output_path)
        print(f"Model saved to {model_output_path}")
    
    return model, accuracy

if __name__ == "__main__":
    train_model()