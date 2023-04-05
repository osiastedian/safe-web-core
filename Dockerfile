FROM node:16-alpine
RUN apk add --no-cache libc6-compat git python3 py3-pip make g++
WORKDIR /app
COPY . .

# install deps
RUN git clone https://github.com/osiastedian/safe-deployments /safe-deployments
RUN cd /safe-deployments; yarn; yarn add --dev rimraf typescript@4.2.4 @types/semver; yarn rimraf dist && yarn tsc
RUN yarn add @safe-global/safe-deployments@/safe-deployments
RUN yarn install

# Debug tools
RUN apk update; apk add vim bash less

ENV NODE_ENV production

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry during the build.
ENV NEXT_TELEMETRY_DISABLED 1

EXPOSE 3000

ENV PORT 3000

CMD ["yarn", "static-serve"]
