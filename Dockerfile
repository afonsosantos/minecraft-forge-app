FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

RUN mkdir -p /app/code
WORKDIR /app/code

RUN apt-get update && apt-get install -y openjdk-17-jdk-headless && rm -rf /var/cache/apt /var/lib/apt/lists

# https://files.minecraftforge.net/net/minecraftforge/forge/
ENV MC_VERSION=1.18.2
ENV FORGE_VERSION=40.1.0

RUN curl -L https://maven.minecraftforge.net/net/minecraftforge/forge/${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar >> forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar
RUN java -jar /app/code/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar --installServer /app/data && \
    rm /app/code/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar /app/code/forge-${MC_VERSION}-${FORGE_VERSION}-installer.jar.log

COPY frontend /app/code/frontend
COPY backend /app/code/backend
COPY index.js package.json package-lock.json start.sh server.properties.template /app/code/
RUN chmod +x /app/data/run.sh
RUN chmod +x /app/data/user_jvm_args.txt

RUN npm install

CMD [ "/app/code/start.sh" ]
