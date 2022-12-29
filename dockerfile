# Build the prover
FROM node as builder

WORKDIR /rapidsnark

# install deps
RUN apt update && apt install build-essential libgmp-dev libsodium-dev nasm

COPY ./*.json tasksfile.js tools .
COPY ./.git ./.git
COPY ./depends ./depends
COPY ./src ./src

# install the node deps
RUN npm install

# pull submodules
RUN git submodule init && git submodule update

# build the fields
RUN npx task createFieldSources

# build the provder
RUN npx task buildProver

CMD ["/rapidsnark/build/prover"]
