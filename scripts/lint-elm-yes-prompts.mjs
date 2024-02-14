import { execSync } from "node:child_process";

try {
  execSync("printf '%s\\n' 'yes' | npm run lint:elm:fix ", {
    stdio: "inherit",
  });
} catch (err) {
  console.error(err + "");

  if (!process.exitCode) {
    process.exitCode = 1;
  }
}
