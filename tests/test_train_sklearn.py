import pytest
import joblib
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from src.train_sklearn import train_model

# Test scikit-learn model
def test_sklearn_model():
    model, _ = train_model(data_path="data/iris.csv", model_output_path=None)
    assert isinstance(model, RandomForestClassifier)

def test_prediction():
    model = joblib.load("models/sklearn_model.joblib")
    data = pd.DataFrame([[5.1,3.5,1.4,0.2]], columns=["SepalLengthCm", "SepalWidthCm", "PetalLengthCm", "PetalWidthCm"])
    prediction = model.predict(data)
    assert len(prediction) == 1
