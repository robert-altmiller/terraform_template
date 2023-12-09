import os, requests
from base64 import b64encode

os.environ["DATABRICKS_ACCOUNT_ID"] = ""
os.environ["DATABRICKS_CLIENT_ID"] = ""
os.environ["DATABRICKS_CLIENT_SECRET"] = ""

os.environ["DATABRICKS_URL"] = ""
os.environ["DATABRICKS_CATALOG_NAME"] = ""

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
    
    response = requests.post(token_url, headers=headers, data=payload)
    response_data = response.json()
    if "access_token" in response_data:
        return response_data["access_token"]
    else: return None


def delete_catalog():
    """
    delete a Databricks catalog
    prerequisite: 'default' and all other schemas need to be removed
    """
    
    databricks_url = os.environ.get("DATABRICKS_URL")
    catalog_name = os.environ.get("DATABRICKS_CATALOG_NAME")
    
    url = f"{databricks_url}/api/2.1/unity-catalog/catalogs/{catalog_name}"
    headers = {
        "Authorization": f"Bearer {get_databricks_token()}",
        "Content-Type": "application/json"
    }

    # Adjust the payload as per your requirement.
    payload = {}
    response = requests.delete(url, headers = headers, json = payload)
    if response.status_code == 200:
        print(f"Databricks Catalog '{catalog_name}' has been deleted.")
    else:
        print(f"Databricks Catalog '{catalog_name}' was not deleted. Response: {response.text}")


if __name__ == "__main__":
    delete_catalog()
    
