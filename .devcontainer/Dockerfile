FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bullseye

COPY --chown=node:node credentials.json /home/node/.config/qiita-cli/credentials.json

RUN yarn install

CMD ["npx", "qiita", "preview"]
