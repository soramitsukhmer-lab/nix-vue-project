# vue-project

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur).

## Type Support for `.vue` Imports in TS

TypeScript cannot handle type information for `.vue` imports by default, so we replace the `tsc` CLI with `vue-tsc` for type checking. In editors, we need [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) to make the TypeScript language service aware of `.vue` types.

## Nix
To use this project with Nix, you need to have [Nix](https://nixos.org/download.html) installed.

### Starting a development shell

```sh
nix develop -c $SHELL

which node
# /nix/store/rs7ap24fi2lfzvr9pgi8wah44sdbmbks-nodejs-22.16.0/bin/node
which yarn
# /nix/store/8v2mz5gfxnw7205jxahcj9dv29jb35db-yarn-1.22.22/bin/yarn
```

### Running the project directly from GitHub

This command will run the project directly from the GitHub repository without cloning it first. It uses Nix to set up the environment and dependencies and serving the project using Caddy.

```sh
nix run github:soramitsukhmer-lab/nix-vue-project
```

## Customize configuration

See [Vite Configuration Reference](https://vite.dev/config/).

## Project Setup

```sh
pnpm install
```

### Compile and Hot-Reload for Development

```sh
pnpm dev
```

### Type-Check, Compile and Minify for Production

```sh
pnpm build
```

### Lint with [ESLint](https://eslint.org/)

```sh
pnpm lint
```
