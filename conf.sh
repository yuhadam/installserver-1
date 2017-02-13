#!/bin/bash
sudo service docker restart
docker pull ichthysngs/baseimage && wait
# sftp conf 
mip=$(sqlite3 /shellscript/ichthys.db "select uEmail from user where uId='admin'" ) && wait
docker tag ichthysngs/baseimage $mip:5000/baseimage && wait 
docker push $mip:5000/baseimage

groupadd sftp
sed -i 's/Subsystem/#Subsystem/' /etc/ssh/sshd_config
sed -i 's/Port/#Port/' /etc/ssh/sshd_config
sed -i 's/UsePAM/#UsePAM/' /etc/ssh/sshd_config
echo Port 1025 >> /etc/ssh/sshd_config
echo AllowGroups sftp sftp >> /etc/ssh/sshd_config
echo Subsystem     sftp    internal-sftp >> /etc/ssh/sshd_config
echo Match Group sftp >> /etc/ssh/sshd_config
echo       ChrootDirectory /home/%u >> /etc/ssh/sshd_config
echo       X11Forwarding no        >> /etc/ssh/sshd_config
echo       AllowTcpForwarding no   >> /etc/ssh/sshd_config
echo       ForceCommand internal-sftp >> /etc/ssh/sshd_config
sudo service ssh restart

cp -r /exe/* /nfsdir/exe
# nfs conf
#echo "/nfsdir *(rw,insecure,fsid=0,no_subtree_check,no_root_squash)" >> /etc/exports
#rm /etc/services
#rm /etc/default/nfs-kernel-server
#cp -r /shellscript/services /etc/
#cp -r /shellscript/nfs-kernel-server /etc/default/
#chmod 777 /nfsdir
#service rpcbind start
#service nfs-kernel-server start

#apt-mark hold nfs-kernel-server

#cd /shellscript/
#curl -O https://downloads.dcos.io/binaries/cli/linux/x86-64/dcos-1.8/dcos
#chmod +x dcos
#./dcos config set core.dcos_url http://$mip && wait
#./dcos config set core.ssl_verify http://$mip && wait
#./dcos auth login && wait
#echo yes | ./dcos package install chronos && wait

#sudo touch marathon.txt

#sudo chmod 777 marathon.txt

#./dcos marathon task list --json > marathon.txt
#MARATHON_ENDPOINT_IP=$(cat marathon.txt | jq '.[0].host' | sed 's/"//g' )
#MARATHON_ENDPOINT_PORT=$(cat marathon.txt | jq '.[0].ports[0]')
#sudo touch chronos.txt
#sudo chmod 777 chronos.txt
#sed -i "7s/$/--http_notification_url http:\/\/$mip:9001\/fail\",/" chronos.json && wait
#curl -L -H 'Content-Type: application/json' -X POST -d @chronos.json http://$mip:8080/v2/apps && wait
sleep 10s
#curl -L -H 'Content-Type: application/json' -X GET http://$mip:8080/v2/apps/chronos/ > chronos.txt && wait

cd /web/bin/
./dev -Dhttp.port=9001
