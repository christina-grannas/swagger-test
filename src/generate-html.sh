set -e 

cd ~/gitrepos/widdershins
echo "Generating ~/Nets/swagger/payments.md..."
node widdershins --search false --language_tabs 'php:PHP' 'python:Python' 'shell:SH' --summary ~/Nets/swagger/AndristDevelopment-payment-api_v_1-v1-oas3-resolved.json  -o ~/Nets/swagger/payments.md
echo "done"

cp ~/Nets/swagger/payments.md ~/gitrepos/slate/source/index.html.md

cd ~/gitrepos/slate

name=$(docker ps -f "name=slate" --format '{{.Names}}')
if [ "$name" != slate ]; then
    echo "Run slate docker image"
    docker run -d --rm --name slate -p 4567:4567 -v $(pwd)/build:/srv/slate/build -v $(pwd)/source:/srv/slate/source slate
else
    echo "slate docker image already running"
fi

echo "Generating html in ~/gitrepos/slate/build ..."

cp ~/Nets/swagger/payments.md ~/gitrepos/slate/source
docker exec -it slate /bin/bash -c "bundle exec middleman build"   

echo "done"
