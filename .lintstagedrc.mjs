// @see https://github.com/lint-staged/lint-staged
export default {
  "*.elm": ["elm-format --yes"],
  "src/**/*.elm": ["elm-review --fix"],
  "*.{ts,tsx,js,mjs,cjs,mts,cts}": ["prettier --write --list-different"],
  "*.{css,scss}": ["prettier --write --list-different"],
  "*.json": ["prettier --write --list-different"],
};
