# Typescript Monorepo

Sample project to explore monorepos for typescript code.

Based on https://medium.com/@cecylia.borek/setting-up-a-monorepo-using-npm-workspaces-and-typescript-project-references-307841e0ba4a

Currently, node-emoji is installed in service-a, but it still works from common and service-b. Why?

There is only a single node-modules directory, which feels wrong.

# Install packages for service-a only:

```
rm -rf node_modules
npm ci -w service-a
```

# Build Docker

From root:

```
docker build --build-arg SERVICE=service-b -t service-b .
```

The resulting image only has the dependencies for common and service-b in node_modules
and only the build directories for these as well.
