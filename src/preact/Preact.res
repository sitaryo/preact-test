type element = Jsx.element

@val external null: element = "null"

external float: float => element = "%identity"
external int: int => element = "%identity"
external string: string => element = "%identity"

external array: array<element> => element = "%identity"

type componentLike<'props, 'return> = Jsx.componentLike<'props, 'return>

type component<'props> = Jsx.component<'props>

external component: componentLike<'props, element> => component<'props> = "%identity"

@module("preact")
external createElement: (component<'props>, 'props) => element = "createElement"

@module("preact")
external cloneElement: (element, 'props) => element = "cloneElement"

@module("preact")
external isValidElement: 'a => bool = "isValidElement"

@variadic @module("preact")
external createElementVariadic: (component<'props>, 'props, array<element>) => element =
  "createElement"


@module("preact/jsx-runtime")
external jsx: (component<'props>, 'props) => element = "jsx"

@module("preact/jsx-runtime")
external jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsx"

@module("preact/jsx-runtime")
external jsxs: (component<'props>, 'props) => element = "jsxs"

@module("preact/jsx-runtime")
external jsxsKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsxs"

type fragmentProps = {children?: element}

@module("preact/jsx-runtime") external jsxFragment: component<fragmentProps> = "Fragment"

type ref<'value> = {mutable current: 'value}

module Ref = {
  @deprecated("Please use the type React.ref instead")
  type t<'value> = ref<'value>

  @deprecated("Please directly read from ref.current instead") @get
  external current: ref<'value> => 'value = "current"

  @deprecated("Please directly assign to ref.current instead") @set
  external setCurrent: (ref<'value>, 'value) => unit = "current"
}

@module("preact")
external createRef: unit => ref<Js.nullable<'a>> = "createRef"

module Children = {
  @module("preact") @scope("Children")
  external map: (element, element => element) => element = "map"
  @module("preact") @scope("Children")
  external mapWithIndex: (element, @uncurry (element, int) => element) => element = "map"
  @module("preact") @scope("Children")
  external forEach: (element, element => unit) => unit = "forEach"
  @module("preact") @scope("Children")
  external forEachWithIndex: (element, @uncurry (element, int) => unit) => unit = "forEach"
  @module("preact") @scope("Children")
  external count: element => int = "count"
  @module("preact") @scope("Children")
  external only: element => element = "only"
  @module("preact") @scope("Children")
  external toArray: element => array<element> = "toArray"
}

module Context = {
  type t<'context>

  type props<'context> = {
    value: 'context,
    children: element,
  }

  @get
  external provider: t<'context> => component<props<'context>> = "Provider"
}

@module("preact")
external createContext: 'a => Context.t<'a> = "createContext"

@module("preact")
external forwardRef: (@uncurry ('props, Js.Nullable.t<ref<'a>>) => element) => component<'props> =
  "forwardRef"

@module("preact")
external memo: component<'props> => component<'props> = "memo"

@module("preact")
external memoCustomCompareProps: (
  component<'props>,
  @uncurry ('props, 'props) => bool,
) => component<'props> = "memo"

@module("preact") external fragment: component<fragmentProps> = "Fragment"

module Fragment = {
  type props = {key?: string, children: element}

  @module("preact")
  external make: component<props> = "Fragment"
}

module StrictMode = {
  type props = {key?: string, children: element}

  @module("preact")
  external make: component<props> = "StrictMode"
}

module Suspense = {
  type props = {key?: string, children?: element, fallback?: element}

  @module("preact")
  external make: component<props> = "Suspense"
}

type dynamicallyImportedModule<'a> = {default: component<'a>}

