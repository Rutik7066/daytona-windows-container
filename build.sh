docker ps -a --filter ancestor=rutik7066/daytona-windows-container -q | xargs -r docker kill | xargs -r docker rm && \
docker images rutik7066/daytona-windows-container -q | xargs -r docker rmi -f && \
docker rmi rutik7066/daytona-windows-container:latest -f && \
docker build -t rutik7066/daytona-windows-container:latest -f Dockerfile . && \ 
docker push rutik7066/daytona-windows-container:latest