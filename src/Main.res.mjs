// Generated by ReScript, PLEASE EDIT WITH CARE

import * as App from "./App.res.mjs";
import * as Preact from "preact";
import * as JsxRuntime from "preact/jsx-runtime";

import './index.css'
;

var domElement = document.querySelector("#root");

if (!(domElement == null)) {
  console.log(domElement);
  Preact.render(JsxRuntime.jsx(App.make, {}), domElement);
}

export {
  
}
/*  Not a pure module */