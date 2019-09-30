FROM caapim/gateway:latest

##
USER root

# Copy license files
COPY "docker" "/opt/SecureSpan/Gateway/node/default/etc/bootstrap/license/"
# Or COPY the whole folder containing license(s)
# COPY "licenses_folder" "/opt/SecureSpan/Gateway/node/default/etc/bootstrap/license/"
#set the time zone to America/Vancouver
RUN ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
#set locale
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8 --quiet
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV ENV.CONTEXT_VARIABLE_PROPERTY.influxdb.influxdb="apim-service-metrics-runtime-influxdb.cicd.svc.cluster.local"
ENV ENV.CONTEXT_VARIABLE_PROPERTY.influxdb.tags="env=dev"
ENV ENV.PROPERTY.gateway.otk.port: "8443"
ENV ENV.PROPERTY.gateway.otk.port.health: ""
ENV ENV.PROPERTY.gateway.otk.health.apikey: ""
ARG 'ENV.CONTEXT_VARIABLE_PROPERTY.#OTK Storage Configuration.dbsystem: "cassandra"'
#permission change
#COPY "misc_files" "/opt/docker/rc.d/folders/"
#RUN chmod -R 750 '/opt/docker/rc.d/folders/'
## Copying the deployment package
COPY /build/gateway/cicd-gateway-1.0.0.gw7 /opt/docker/rc.d/deployment.gw7
## Make restman available
RUN touch /opt/SecureSpan/Gateway/node/default/etc/bootstrap/services/restman
##
#COPY "lib" /opt/SecureSpan/Gateway/runtime/lib/ext/


USER ${ENTRYPOINT_UID}
