FROM tomcat:8.5.38-jre8

RUN rm -fR $CATALINA_HOME/webapps/*

ARG WAR_URL
RUN wget ${WAR_URL}

RUN cp -a *.war $CATALINA_HOME/webapps/

#ARG JDBC_DRIVER_URL=https://jdbc.postgresql.org/download/postgresql-42.2.5.jar 
ADD https://jdbc.postgresql.org/download/postgresql-42.2.5.jar $CATALINA_HOME/lib/

COPY *.jar $CATALINA_HOME/lib/

RUN sed -i /'<Context>'/c'<Context>\n<Listener className=\"com.sap.cloud.runtime.kotyo.tomcat.support.NamingResourcesListener\" factoryClassName=\"io.dirigible.smart.datasource.object.factory.SmartDatasourceObjectFactory\"/>' $CATALINA_HOME/conf/context.xml
