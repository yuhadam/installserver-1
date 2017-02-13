FROM ichthysngs/serverbase

RUN apt-get update && apt-get install -y curl

RUN apt-get install -y sqlite3 libsqlite3-dev

RUN apt-get install -y jq

RUN mkdir -p /log/


ADD dev-1.0-SNAPSHOT /web/

ADD conf.sh /shellscript/

ADD ichthys.db /shellscript/

ADD launch.sh /bin/

CMD /shellscript/conf.sh



