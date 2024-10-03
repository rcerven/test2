FROM quay.io/rcerven_rhtaptest/rcerven-test/testnudging/ttest1:86e7ff14cf4643dd77173678358cdf994280403d@sha256:2805fb7fc94fdc325172ddfc22f7bbf4dbae5bae6881796272862ed4cf7d2de0 AS nudgedimage
USER 0
RUN echo "nudged image"
RUN mkdir /testdir
COPY somedir/app.py /testdir

FROM quay.io/repository/redhat-user-workloads/exd-rcerven-tenant/testnew/newtest1:09c143305d342da9c598f63a0ea25675c0c831e7@sha256:34dbad19020277c3be9d580e2ad7eff61d05ca99d82f1621fa6c0067c05067dd AS nudgedimagesecond
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
COPY --from=nudgedimagesecond /testdir/* .

# Specify the command to run on container start
CMD [ "python", "./app.py" ]
