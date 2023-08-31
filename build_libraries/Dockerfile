FROM ubuntu:latest
RUN apt update && apt-install -y wget sudo
RUN wget https://raw.githubusercontent.com/emp-toolkit/emp-readme/master/scripts/install.py
CMD python install.py --deps --tool --ot --zk --sh2pc
