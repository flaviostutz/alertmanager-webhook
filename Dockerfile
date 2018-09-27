FROM prom/alertmanager:v0.15.2

ENV WEBHOOK_URL ''

VOLUME [ "/alertmanager" ]

ADD /alertmanager.yml.tmpl /
ADD /startup.sh /

ENTRYPOINT  [ "sh" ]
CMD [ "/startup.sh" ]
