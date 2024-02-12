import "./style.css";
import { Elm } from "./Main.elm";

if (import.meta.env.NODE_ENV === "development") {
    const ElmDebugTransform = await import("elm-debug-transformer")

    ElmDebugTransform.register({
        simple_mode: true,
        theme: "dark"
    })
}

const root = document.querySelector("#app");
const app = Elm.Main.init({ node: root });
