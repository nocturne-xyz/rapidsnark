# Build the prover
FROM node

WORKDIR /rapidsnark

RUN apt update -y && apt install -y build-essential libgmp-dev libsodium-dev nasm

COPY *.json .
COPY tasksfile.js .
COPY tools .
COPY .git ./.git
COPY depends ./depends
COPY src ./src

RUN npm install
RUN git submodule init && git submodule update
RUN npx task createFieldSources
RUN npx task buildProver

CMD ["/rapidsnark/build/prover"]
