from flask import Flask, request, jsonify
import joblib
from tensorflow.keras.models import load_model
import pandas as pd
import numpy as np

# Initialize Flask app
app = Flask(__name__)

# Load the joblib model
# joblib_model = joblib.load('./Model_200.joblib')

# Load the .h5 model
h5_model = load_model('./Model_NN1.h5')

# Define a route for predictions
@app.route('/predict', methods=['POST'])
def predict():
    # Get the JSON data from the request
    data = request.get_json()

    # Convert the JSON data to a DataFrame
    df = pd.DataFrame(data, index=[0])

    # Make predictions using the joblib model
    # joblib_prediction = joblib_model.predict(df)

    # Make predictions using the .h5 model
    h5_prediction = h5_model.predict(df)

    # Convert the predictions to a JSON response
    response = {
        # 'joblib_prediction': joblib_prediction.tolist(),
        'h5_prediction': h5_prediction.tolist()
    }

    return jsonify(response)

# Run the Flask app
if __name__ == '__main__':
    app.run(port=5000)
