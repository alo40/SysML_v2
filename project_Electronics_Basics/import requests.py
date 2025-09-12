import requests

BASE_URL = "http://localhost:9000/api"

# 1. Create a new model
model_resp = requests.post(
    f"{BASE_URL}/models",
    json={"name": "CarSystemModel"}
)
model = model_resp.json()
print("Created model:", model)

model_id = model["id"]

# 2. Add a Block called "Car"
block_resp = requests.post(
    f"{BASE_URL}/models/{model_id}/elements",
    json={"type": "Block", "name": "Car"}
)
block = block_resp.json()
print("Created block:", block)

# 3. Add a Requirement called "SpeedLimit"
req_resp = requests.post(
    f"{BASE_URL}/models/{model_id}/elements",
    json={"type": "Requirement", "name": "SpeedLimit"}
)
requirement = req_resp.json()
print("Created requirement:", requirement)

# 4. Query all elements
elements = requests.get(f"{BASE_URL}/models/{model_id}/elements").json()
print("All elements in model:")
for e in elements:
    print(e)
