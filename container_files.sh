SERVICE=$1
if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi
set -e

CONTAINER="$SERVICE/container"
rm -rf $CONTAINER

mkdir -p $CONTAINER/common $CONTAINER/$SERVICE
cp package*.json tsconfig.json common.tsconfig.json $CONTAINER/
cp common/package*.json $CONTAINER/common/
cp $SERVICE/package*.json $CONTAINER/$SERVICE/
(cd $CONTAINER/ && npm ci -ws=false)
(cd $CONTAINER/$SERVICE && npm ci)

rsync -av --exclude "*.ts" --exclude "*.map" --exclude ".tsbuildinfo" --exclude "test" ./common/build $CONTAINER/common/
rsync -av --exclude "*.ts" --exclude "*.map" --exclude ".tsbuildinfo" --exclude "test" ./$SERVICE/build $CONTAINER/$SERVICE/

echo "Container files for service '$SERVICE' have been prepared in the '$CONTAINER' directory."