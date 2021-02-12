FROM cloudron/base:3.0.0@sha256:455c70428723e3a823198c57472785437eb6eab082e79b3ff04ea584faf46e92

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
