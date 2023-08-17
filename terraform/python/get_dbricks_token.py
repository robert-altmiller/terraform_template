import os, requests
from base64 import b64encode

def get_databricks_token():
    account_id = os.environ.get("DATABRICKS_ACCOUNT_ID")
    client_id = os.environ.get("DATABRICKS_CLIENT_ID")
    client_secret = os.environ.get("DATABRICKS_CLIENT_SECRET")

    print("Account ID:", account_id)
    print("Client ID:", client_id)
    print("Client Secret:", client_secret)

    token_url = f"https://accounts.cloud.databricks.com/oidc/accounts/{account_id}/v1/token"
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic " + b64encode(f"{client_id}:{client_secret}".encode()).decode()
    }
    payload = {
        "grant_type": "client_credentials",
        "scope": "all-apis"
    }

    response = requests.post(token_url, headers=headers, data=payload)
    response_data = response.json()

    print("Response Status Code:", response.status_code)
    print("Response Text:", response.text)

    if "access_token" in response_data:
        return response_data["access_token"]
    else:
        raise Exception("Failed to retrieve Databricks token")