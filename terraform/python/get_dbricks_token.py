import os, requests, json
from base64 import b64encode


def get_databricks_token():
    """get databricks token for a service principal"""
    
    account_id = os.environ.get("DATABRICKS_ACCOUNT_ID")
    client_id = os.environ.get("DATABRICKS_CLIENT_ID")
    client_secret = os.environ.get("DATABRICKS_CLIENT_SECRET")

    token_url = f"https://accounts.cloud.databricks.com/oidc/accounts/{account_id}/v1/token"
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic " + b64encode(f"{client_id}:{client_secret}".encode()).decode()
    }
    payload = {
        "grant_type": "client_credentials",
        "scope": "all-apis"
    }

    response = requests.post(token_url, headers = headers, data = payload)
    response_data = json.loads(response.text)
    if "access_token" in response_data:
        print(response_data["access_token"])
    else: print("could not get access token....")
    

if __name__ == "__main__":
    get_databricks_token()