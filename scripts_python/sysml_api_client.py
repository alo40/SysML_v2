import requests
import json

class SysMLClient:
    def __init__(self, base_url):
        """Initialize SysML API client."""
        self.base_url = base_url

    def create_project(self, project_name):
        """Create a new SysML project."""
        url = f"{self.base_url}/projects"
        payload = {"name": project_name}
        response = requests.post(url, json=payload)
        return response.json() if response.status_code == 201 else None

    def create_element(self, project_id, element_type, name, attributes=None):
        """Create a SysML model element."""
        url = f"{self.base_url}/projects/{project_id}/elements"
        payload = {
            "type": element_type,  
            "name": name,
            "attributes": attributes or {}
        }
        response = requests.post(url, json=payload)
        return response.json() if response.status_code == 201 else None

    def get_project(self, project_id):
        """Retrieve project details."""
        url = f"{self.base_url}/projects/{project_id}"
        response = requests.get(url)
        return response.json() if response.status_code == 200 else None

    def get_element(self, project_id, element_id):
        """Retrieve a SysML model element by ID."""
        url = f"{self.base_url}/projects/{project_id}/elements/{element_id}"
        response = requests.get(url)
        return response.json() if response.status_code == 200 else None
