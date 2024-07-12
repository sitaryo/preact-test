type element = Jsx.element

@val external null: element = "null"

external float: float => element = "%identity"
external int: int => element = "%identity"
external string: string => element = "%identity"

external array: array<element> => element = "%identity"

type componentLike<'props, 'return> = Jsx.componentLike<'props, 'return>

type component<'props> = Jsx.component<'props>

external component: componentLike<'props, element> => component<'props> = "%identity"

@module("preact/compat")
external createElement: (component<'props>, 'props) => element = "createElement"

@module("preact/compat")
external cloneElement: (element, 'props) => element = "cloneElement"

@module("preact/compat")
external isValidElement: 'a => bool = "isValidElement"

@variadic @module("preact/compat")
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

@module("preact/compat")
external createRef: unit => ref<Js.nullable<'a>> = "createRef"

module Children = {
  @module("preact/compat") @scope("Children")
  external map: (element, element => element) => element = "map"
  @module("preact/compat") @scope("Children")
  external mapWithIndex: (element, @uncurry (element, int) => element) => element = "map"
  @module("preact/compat") @scope("Children")
  external forEach: (element, element => unit) => unit = "forEach"
  @module("preact/compat") @scope("Children")
  external forEachWithIndex: (element, @uncurry (element, int) => unit) => unit = "forEach"
  @module("preact/compat") @scope("Children")
  external count: element => int = "count"
  @module("preact/compat") @scope("Children")
  external only: element => element = "only"
  @module("preact/compat") @scope("Children")
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

@module("preact/compat")
external createContext: 'a => Context.t<'a> = "createContext"

@module("preact/compat")
external forwardRef: (@uncurry ('props, Js.Nullable.t<ref<'a>>) => element) => component<'props> =
  "forwardRef"

@module("preact/compat")
external memo: component<'props> => component<'props> = "memo"

@module("preact/compat")
external memoCustomCompareProps: (
  component<'props>,
  @uncurry ('props, 'props) => bool,
) => component<'props> = "memo"

@module("preact/compat") external fragment: component<fragmentProps> = "Fragment"

module Fragment = {
  type props = {key?: string, children: element}

  @module("preact/compat")
  external make: component<props> = "Fragment"
}

module StrictMode = {
  type props = {key?: string, children: element}

  @module("preact/compat")
  external make: component<props> = "StrictMode"
}

module Suspense = {
  type props = {key?: string, children?: element, fallback?: element}

  @module("preact/compat")
  external make: component<props> = "Suspense"
}

type dynamicallyImportedModule<'a> = {default: component<'a>}

@module("preact/compat")
external lazy_: (unit => promise<dynamicallyImportedModule<'a>>) => component<'a> = "lazy"

let lazy_ = load => lazy_(async () => {default: await load()})

/* HOOKS */

/*
 * Yeah, we know this api isn't great. tl;dr: useReducer instead.
 * It's because useState can take functions or non-function values and treats
 * them differently. Lazy initializer + callback which returns state is the
 * only way to safely have any type of state and be able to update it correctly.
 */
@module("preact/compat")
external useState: (@uncurry (unit => 'state)) => ('state, ('state => 'state) => unit) = "useState"

@module("preact/compat")
external useReducer: (@uncurry ('state, 'action) => 'state, 'state) => ('state, 'action => unit) =
  "useReducer"

@module("preact/compat")
external useReducerWithMapState: (
  @uncurry ('state, 'action) => 'state,
  'initialState,
  @uncurry ('initialState => 'state),
) => ('state, 'action => unit) = "useReducer"

@module("preact/compat")
external useEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit = "useEffect"
@module("preact/compat")
external useEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit = "useEffect"
@module("preact/compat")
external useEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useEffect"
@module("preact/compat")
external useEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit = "useEffect"
@module("preact/compat")
external useEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit = "useEffect"
@module("preact/compat")
external useEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit = "useEffect"
@module("preact/compat")
external useEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useEffect"
@module("preact/compat")
external useEffect5: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useEffect"
@module("preact/compat")
external useEffect6: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e, 'f)) => unit =
  "useEffect"
@module("preact/compat")
external useEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useEffect"

@module("preact/compat")
external useLayoutEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect5: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd, 'e)) => unit =
  "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect6: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useLayoutEffect"
@module("preact/compat")
external useLayoutEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useLayoutEffect"

@module("preact/compat")
external useMemo: (@uncurry (unit => 'any), 'deps) => 'any = "useMemo"

@module("preact/compat")
external useMemo0: (@uncurry (unit => 'any), @as(json`[]`) _) => 'any = "useMemo"

@module("preact/compat")
external useMemo1: (@uncurry (unit => 'any), array<'a>) => 'any = "useMemo"

@module("preact/compat")
external useMemo2: (@uncurry (unit => 'any), ('a, 'b)) => 'any = "useMemo"

@module("preact/compat")
external useMemo3: (@uncurry (unit => 'any), ('a, 'b, 'c)) => 'any = "useMemo"

@module("preact/compat")
external useMemo4: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd)) => 'any = "useMemo"

@module("preact/compat")
external useMemo5: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e)) => 'any = "useMemo"

@module("preact/compat")
external useMemo6: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f)) => 'any = "useMemo"

@module("preact/compat")
external useMemo7: (@uncurry (unit => 'any), ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'any = "useMemo"

@module("preact/compat")
external useCallback: ('f, 'deps) => 'f = "useCallback"

@module("preact/compat")
external useCallback0: ('f, @as(json`[]`) _) => 'f = "useCallback"

@module("preact/compat")
external useCallback1: ('f, array<'a>) => 'f = "useCallback"

@module("preact/compat")
external useCallback2: ('f, ('a, 'b)) => 'f = "useCallback"

@module("preact/compat")
external useCallback3: ('f, ('a, 'b, 'c)) => 'f = "useCallback"

@module("preact/compat")
external useCallback4: ('f, ('a, 'b, 'c, 'd)) => 'f = "useCallback"

@module("preact/compat")
external useCallback5: ('f, ('a, 'b, 'c, 'd, 'e)) => 'f = "useCallback"

@module("preact/compat")
external useCallback6: ('callback, ('a, 'b, 'c, 'd, 'e, 'f)) => 'callback = "useCallback"

@module("preact/compat")
external useCallback7: ('callback, ('a, 'b, 'c, 'd, 'e, 'f, 'g)) => 'callback = "useCallback"

@module("preact/compat")
external useContext: Context.t<'any> => 'any = "useContext"

@module("preact/compat") external useRef: 'value => ref<'value> = "useRef"

@module("preact/compat")
external useImperativeHandleOnEveryRender: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  'deps,
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle0: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  @as(json`[]`) _,
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle1: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  array<'a>,
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle2: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b),
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle3: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c),
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle4: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd),
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle5: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd, 'e),
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle6: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useImperativeHandle"

@module("preact/compat")
external useImperativeHandle7: (
  Js.Nullable.t<ref<'value>>,
  @uncurry (unit => 'value),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useImperativeHandle"

@module("preact/compat") external useId: unit => string = "useId"

@module("preact/compat") external useDeferredValue: 'value => 'value = "useDeferredValue"

@module("preact/compat")
external useTransition: unit => (bool, (. unit => unit) => unit) = "useTransition"

@module("preact/compat")
external useInsertionEffectOnEveryRender: (@uncurry (unit => option<unit => unit>)) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect: (@uncurry (unit => option<unit => unit>), 'deps) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect0: (@uncurry (unit => option<unit => unit>), @as(json`[]`) _) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect1: (@uncurry (unit => option<unit => unit>), array<'a>) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect2: (@uncurry (unit => option<unit => unit>), ('a, 'b)) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect3: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c)) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect4: (@uncurry (unit => option<unit => unit>), ('a, 'b, 'c, 'd)) => unit =
  "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect5: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e),
) => unit = "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect6: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f),
) => unit = "useInsertionEffect"
@module("preact/compat")
external useInsertionEffect7: (
  @uncurry (unit => option<unit => unit>),
  ('a, 'b, 'c, 'd, 'e, 'f, 'g),
) => unit = "useInsertionEffect"

@module("preact/compat")
external useSyncExternalStore: (
  ~subscribe: @uncurry ((unit => unit) => (. unit) => unit),
  ~getSnapshot: @uncurry (unit => 'state),
) => 'state = "useSyncExternalStore"

@module("preact/compat")
external useSyncExternalStoreWithServerSnapshot: (
  ~subscribe: @uncurry ((unit => unit) => (. unit) => unit),
  ~getSnapshot: @uncurry (unit => 'state),
  ~getServerSnapshot: @uncurry (unit => 'state),
) => 'state = "useSyncExternalStore"

module Uncurried = {
  @module("preact/compat")
  external useState: (@uncurry (unit => 'state)) => ('state, (. 'state => 'state) => unit) =
    "useState"

  @module("preact/compat")
  external useReducer: (
    @uncurry ('state, 'action) => 'state,
    'state,
  ) => ('state, (. 'action) => unit) = "useReducer"

  @module("preact/compat")
  external useReducerWithMapState: (
    @uncurry ('state, 'action) => 'state,
    'initialState,
    @uncurry ('initialState => 'state),
  ) => ('state, (. 'action) => unit) = "useReducer"

  @module("preact/compat")
  external useCallback: ('f, 'deps) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback0: ('f, @as(json`[]`) _) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback1: ('f, array<'a>) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback2: ('f, ('a, 'b)) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback3: ('f, ('a, 'b, 'c)) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback4: ('f, ('a, 'b, 'c, 'd)) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback5: ('f, ('a, 'b, 'c, 'd, 'e)) => 'f = "useCallback"

  @module("preact/compat")
  external useCallback6: ('callback, ('a, 'b, 'c, 'd, 'e, 'f)) => 'callback = "useCallback"

  @module("preact/compat")
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

  @module("preact/jsx-runtime")
  external jsx: (string, props) => Jsx.element = "jsx"

  @module("preact/jsx-runtime")
  external div: (string, props) => Jsx.element = "jsx"

  @module("preact/jsx-runtime")
  external jsxKeyed: (string, props, ~key: string=?, @ignore unit) => Jsx.element = "jsx"

  @module("preact/jsx-runtime")
  external jsxs: (string, props) => Jsx.element = "jsxs"

  @module("preact/jsx-runtime")
  external jsxsKeyed: (string, props, ~key: string=?, @ignore unit) => Jsx.element = "jsxs"

  external someElement: element => option<element> = "%identity"
}