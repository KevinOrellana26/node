FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl && apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

COPY ./webapp.js /home/webapp.js
EXPOSE 8888
CMD [ "node", "/home/webapp.js" ]