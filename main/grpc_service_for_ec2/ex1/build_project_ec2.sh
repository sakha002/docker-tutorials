#!/bin/bash



# sudo yum install -y amazon-linux-extras
# sudo amazon-linux-extras enable python3.8
# sudo yum install python3.8

# #The (rough) equivalent of the build-essential meta-package for yum is:
# sudo yum install make glibc-devel gcc patch



pip3 install --user -r ./scripts/python_requirements.txt

cd src/protos && make proto_server && make 

cd ../server & python3 server.py