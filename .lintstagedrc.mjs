// @see https://github.com/lint-staged/lint-staged
export default {
  "*.elm": ["elm-format --yes"],
  "src/**/*.elm": () => "node scripts/lint-elm-yes-prompts.mjs",
  "*.{ts,tsx,js,mjs,cjs,mts,cts}": ["prettier --write --list-different"],
  "*.{css,scss}": ["prettier --write --list-different"],
  "*.json": ["prettier --write --list-different"],
};
