module Batchable.Html.Events exposing
    ( onClick, onDoubleClick
    , onMouseDown, onMouseUp
    , onMouseEnter, onMouseLeave
    , onMouseOver, onMouseOut
    , onInput, onCheck, onSubmit
    , onBlur, onFocus
    , on, stopPropagationOn, preventDefaultOn, custom
    , targetValue, targetChecked, keyCode
    )

{-| It is often helpful to create an [Union Type] so you can have many different kinds
of events as seen in the [TodoMVC] example.

[Union Type]: https://elm-lang.org/learn/Union-Types.elm
[TodoMVC]: https://github.com/evancz/elm-todomvc/blob/master/Todo.elm


# Mouse

@docs onClick, onDoubleClick
@docs onMouseDown, onMouseUp
@docs onMouseEnter, onMouseLeave
@docs onMouseOver, onMouseOut


# Forms

@docs onInput, onCheck, onSubmit


# Focus

@docs onBlur, onFocus


# Custom

@docs on, stopPropagationOn, preventDefaultOn, custom


## Custom Decoders

@docs targetValue, targetChecked, keyCode

-}

import Batchable.Html exposing (Attribute)
import Html
import Html.Events
import Json.Decode as Json



-- MOUSE EVENTS


{-| -}
onClick : msg -> Attribute msg
onClick =
    lift Html.Events.onClick


{-| -}
onDoubleClick : msg -> Attribute msg
onDoubleClick =
    lift Html.Events.onDoubleClick


{-| -}
onMouseDown : msg -> Attribute msg
onMouseDown =
    lift Html.Events.onMouseDown


{-| -}
onMouseUp : msg -> Attribute msg
onMouseUp =
    lift Html.Events.onMouseUp


{-| -}
onMouseEnter : msg -> Attribute msg
onMouseEnter =
    lift Html.Events.onMouseEnter


{-| -}
onMouseLeave : msg -> Attribute msg
onMouseLeave =
    lift Html.Events.onMouseLeave


{-| -}
onMouseOver : msg -> Attribute msg
onMouseOver =
    lift Html.Events.onMouseOver


{-| -}
onMouseOut : msg -> Attribute msg
onMouseOut =
    lift Html.Events.onMouseOut



-- FORM EVENTS


