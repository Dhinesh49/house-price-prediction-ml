
# House Price Prediction — Machine Learning Project

## Overview

This project predicts housing prices using a machine-learning regression model. It includes a trained XGBoost model, a FastAPI backend for predictions, and a Streamlit dashboard for user interaction.

## Features

- Housing price prediction using XGBoost
- Feature engineering and preprocessing
- FastAPI prediction API
- Streamlit dashboard
- Docker-based application setup
- AWS S3 integration for model and data retrieval

## Project Structure

```text
.
├── app.py
├── Dockerfile
├── Dockerfile.streamlit
├── pyproject.toml
├── uv.lock
├── models/
├── notebooks/
├── src/
│   ├── api/
│   ├── feature_pipeline/
│   ├── inference_pipeline/
│   └── training_pipeline/
└── tests/
```

## Technologies

- Python
- pandas and NumPy
- scikit-learn
- XGBoost
- FastAPI
- Streamlit
- Docker
- AWS S3
- uv

## Prerequisites

- Python 3.11 or compatible version
- Docker Desktop
- AWS credentials with permission to access the required S3 objects, if using S3
- uv for local dependency management

## Local Setup

Clone the repository and enter the project directory:

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd Regression_HousepricePrediction
```

Install uv if needed:

```bash
python -m pip install uv
```

Install the project dependencies:

```bash
uv sync --no-dev
```

Configure the required AWS settings before starting the API if the model or training features must be downloaded from S3.

## Run with Docker

Build the API image:

```bash
docker build -t house-price-api:latest -f Dockerfile .
```

Build the Streamlit image:

```bash
docker build -t houseprice-streamlit:latest -f Dockerfile.streamlit .
```

Create a shared network:

```bash
docker network create houseprice-network
```

Start the API:

```bash
docker run -d --name houseprice-api --network houseprice-network -p 8000:8000 house-price-api:latest
```

Start the dashboard:

```bash
docker run --rm --name houseprice-streamlit --network houseprice-network -p 8501:8501 -e API_URL=http://houseprice-api:8000/predict houseprice-streamlit:latest
```

Open the applications:

- Dashboard: http://localhost:8501/dashboard
- API documentation: http://localhost:8000/docs
- API health: http://localhost:8000/health

## AWS Configuration

The API reads these environment variables:

- `S3_BUCKET`: S3 bucket containing the required model and data objects
- `AWS_REGION`: AWS region; the code defaults to `ap-southeast-2`

Provide AWS credentials securely through your local AWS configuration or your deployment platform's IAM role. Do not commit AWS access keys or secrets to GitHub.

The API expects these S3 objects:

- `models/xgb_best_model.pkl`
- `processed/feature_engineered_train.csv`

## Notes

- Keep required model artifacts and preprocessing files available for inference.
- Verify the required S3 objects and permissions before deploying.
- Review model evaluation results before using predictions for real-world decisions.

## License

Add a license before redistributing this project.
