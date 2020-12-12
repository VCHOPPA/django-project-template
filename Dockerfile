FROM vamc123/nginx
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 PYTHONUNBUFFERED=1

RUN apt-get install -y gunicorn

ARG user=vamsi
# Add the user and their group
RUN groupadd -r ${user} && useradd -m -r -l -g ${user} ${user}

#permission

RUN mkdir -p /opt


RUN chown -R vamsi:vamsi /opt

WORKDIR /opt/

#RUN useradd -ms /bin/bash  vamsi
COPY .  /opt/django-project-template/

#copy the ngnix.default proxy rule file
#COPY /home/ubuntu/django-project-template/nginx.default /etc/nginx/sites-available/default
#VOLUME /var/log/nginx

# copy source and install dependencies
#COPY /home/ubuntu/django-project-template/
RUN pip install -r /opt/django-project-template/requirements.txt

RUN pip install gunicorn
ENV PATH $HOME/.local/bin:$PATH
# port open
#EXPOSE 8020
#EXPOSE 8010
# health check
#HEALTHCHECK --interval=5m --timeout=3s \
#CMD curl -f http://127.0.0.1:8020/api-docs || exit 1

# start server
#STOPSIGNAL SIGTERM
ENTRYPOINT ["nginx" "-g" "daemon off;"]
