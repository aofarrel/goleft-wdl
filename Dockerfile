# start with Google's official golang image
FROM golang:1.21

# prevent apt-get dialogs
ENV DEBIAN_FRONTEND noninteractive

# install goleft from Brent's repo
RUN go install github.com/brentp/goleft/cmd/goleft@latest

# install samtools-required packages
# these are necessary to work with crams
RUN apt-get update
RUN apt-get install bzip2
RUN apt-get install zlib1g-dev -y
RUN apt-get install libbz2-dev -y
RUN apt-get install liblzma-dev -y

# install samtools
WORKDIR /usr/bin
RUN wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2
RUN tar -vxjf samtools-1.11.tar.bz2
RUN cd samtools-1.11 && ./configure --without-curses && make && make install

# return to goleft's workdir
WORKDIR /go/src/goleft

CMD ["goleft"]
