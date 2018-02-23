FROM golang:latest 
RUN mkdir /app 
ADD ./release/helloworld-linux /app/helloworld-linux 
WORKDIR /app 

ENV PORT 8080
EXPOSE "${PORT}"

CMD ["/app/helloworld-linux"]