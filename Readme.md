
docker build -t nginxcoll -f Dockerfile nginxcoll

docker run -d nginxcoll 

docker exec -ti $(docker ps -ql) supervisorctl

collectd                         RUNNING    pid 13, uptime 0:00:03

consul-template                  RUNNING    pid 12, uptime 0:00:03

nginx                            RUNNING    pid 36, uptime 0:00:02

supervisor> 

