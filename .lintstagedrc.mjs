export default {
  "*.elm": ["elm-format --yes"],
  "src/**/*.elm": () => "npm run lint:elm --fix",
  "*.{ts,tsx,js,mjs,cjs,mts,cts}": () => ["prettier --write --list-different"],
};
