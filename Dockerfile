FROM cloudron/base:2.0.0@sha256:f9fea80513aa7c92fe2e7bf3978b54c8ac5222f47a9a32a7f8833edf0eb5a4f4

RUN mkdir -p /app/code
WORKDIR /app/code

RUN apt-get update && apt-get install -y openjdk-8-jdk-headless && rm -rf /var/cache/apt /var/lib/apt/lists

ENV MC_VERSION=1.16.5
ENV FORGE_VERSION=36.0.15

RUN curl -L https://files.minecraftforge.net/maven/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar >> forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar
RUN java -jar /app/code/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar --installServer .
COPY frontend /app/code/frontend
COPY backend /app/code/backend
COPY index.js package.json package-lock.json start.sh /app/code/

RUN npm install

CMD [ "/app/code/start.sh" ]
