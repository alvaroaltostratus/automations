import json

from googleapiclient import discovery
from oauth2client.client import GoogleCredentials

if __name__ == '__main__':
    with open('../terraform-import/instances/resources.tf.json') as f:
        instances = json.loads(f.read())["resource"]["google_compute_instance"]
        credentials = GoogleCredentials.get_application_default()
        service = discovery.build('compute', 'v1', credentials=credentials)

        for k, v in instances.items():
            curr_metadata = service.instances().get(project=v["project"], zone=v["zone"], instance=v["name"]).execute()["metadata"]

            if "items" in curr_metadata:
                curr_metadata["items"].append({
                    "key": 'startup-script',
                    "value": "hola"
                })
            else:
                curr_metadata["items"] = [{
                    "key":'startup-script',
                    "value": "hola"
                }]

            try:
                response = service.instances().setMetadata(project=v["project"], zone=v["zone"], instance=v["name"], body=curr_metadata).execute()
                print(f"Applied startup-script to {v['name']}")
            except Exception as e:
                print(f"Failed to apply startup-script to {v['name']}")
            