@module("preact")
external lazy_: (unit => promise<dynamicallyImportedModule<'a>>) => component<'a> = "lazy"

let lazy_ = load => lazy_(async () => {default: await load()})

/* HOOKS */

/*
 * Yeah, we know this api isn't great. tl;dr: useReducer instead.
 * It's because useState can take functions or non-function values and treats
 * them differently. Lazy initializer + callback which returns state is the
 * only way to safely have any type of state and be able to update it correctly.
 */
@module("preact")
external useState: (@uncurry (unit => 'state)) => ('state, ('state => 'state) => unit) = "useState"

@module("preact")
external useReducer: (@uncurry ('state, 'action) => 'state, 'state) => ('state, 'action => unit) =
  "useReducer"

@module("preact")
external useReducerWithMapState: (
  @uncurry ('state, 'action) => 'state,
  'initialState,
  @uncurry ('initialState => 'state),
) => ('state, 'action => unit) = "useReducer"

@module("preact")
external useEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit = "useEffect"
@module("preact")
external useEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit = "useEffect"
@module("preact")
external useEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useEffect"
@module("preact")
external useEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit = "useEffect"
@module("preact")
external useEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit = "useEffect"
@module("preact")
external useEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit = "useEffect"
@module("preact")
external useEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useEffect"
@module("preact")
external useEffect5: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useEffect"
@module("preact")
external useEffect6: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
  "useEffect"
@module("preact")
external useEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useEffect"

@module("preact")
external useLayoutEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect5: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useLayoutEffect"
@module("preact")
external useLayoutEffect6: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useLayoutEffect"
@module("preact")
external useLayoutEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useLayoutEffect"

@module("preact")
external useMemo: (@uncurry (unit => 'any), 'deps) => 'any = "useMemo"

@module("preact")
external useMemo0: (@uncurry (unit => 'any), @as(json`[]`) _) => 'any = "useMemo"

@module("preact")
external useMemo1: (@uncurry (unit => 'any), array<'a>) => 'any = "useMemo"

@module("preact")
external useMemo2: (@uncurry (unit => 'any), ('a, 'b)) => 'any = "useMemo"

@module("preact")
external useMemo3: (@uncurry (unit => 'any), ('a, 'b, 'c)) => 'any = "useMemo"

@module("preact")
external useMemo4: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd)) => 'any = "useMemo"

@module("preact")
external useMemo5: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any = "useMemo"

@module("preact")
external useMemo6: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any = "useMemo"

@module("preact")
external useMemo7: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any = "useMemo"

@module("preact")
external useCallback: ('f, 'deps) => 'f = "useCallback"

@module("preact")
external useCallback0: ('f, @as(json`[]`) _) => 'f = "useCallback"

@module("preact")
external useCallback1: ('f, array<'a>) => 'f = "useCallback"

@module("preact")
external useCallback2: ('f, ('a, 'b)) => 'f = "useCallback"

@module("preact")
external useCallback3: ('f, ('a, 'b, 'c)) => 'f = "useCallback"

@module("preact")
external useCallback4: ('f, ('a, 'b, 'c, 'd)) => 'f = "useCallback"

@module("preact")
external useCallback5: ('f, ('a, 'b, 'c, 'd, 'e)) => 'f = "useCallback"

@module("preact")
external useCallback6: ('callback, ('a, 'b, 'c, 'd, 'e, 'f)) => 'callback = "useCallback"

@module("preact")
external useCallback7: ('callback, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'callback = "useCallback"

@module("preact")
external useContext: Context.t<'any> => 'any = "useContext"

@module("preact") external useRef: 'value => ref<'value> = "useRef"

@module("preact")
external useImperativeHandleOnEveryRender: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  'deps,
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle0: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  @as(json`[]`) _,
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle1: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  array<'a>,
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle2: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b),
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle3: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c),
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle4: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd),
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle5: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd, 'e),
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle6: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useImperativeHandle"

@module("preact")
external useImperativeHandle7: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useImperativeHandle"

@module("preact") external useId: unit => string = "useId"

@module("preact") external useDeferredValue: 'value => 'value = "useDeferredValue"

@module("preact")
external useTransition: unit => (bool, (. unit => unit) => unit) = "useTransition"

@module("preact")
external useInsertionEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useInsertionEffect"
@module("preact")
external useInsertionEffect5: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e),
) => unit = "useInsertionEffect"
@module("preact")
external useInsertionEffect6: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useInsertionEffect"
@module("preact")
external useInsertionEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useInsertionEffect"

@module("preact")
external useSyncExternalStore: (
  ~subscribe: @uncurry ((unit => unit) => (. unit) => unit),
  ~getSnapshot: @uncurry (unit => 'state),
) => 'state = "useSyncExternalStore"

@module("preact")
external useSyncExternalStoreWithServerSnapshot: (
  ~subscribe: @uncurry ((unit => unit) => (. unit) => unit),
  ~getSnapshot: @uncurry (unit => 'state),
  ~getServerSnapshot: @uncurry (unit => 'state),
) => 'state = "useSyncExternalStore"

module Uncurried = {
  @module("preact")
  external useState: (@uncurry (unit => 'state)) => ('state, (. 'state => 'state) => unit) =
    "useState"

  @module("preact")
  external useReducer: (
    @uncurry ('state, 'action) => 'state,
    'state,
  ) => ('state, (. 'action) => unit) = "useReducer"

  @module("preact")
  external useReducerWithMapState: (
    @uncurry ('state, 'action) => 'state,
    'initialState,
    @uncurry ('initialState => 'state),
  ) => ('state, (. 'action) => unit) = "useReducer"

  @module("preact")
  external useCallback: ('f, 'deps) => 'f = "useCallback"

  @module("preact")
  external useCallback0: ('f, @as(json`[]`) _) => 'f = "useCallback"

  @module("preact")
  external useCallback1: ('f, array<'a>) => 'f = "useCallback"

  @module("preact")
  external useCallback2: ('f, ('a, 'b)) => 'f = "useCallback"

  @module("preact")
  external useCallback3: ('f, ('a, 'b, 'c)) => 'f = "useCallback"

  @module("preact")
  external useCallback4: ('f, ('a, 'b, 'c, 'd)) => 'f = "useCallback"

  @module("preact")
  external useCallback5: ('f, ('a, 'b, 'c, 'd, 'e)) => 'f = "useCallback"

  @module("preact")
  external useCallback6: ('callback, ('a, 'b, 'c, 'd, 'e, 'f)) => 'callback = "useCallback"

  @module("preact")
  external useCallback7: ('callback, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'callback = "useCallback"
}

@set
external setDisplayName: (component<'props>, string) => unit = "displayName"

@get @return(nullable)
external displayName: component<'props> => option<string> = "displayName"

/* The Elements module is the equivalent to the ReactDOM module in React. This holds things relevant to _lowercase_ JSX elements. */
module Elements = {
  /* Here you can control what props lowercase JSX elements should have. 
  A base that the React JSX transform uses is provided via JsxDOM.domProps, 
  but you can make this anything. The editor tooling will support 
  autocompletion etc for your specific type. */
  type props = JsxDOM.domProps

  @module("preact")
  external jsx: (string, props) => Jsx.element = "jsx"

  @module("preact")
  external div: (string, props) => Jsx.element = "jsx"

  @module("preact")
  external jsxKeyed: (string, props, ~key: string=?, @ignore unit) => Jsx.element = "jsx"

  @module("preact")
  external jsxs: (string, props) => Jsx.element = "jsxs"

  @module("preact")
  external jsxsKeyed: (string, props, ~key: string=?, @ignore unit) => Jsx.element = "jsxs"

  external someElement: element => option<element> = "%identity"
}