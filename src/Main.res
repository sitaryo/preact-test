%%raw("import './index.css'")

switch ReactDOM.querySelector("#root") {
| Some(domElement) =>
{
  Js.Console.log(domElement)
  ReactDOM.render(<App />,domElement)
  }
| None => ()
}
