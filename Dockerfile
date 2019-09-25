FROM mosuka/blast:v0.8.1

ENV NODE_ID indexer1

VOLUME [ /data ]

EXPOSE 5000
EXPOSE 6000
EXPOSE 8000

ADD /startup.sh /

CMD [ "/startup.sh" ]
