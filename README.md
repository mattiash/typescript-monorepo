# Typescript Monorepo

Sample project to explore monorepos for typescript code.

Based on https://medium.com/@cecylia.borek/setting-up-a-monorepo-using-npm-workspaces-and-typescript-project-references-307841e0ba4a

# NPM Dependencies

There is only a single node_modules directory at the root. This means that all services have access to all packages that other services depend on. E.g. node-emoji is installed in service-a, but it still works from common and service-b. This problem will only be detected when trying to build the services in Docker, because then only the packages that common and the service depend on will be installed

## All services

To install dependencies for all services, run `npm install` from the root.

## Install Dependencies Single Service

```sh
rm -rf node_modules
# Install root packages
npm install -ws=false
# Install service-a packages
cd service-a && npm install
```

This makes sure that only the dependencies for common and service-a are installed.

## package.json

To add a new npm dependency, add it to the correct package.json.

- devDependencies shall be added as devDependencies in the root package.json (or with `npm install -D` in the root)
- dependencies needed by code in common shall be added to common/package.json (`npm install` in common)
- dependencies that are only needed in one (or a few) dependencies shall be added to the package.json for the relevant service(s) (`npm install` in service directory).

# Docker

## Building

```
cd service-a && make container
```

The resulting image only has the dependencies for common and service-b in node_modules and only the build directories for these as well.

## Dockerfile for Service

The Dockerfile for each service is generated from `Dockerfile.template` in the root and the resulting Dockerfile should NOT be checked in. If a service requires installation of additional software, the Dockerfile can be augmented with `Dockerfile.build` and `Dockerfile.prod` files in the directory for the service.

## Validating Dependencies

`npx knip --strict && npx knip && npx sherif@latest`

### Knip

Knip checks that 

1. all dependencies are actually used in imports
2. all imports are included as dependencies

for each workspace. Run `npx knip --strict` to check production builds and `npx knip` to check devDependencies.

### Sherif

Sherif checks that the same version is used for all dependencies in all workspaces.

`npx sherif@latest`

