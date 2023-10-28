FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY . /app
WORKDIR /app

# FROM base AS prod-deps
# RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install
RUN pnpm run build

#FROM base
# COPY --from=prod-deps /app/node_modules /app/node_modules
# COPY --from=build /app/dist /app/dist
# EXPOSE 8000
# CMD [ "pnpm", "start" ]

FROM nginx:1.19-alpine
COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 3000

# svelte will create random IDs for our gnerated components, e.g. "dist/assets/index-65be3931.css"
# we rename in our build for conssitent IDs
COPY --from=build /app/target/assets/css/index.css /usr/share/nginx/html/bundle.css
COPY --from=build /app/target/assets/js/bundle.js /usr/share/nginx/html/bundle.js
COPY --from=build /app/target/index.html /usr/share/nginx/html/index.html