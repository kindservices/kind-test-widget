#!/usr/bin/env bash
export TAG=${TAG:-local}
export IMG=${IMG:-kindservices/kind-test-widget:$TAG}
export PORT=${PORT:-3000}


build() {
    echo "Building $IMG..."
    docker build --tag $IMG .
    echo "Built $IMG. To run:"
    echo ""
    echo "    docker run --rm --name kind-test-widget -d -it -p $PORT:80 $IMG"
    echo ""
    echo "And open http://localhost:$PORT/bundle.js or http://localhost:$PORT/bundle.css"
    echo ""
    echo "Once running, to manually test, open ./test/local-test.html or ./test/dynamic-test.html"
    echo ""
}

dev() {
    pnpm install
    pnpm dev
}

clean() {
    pnpm store prune
}

run() {
    echo "docker run -it --rm -p $PORT:80 -d $IMG"
    id=`docker run -it --rm -p $PORT:80 -d $IMG`
    cat > kill.sh <<EOL
docker kill $id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh

    echo "Running on port $PORT --- stop server using ./kill.sh"
}

installArgo() {
    APP=${APP:-kind-test}
    BRANCH=${BRANCH:-`git rev-parse --abbrev-ref HEAD`}

    echo "creating $APP"

    kubectl create namespace data-mesh 2> /dev/null

    # beast mode :-)
    argocd app create $APP \
    --repo https://github.com/kindservices/kind-test-widget.git \
    --path k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace data-mesh \
    --sync-policy automated \
    --auto-prune \
    --self-heal \
    --revision $BRANCH

}