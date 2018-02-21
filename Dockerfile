FROM golang:latest 
RUN mkdir /app 
ADD . /app/ 
WORKDIR /app 

ENV PORT 8080
EXPOSE "${PORT}"

CMD ["/app/helloworld"]