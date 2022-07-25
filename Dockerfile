FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

RUN mkdir -p /app/code
WORKDIR /app/code

RUN apt-get update && apt-get install -y openjdk-17-jdk-headless && rm -rf /var/cache/apt /var/lib/apt/lists

# https://files.minecraftforge.net/net/minecraftforge/forge/
ENV MC_VERSION=1.17.1
ENV FORGE_VERSION=37.1.1

RUN curl -L https://maven.minecraftforge.net/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar -o forge-installer.jar
RUN java -jar /app/code/forge-installer.jar --installServer /app/code/forge && \
    rm /app/code/forge-installer.jar /app/code/forge-installer.jar.log

COPY frontend /app/code/frontend
COPY backend /app/code/backend
COPY index.js package.json package-lock.json start.sh server.properties.template /app/code/

RUN npm install

CMD [ "/app/code/start.sh" ]
