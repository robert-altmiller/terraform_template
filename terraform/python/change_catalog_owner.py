import os, requests

# Changes the owner of a Databricks catalog.
def change_catalog_owner():
    databricks_url = os.environ.get("DATABRICKS_URL")
    token = os.environ.get("DATABRICKS_TOKEN")
    catalog_name = os.environ.get("DATABRICKS_CATALOG_NAME")
    principal_name = os.environ.get("DATABRICKS_PRINCIPAL_NAME")
    
    url = f"{databricks_url}/api/2.0/preview/catalog/catalogs/{catalog_name}/owner"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    payload = {
        "principal_name": principal_name,
        "principal_type": "SERVICE_PRINCIPAL"
    }

    response = requests.patch(url, headers=headers, json=payload)
    if response.status_code == 200:
        return f"The owner of the '{catalog_name}' catalog has been changed to '{principal_name}'."
    else:
        return f"Failed to change the owner of the '{catalog_name}' catalog. Response: {response.text}"


if __name__ == "__main__":
    change_catalog_owner()