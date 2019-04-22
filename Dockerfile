ARG WAR_URL
FROM tomcat:8.5.38-jre8

#RUN echo "Before rm /webapps/"
#RUN rm -fR $CATALINA_HOME/webapps/*
#RUN echo "Before rm CURL - GitHub"
#RUN curl https://raw.githubusercontent.com/dirigiblelabs/zeus-v3-sample-war/master/test_postgre.war -o ROOT.war

#RUN echo "Before ARG"
#RUN echo "Before wget from ARG"
RUN wget -O ROOT.war ${WAR_URL} --no-check-certificate

#RUN echo "Before cp WAR"
RUN cp -a *.war $CATALINA_HOME/webapps/

#ARG JDBC_DRIVER_URL=https://jdbc.postgresql.org/download/postgresql-42.2.5.jar 
ADD https://jdbc.postgresql.org/download/postgresql-42.2.5.jar $CATALINA_HOME/lib/

COPY *.jar $CATALINA_HOME/lib/

RUN sed -i /'<Context>'/c'<Context>\n<Listener className=\"com.sap.cloud.runtime.kotyo.tomcat.support.NamingResourcesListener\" factoryClassName=\"io.dirigible.smart.datasource.object.factory.SmartDatasourceObjectFactory\"/>' $CATALINA_HOME/conf/context.xml
