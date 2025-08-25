FROM nginx:alpine

RUN echo '<!DOCTYPE html><html><head><title>K3N</title></head><body><p>Here is the link to my LinkedIn <a href="https://www.linkedin.com/in/ken-l-a87703139/">https://www.linkedin.com/in/ken-l-a87703139/</a></p></body></html>' \
> /usr/share/nginx/html/index.html

EXPOSE 80