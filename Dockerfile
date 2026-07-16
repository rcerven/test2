#FROM quay.io/redhat-user-workloads-stage/exd-rcerven-tenant/rcerven-test/testnudging/ttest1:f612b24c2dde1586ebdd812e4ff46aaa8bcc4d75@sha256:4965228d0600635f4de221da1754c439c4ac3f94d86bec28a1899b0b327063f6 AS nudgedimage
FROM quay.io/rcerven_rhtaptest/rcerven-test/testnudging/ttest1:ec300646a3221dd150bbc30e009d8199fa807e19@sha256:2ea42a664c6de82b82a7d2b2ea9fe4ce413939bcff05d80aafb9e7cdf4128ff0 AS nudgedimage
#FROM quay.io/redhat-user-workloads/exd-rcerven-tenant/testnew/newtest1:a01e755d64e5241c475a4d71626434faa2f053b0@sha256:1cc0ea244a57aa6c0ca9063fe1527d69fbe77b4f2571f5e2081747aaf73fd392 AS nudgedimage
     
USER 0
RUN echo "nudged image"
RUN mkdir /testdir
COPY somedir/app.py /testdir

FROM registry.access.redhat.com/ubi9/python-39:1-197.1725907694

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
