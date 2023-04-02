import paramiko
import json
import pprint


def get_metadata(keys):
    private_key = paramiko.RSAKey.from_private_key_file(key_path)
    client = paramiko.SSHClient()
    client.set_missing_key_policy(paramiko.AutoAddPolicy())
    command = 'curl -H Metadat:true "http://169.254.169.254/metadata/instance?api-version=2018-10-01"'
    
    stdin, stdout, stderr = client.exec_command(command)

    if stdout:
        data = stdout.read().decode()
        output = json.loads(data)
        pprint.pprint(output)
    
    if stderr:
        print("ERROR")
        print(stderr)

    client.close()




# input 

key_path = "C://Users//phani//Downloads/vm-md_key.pem"

get_metadata(key_path)



