#bin/bash
#####docker run --restart=always -d --privileged -p 111:111 -p 2049:2049 -p 4002:4002 -p 9001:9001 -p 1025:1025 -v /var/run/docker.sock:/var/run/docker.sock --name ichthysngs ichthysngs
docker run --restart=always -d --privileged -p 9001:9001 -p 1025:1025 -v /var/run/docker.sock:/var/run/docker.sock -v /nfsdir:/nfsdir -v /tmp:/tmp --name ichthysngs ichthysngs

