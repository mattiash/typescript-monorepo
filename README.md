# Typescript Monorepo

Sample project to explore monorepos for typescript code.

Based on https://medium.com/@cecylia.borek/setting-up-a-monorepo-using-npm-workspaces-and-typescript-project-references-307841e0ba4a

# Install Dependencies

```
npm install
```

Installs dependencies for all services.

There is only a single node_modules directory at the root. This means that all services have access to all packages that other services depend on. E.g. node-emoji is installed in service-a, but it still works from common and service-b. This problem will only be detected when trying to build the services in Docker, because then only the packages that common and the service depend on will be installed

# Install Dependencies Single Service

```sh
rm -rf node_modules
# Install root packages
npm install -ws=false
# Install service-a packages
npm install -w service-a
```

This makes sure that only the dependencies for common and service-a are installed.

# Build Docker

From root:

```
docker build --build-arg SERVICE=service-b -t service-b .
```

The resulting image only has the dependencies for common and service-b in node_modules
and only the build directories for these as well.
