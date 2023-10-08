sudo docker build -t pytorch-latest . -f Dockerfile
sudo docker run -p 8100:8100 -it -v $(pwd):/app  --rm pytorch-latest
