import subprocess

if __name__ == "__main__":
    result = subprocess.run(["gcloud", "compute", "instances", "list", "--format=value(name)"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    instances: list = [line for line in result.stdout.decode("utf-8").split("\n") if line]

    print(instances)