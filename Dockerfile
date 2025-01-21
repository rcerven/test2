FROM quay.io/redhat-user-workloads/exd-rcerven-tenant/testnew/newtest1:a01e755d64e5241c475a4d71626434faa2f053b0@sha256:1cc0ea244a57aa6c0ca9063fe1527d69fbe77b4f2571f5e2081747aaf73fd392 AS nudgedimage
     
USER 0
RUN echo "nudged image"
RUN mkdir /testdir
COPY somedir/app.py /testdir

FROM registry.access.redhat.com/ubi9/python-39:1-1737460369

# By default, listen on port 8081
EXPOSE 8081/tcp
ENV FLASK_PORT=8081

# Set the working directory in the container
WORKDIR /projects

# Copy the content of the local src directory to the working directory
COPY . .

# Install any dependencies
RUN \
  if [ -f requirements.txt ]; \
    then pip install -r requirements.txt; \
  elif [ `ls -1q *.txt | wc -l` == 1 ]; \
    then pip install -r *.txt; \
  fi

USER 0
RUN mkdir /testdir
COPY --from=nudgedimage /testdir/* .

# Specify the command to run on container start
CMD [ "python", "./app.py" ]