{-| Detect [input](https://developer.mozilla.org/en-US/docs/Web/Events/input)
events for things like text fields or text areas.

For more details on how `onInput` works, check out [`targetValue`](#targetValue).

**Note 1:** It grabs the **string** value at `event.target.value`, so it will
not work if you need some other information. For example, if you want to track
inputs on a range slider, make a custom handler with [`on`](#on).

**Note 2:** It uses `stopPropagationOn` internally to always stop propagation
of the event. This is important for complicated reasons explained [here][1] and
[here][2].

[1]: /packages/elm/virtual-dom/latest/VirtualDom#Handler
[2]: https://github.com/elm/virtual-dom/issues/125

-}
onInput : (String -> msg) -> Attribute msg
onInput =
    lift Html.Events.onInput


{-| Detect [change](https://developer.mozilla.org/en-US/docs/Web/Events/change)
events on checkboxes. It will grab the boolean value from `event.target.checked`
on any input event.

Check out [`targetChecked`](#targetChecked) for more details on how this works.

-}
onCheck : (Bool -> msg) -> Attribute msg
onCheck =
    lift Html.Events.onCheck


{-| Detect a [submit](https://developer.mozilla.org/en-US/docs/Web/Events/submit)
event with [`preventDefault`](https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault)
in order to prevent the form from changing the page’s location. If you need
different behavior, create a custom event handler.
-}
onSubmit : msg -> Attribute msg
onSubmit =
    lift Html.Events.onSubmit



-- FOCUS EVENTS


{-| -}
onBlur : msg -> Attribute msg
onBlur =
    lift Html.Events.onBlur


{-| -}
onFocus : msg -> Attribute msg
onFocus =
    lift Html.Events.onFocus



-- CUSTOM EVENTS


{-| Create a custom event listener. Normally this will not be necessary, but
you have the power! Here is how `onClick` is defined for example:

    import Json.Decode as Decode

    onClick : msg -> Attribute msg
    onClick message =
        on "click" (Decode.succeed message)

The first argument is the event name in the same format as with JavaScript's
[`addEventListener`][aEL] function.

The second argument is a JSON decoder. Read more about these [here][decoder].
When an event occurs, the decoder tries to turn the event object into an Elm
value. If successful, the value is routed to your `update` function. In the
case of `onClick` we always just succeed with the given `message`.

If this is confusing, work through the [Elm Architecture Tutorial][tutorial].
It really helps!

[aEL]: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
[decoder]: /packages/elm/json/latest/Json-Decode
[tutorial]: https://github.com/evancz/elm-architecture-tutorial/

**Note:** This creates a [passive] event listener, enabling optimizations for
touch, scroll, and wheel events in some browsers.

[passive]: https://github.com/WICG/EventListenerOptions/blob/gh-pages/explainer.md

-}
on : String -> Json.Decoder msg -> Attribute msg
on =
    lift2 Html.Events.on


{-| Create an event listener that may [`stopPropagation`][stop]. Your decoder
must produce a message and a `Bool` that decides if `stopPropagation` should
be called.

[stop]: https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation

**Note:** This creates a [passive] event listener, enabling optimizations for
touch, scroll, and wheel events in some browsers.

[passive]: https://github.com/WICG/EventListenerOptions/blob/gh-pages/explainer.md

-}
stopPropagationOn : String -> Json.Decoder ( msg, Bool ) -> Attribute msg
stopPropagationOn =
    lift2 Html.Events.stopPropagationOn


{-| Create an event listener that may [`preventDefault`][prevent]. Your decoder
must produce a message and a `Bool` that decides if `preventDefault` should
be called.

For example, the `onSubmit` function in this library _always_ prevents the
default behavior:

[prevent]: https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault

    onSubmit : msg -> Attribute msg
    onSubmit msg =
        preventDefaultOn "submit" (Json.map alwaysPreventDefault (Json.succeed msg))

    alwaysPreventDefault : msg -> ( msg, Bool )
    alwaysPreventDefault msg =
        ( msg, True )

-}
preventDefaultOn : String -> Json.Decoder ( msg, Bool ) -> Attribute msg
preventDefaultOn =
    lift2 Html.Events.preventDefaultOn


{-| Create an event listener that may [`stopPropagation`][stop] or
[`preventDefault`][prevent].

[stop]: https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
[prevent]: https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault

**Note:** If you need something even more custom (like capture phase) check
out the lower-level event API in `elm/virtual-dom`.

-}
custom : String -> Json.Decoder { message : msg, stopPropagation : Bool, preventDefault : Bool } -> Attribute msg
custom =
    lift2 Html.Events.custom



-- COMMON DECODERS


{-| A `Json.Decoder` for grabbing `event.target.value`. We use this to define
`onInput` as follows:

    import Json.Decode as Json

    onInput : (String -> msg) -> Attribute msg
    onInput tagger =
        stopPropagationOn "input" <|
            Json.map alwaysStop (Json.map tagger targetValue)

    alwaysStop : a -> ( a, Bool )
    alwaysStop x =
        ( x, True )

You probably will never need this, but hopefully it gives some insights into
how to make custom event handlers.

-}
targetValue : Json.Decoder String
targetValue =
    Html.Events.targetValue


{-| A `Json.Decoder` for grabbing `event.target.checked`. We use this to define
`onCheck` as follows:

    import Json.Decode as Json

    onCheck : (Bool -> msg) -> Attribute msg
    onCheck tagger =
        on "input" (Json.map tagger targetChecked)

-}
targetChecked : Json.Decoder Bool
targetChecked =
    Html.Events.targetChecked


{-| A `Json.Decoder` for grabbing `event.keyCode`. This helps you define
keyboard listeners like this:

    import Json.Decode as Json

    onKeyUp : (Int -> msg) -> Attribute msg
    onKeyUp tagger =
        on "keyup" (Json.map tagger keyCode)

**Note:** It looks like the spec is moving away from `event.keyCode` and
towards `event.key`. Once this is supported in more browsers, we may add
helpers here for `onKeyUp`, `onKeyDown`, `onKeyPress`, etc.

-}
keyCode : Json.Decoder Int
keyCode =
    Html.Events.keyCode



-- Helper functions


lift : (a -> Html.Attribute msg) -> a -> Attribute msg
lift f a =
    Batchable.Html.fromAttributes [ f a ]


lift2 : (a -> b -> Html.Attribute msg) -> a -> b -> Attribute msg
lift2 f a b =
    Batchable.Html.fromAttributes [ f a b ]
