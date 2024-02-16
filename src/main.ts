import "./style.css";
import { Elm, type Flags } from "./Main.elm";

const flags = {
  counter: { btnDelta: 5, initialValue: 2 },
} as const satisfies Flags;

async function main() {
  if (import.meta.env.NODE_ENV === "development") {
    const ElmDebugTransform = await import("elm-debug-transformer");

    ElmDebugTransform.register({
      simple_mode: true,
      theme: "dark",
    });
  }

  const root = document.getElementById("app");

  if (!root) {
    throw new Error("#app not found");
  }

  const app = Elm.Main.init({
    node: root,
    flags,
  });

  document.addEventListener("click", ({ target }) => {
    if (!(target instanceof HTMLElement)) {
      return;
    }

    if (target.id === "ping-elm") {
      app.ports.interopToElm.send({ tag: "ping" });
      return;
    }
  });

  app.ports.interopFromElm.subscribe((data) => {
    window.alert(`Elm replies: ${JSON.stringify(data)}`);
  });
}

main().catch(console.error);
