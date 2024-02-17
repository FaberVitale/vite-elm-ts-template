<h1>vite-elm-ts-template <img aria-hidden="true" alt="" src="src/assets/logo.png" style="width: 24px;"></h1>

## Description

A [vite](https://vitejs.dev/) template for building apps with [elm](https://elm-lang.org/) and [typescript](https://www.typescriptlang.org/). 

### Features

- [Hot Module Replacement](https://vitejs.dev/guide/features#hot-module-replacement) thanks to [vite](https://vitejs.dev/) and [vite-plugin-elm](https://github.com/hmsk/vite-plugin-elm).
- Vite static asset handling provided by [vite-plugin-elm](https://github.com/hmsk/vite-plugin-elm).
- Elm tooling installation via [elm-tooling](https://elm-tooling.github.io/elm-tooling-cli/).
- [CI pipeline](.github/workflows/ci.yaml).
- [Netlify CD](./netlify.toml).
- Elm linting provided by [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/).
- Configured [Elm unit test](./tests/CounterTest.elm) environment.
- Automatic Ports and Flags type generation thanks to [elm-ts-interop](https://elm-ts-interop.com/how-it-works). 
- Code linting and formatting on precommit (see [config](.lintstagedrc.mjs)) provided by [lintstaged](https://github.com/lint-staged/lint-staged) and [husky](https://typicode.github.io/husky/).

## Demo

https://vite-elm-ts-template.netlify.app/

## Development guide

## Quick start

Either [open it on your browser (codesandbox)](https://codesandbox.io/p/devbox/github/FaberVitale/vite-elm-ts-template)
or clone the repository.

### Scripts

#### Install project

```bash
npm i
```

#### Dev server

```bash
npm run dev
```

#### Build

```bash
npm run build
```

#### Generate Ports and Flags types

```bash
npm run generate:elm-ts
```

#### run tests

```bash
npm run test
```

#### format

```bash
npm run fmt
```

#### run linters

```bash
npm run lint:elm && npm run lint:ts
```

### Git hooks

On pre-commit, changes are formatted and linted using [Husky](https://typicode.github.io/husky/) and [lint-staged](https://github.com/lint-staged/lint-staged).
See [.lintstagedrc.mjs](.lintstagedrc.mjs) for more details.

### CI

- [CI workflow](.github/workflows/ci.yaml)

---

## License

[MIT](./LICENSE)