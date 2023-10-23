# https://sveltesociety.dev/recipes/publishing-and-deploying/dockerize-a-svelte-app
FROM node:19 AS build

WORKDIR /app

# conditionally copy node_modules if available (e.g. we've done a local build)
# see https://stackoverflow.com/questions/31528384/conditional-copy-add-in-dockerfile
COPY package.json package-lock.jso[n] yarn.loc[k] node_module[s] ./

RUN yarn install
COPY . ./
RUN yarn run build

FROM nginx:1.19-alpine
COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 3000

# svelte will create random IDs for our gnerated components, e.g. "dist/assets/index-65be3931.css"
# we rename in our build for conssitent IDs
COPY --from=build /app/target/assets/css/index.css /usr/share/nginx/html/bundle.css
COPY --from=build /app/target/assets/js/bundle.js /usr/share/nginx/html/bundle.js
COPY --from=build /app/target/index.html /usr/share/nginx/html/index.html