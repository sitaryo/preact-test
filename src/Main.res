%%raw("import './index.css'")

switch ReactDOM.querySelector("#root") {
| Some(domElement) => ReactDOM.render(<App />, domElement)
| None => ()
}
