import "./style.css";
import { Elm } from "./Main.elm";

async function main() {
  if (import.meta.env.NODE_ENV === "development") {
    const ElmDebugTransform = await import("elm-debug-transformer");

    ElmDebugTransform.register({
      simple_mode: true,
      theme: "dark",
    });
  }

  const root = document.querySelector("#app");

  if (!root) {
    throw new Error("#app not found");
  }

  Elm.Main.init({ node: root });
}

main().catch(console.error);
