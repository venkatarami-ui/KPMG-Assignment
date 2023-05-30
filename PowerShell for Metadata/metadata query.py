# using some google helop i got this Pythos script. 
import json
import subprocess

def get_azure_instance_metadata(key=None):
    command = "az vm show -d --query instanceView -o json"
    output = subprocess.check_output(command, shell=True).decode('utf-8')
    data = json.loads(output)

    if key:
        return data.get(key)
    else:
        return data

# Example usage
metadata = get_azure_instance_metadata()

# Pretty-print the metadata as JSON
formatted_metadata = json.dumps(metadata, indent=4)
print(formatted_metadata)