module Batchable.Html.Attributes exposing
    ( style, property, attribute, map
    , batch, none
    , class, classList, id, title, hidden
    , type_, value, checked, placeholder, selected
    , accept, acceptCharset, action, autocomplete, autofocus
    , disabled, enctype, list, maxlength, minlength, method, multiple
    , name, novalidate, pattern, readonly, required, size, for, form
    , max, min, step
    , cols, rows, wrap
    , href, target, download, hreflang, media, ping, rel
    , ismap, usemap, shape, coords
    , src, height, width, alt
    , autoplay, controls, loop, preload, poster, default, kind, srclang
    , sandbox, srcdoc
    , reversed, start
    , align, colspan, rowspan, headers, scope
    , accesskey, contenteditable, contextmenu, dir, draggable, dropzone
    , itemprop, lang, spellcheck, tabindex
    , cite, datetime, pubdate, manifest
    )

{-| Helper functions for HTML attributes. They are organized roughly by
category. Each attribute is labeled with the HTML tags it can be used with, so
just search the page for `video` if you want video stuff.


# Primitives

@docs style, property, attribute, map

# Additional functions

@docs batch, none

# Super Common Attributes

@docs class, classList, id, title, hidden


# Inputs

@docs type_, value, checked, placeholder, selected


## Input Helpers

@docs accept, acceptCharset, action, autocomplete, autofocus
@docs disabled, enctype, list, maxlength, minlength, method, multiple
@docs name, novalidate, pattern, readonly, required, size, for, form


## Input Ranges

@docs max, min, step


## Input Text Areas

@docs cols, rows, wrap


# Links and Areas

@docs href, target, download, hreflang, media, ping, rel


## Maps

@docs ismap, usemap, shape, coords


# Embedded Content

@docs src, height, width, alt


## Audio and Video

@docs autoplay, controls, loop, preload, poster, default, kind, srclang


## iframes

@docs sandbox, srcdoc


# Ordered Lists

@docs reversed, start


# Tables

@docs align, colspan, rowspan, headers, scope


# Less Common Global Attributes

Attributes that can be attached to any HTML tag but are less commonly used.

@docs accesskey, contenteditable, contextmenu, dir, draggable, dropzone
@docs itemprop, lang, spellcheck, tabindex


# Miscellaneous

@docs cite, datetime, pubdate, manifest

-}

import Batchable.Html exposing (Attribute)
import Html
import Html.Attributes
import Json.Encode as Json



-- This library does not include low, high, or optimum because the idea of a
-- `meter` is just too crazy.
-- PRIMITIVES


{-| Specify a style.

    greeting : Node msg
    greeting =
        div
            [ style "background-color" "red"
            , style "height" "90px"
            , style "width" "100%"
            ]
            [ text "Hello!"
            ]

There is no `Html.Styles` module because best practices for working with HTML
suggest that this should primarily be specified in CSS files. So the general
recommendation is to use this function lightly.

-}
style : String -> String -> Attribute msg
style =
    lift2 Html.Attributes.style


{-| This function makes it easier to build a space-separated class attribute.
Each class can easily be added and removed depending on the boolean value it
is paired with. For example, maybe we want a way to view notices:

    viewNotice : Notice -> Html msg
    viewNotice notice =
        div
            [ classList
                [ ( "notice", True )
                , ( "notice-important", notice.isImportant )
                , ( "notice-seen", notice.isSeen )
                ]
            ]
            [ text notice.content ]

**Note:** You can have as many `class` and `classList` attributes as you want.
They all get applied, so if you say `[ class "notice", class "notice-seen" ]`
you will get both classes!

-}
classList : List ( String, Bool ) -> Attribute msg
classList =
    lift Html.Attributes.classList



-- CUSTOM ATTRIBUTES


{-| Create _properties_, like saying `domNode.className = 'greeting'` in
JavaScript.

    import Json.Encode as Encode

    class : String -> Attribute msg
    class name =
        property "className" (Encode.string name)

Read more about the difference between properties and attributes [here].

[here]: https://github.com/elm/html/blob/master/properties-vs-attributes.md

-}
property : String -> Json.Value -> Attribute msg
property =
    lift2 Html.Attributes.property


{-| Create _attributes_, like saying `domNode.setAttribute('class', 'greeting')`
in JavaScript.

    class : String -> Attribute msg
    class name =
        attribute "class" name

Read more about the difference between properties and attributes [here].

[here]: https://github.com/elm/html/blob/master/properties-vs-attributes.md

-}
attribute : String -> String -> Attribute msg
attribute =
    lift2 Html.Attributes.attribute


{-| Transform the messages produced by an `Attribute`.
-}
map : (a -> msg) -> Attribute a -> Attribute msg
map f attrs =
    Batchable.Html.fromAttributes <| List.map (Html.Attributes.map f) <| Batchable.Html.toAttributes attrs



-- GLOBAL ATTRIBUTES


{-| Often used with CSS to style elements with common properties.

**Note:** You can have as many `class` and `classList` attributes as you want.
They all get applied, so if you say `[ class "notice", class "notice-seen" ]`
you will get both classes!

-}
class : String -> Attribute msg
class =
    lift Html.Attributes.class


{-| Indicates the relevance of an element.
-}
hidden : Bool -> Attribute msg
hidden =
    lift Html.Attributes.hidden


{-| Often used with CSS to style a specific element. The value of this
attribute must be unique.
-}
id : String -> Attribute msg
id =
    lift Html.Attributes.id


{-| Text to be displayed in a tooltip when hovering over the element.
-}
title : String -> Attribute msg
title =
    lift Html.Attributes.title



-- LESS COMMON GLOBAL ATTRIBUTES


{-| Defines a keyboard shortcut to activate or add focus to the element.
-}
accesskey : Char -> Attribute msg
accesskey =
    lift Html.Attributes.accesskey


{-| Indicates whether the element's content is editable.
-}
contenteditable : Bool -> Attribute msg
contenteditable =
    lift Html.Attributes.contenteditable


{-| Defines the ID of a `menu` element which will serve as the element's
context menu.
-}
contextmenu : String -> Attribute msg
contextmenu =
    lift Html.Attributes.contextmenu


{-| Defines the text direction. Allowed values are ltr (Left-To-Right) or rtl
(Right-To-Left).
-}
dir : String -> Attribute msg
dir =
    lift Html.Attributes.dir


{-| Defines whether the element can be dragged.
-}
draggable : String -> Attribute msg
draggable =
    lift Html.Attributes.draggable


{-| Indicates that the element accept the dropping of content on it.
-}
dropzone : String -> Attribute msg
dropzone =
    lift Html.Attributes.dropzone


{-| -}
itemprop : String -> Attribute msg
itemprop =
    lift Html.Attributes.itemprop


{-| Defines the language used in the element.
-}
lang : String -> Attribute msg
lang =
    lift Html.Attributes.lang


{-| Indicates whether spell checking is allowed for the element.
-}
spellcheck : Bool -> Attribute msg
spellcheck =
    lift Html.Attributes.spellcheck


{-| Overrides the browser's default tab order and follows the one specified
instead.
-}
tabindex : Int -> Attribute msg
tabindex =
    lift Html.Attributes.tabindex



-- EMBEDDED CONTENT


{-| The URL of the embeddable content. For `audio`, `embed`, `iframe`, `img`,
`input`, `script`, `source`, `track`, and `video`.
-}
src : String -> Attribute msg
src =
    lift Html.Attributes.src


{-| Declare the height of a `canvas`, `embed`, `iframe`, `img`, `input`,
`object`, or `video`.
-}
height : Int -> Attribute msg
height =
    lift Html.Attributes.height


{-| Declare the width of a `canvas`, `embed`, `iframe`, `img`, `input`,
`object`, or `video`.
-}
width : Int -> Attribute msg
width =
    lift Html.Attributes.width


{-| Alternative text in case an image can't be displayed. Works with `img`,
`area`, and `input`.
-}
alt : String -> Attribute msg
alt =
    lift Html.Attributes.alt



-- AUDIO and VIDEO


{-| The `audio` or `video` should play as soon as possible.
-}
autoplay : Bool -> Attribute msg
autoplay =
    lift Html.Attributes.autoplay


{-| Indicates whether the browser should show playback controls for the `audio`
or `video`.
-}
controls : Bool -> Attribute msg
controls =
    lift Html.Attributes.controls


{-| Indicates whether the `audio` or `video` should start playing from the
start when it's finished.
-}
loop : Bool -> Attribute msg
loop =
    lift Html.Attributes.loop


{-| Control how much of an `audio` or `video` resource should be preloaded.
-}
preload : String -> Attribute msg
preload =
    lift Html.Attributes.preload


{-| A URL indicating a poster frame to show until the user plays or seeks the
`video`.
-}
poster : String -> Attribute msg
poster =
    lift Html.Attributes.poster


{-| Indicates that the `track` should be enabled unless the user's preferences
indicate something different.
-}
default : Bool -> Attribute msg
default =
    lift Html.Attributes.default


{-| Specifies the kind of text `track`.
-}
kind : String -> Attribute msg
kind =
    lift Html.Attributes.kind


{-| A two letter language code indicating the language of the `track` text data.
-}
srclang : String -> Attribute msg
srclang =
    lift Html.Attributes.srclang



-- IFRAMES


{-| A space separated list of security restrictions you'd like to lift for an
`iframe`.
-}
sandbox : String -> Attribute msg
sandbox =
    lift Html.Attributes.sandbox


{-| An HTML document that will be displayed as the body of an `iframe`. It will
override the content of the `src` attribute if it has been specified.
-}
srcdoc : String -> Attribute msg
srcdoc =
    lift Html.Attributes.srcdoc



-- INPUT


{-| Defines the type of a `button`, `input`, `embed`, `object`, `script`,
`source`, `style`, or `menu`.
-}
type_ : String -> Attribute msg
type_ =
    lift Html.Attributes.type_


{-| Defines a default value which will be displayed in a `button`, `option`,
`input`, `li`, `meter`, `progress`, or `param`.
-}
value : String -> Attribute msg
value =
    lift Html.Attributes.value


{-| Indicates whether an `input` of type checkbox is checked.
-}
checked : Bool -> Attribute msg
checked =
    lift Html.Attributes.checked


{-| Provides a hint to the user of what can be entered into an `input` or
`textarea`.
-}
placeholder : String -> Attribute msg
placeholder =
    lift Html.Attributes.placeholder


{-| Defines which `option` will be selected on page load.
-}
selected : Bool -> Attribute msg
selected =
    lift Html.Attributes.selected



-- INPUT HELPERS


{-| List of types the server accepts, typically a file type.
For `form` and `input`.
-}
accept : String -> Attribute msg
accept =
    lift Html.Attributes.accept


{-| List of supported charsets in a `form`.
-}
acceptCharset : String -> Attribute msg
acceptCharset =
    lift Html.Attributes.acceptCharset


{-| The URI of a program that processes the information submitted via a `form`.
-}
action : String -> Attribute msg
action =
    lift Html.Attributes.action


{-| Indicates whether a `form` or an `input` can have their values automatically
completed by the browser.
-}
autocomplete : Bool -> Attribute msg
autocomplete =
    lift Html.Attributes.autocomplete


{-| The element should be automatically focused after the page loaded.
For `button`, `input`, `select`, and `textarea`.
-}
autofocus : Bool -> Attribute msg
autofocus =
    lift Html.Attributes.autofocus


{-| Indicates whether the user can interact with a `button`, `fieldset`,
`input`, `optgroup`, `option`, `select` or `textarea`.
-}
disabled : Bool -> Attribute msg
disabled =
    lift Html.Attributes.disabled


{-| How `form` data should be encoded when submitted with the POST method.
Options include: application/x-www-form-urlencoded, multipart/form-data, and
text/plain.
-}
enctype : String -> Attribute msg
enctype =
    lift Html.Attributes.enctype


{-| Associates an `input` with a `datalist` tag. The datalist gives some
pre-defined options to suggest to the user as they interact with an input.
The value of the list attribute must match the id of a `datalist` node.
For `input`.
-}
list : String -> Attribute msg
list =
    lift Html.Attributes.list


{-| Defines the minimum number of characters allowed in an `input` or
`textarea`.
-}
minlength : Int -> Attribute msg
minlength =
    lift Html.Attributes.minlength


{-| Defines the maximum number of characters allowed in an `input` or
`textarea`.
-}
maxlength : Int -> Attribute msg
maxlength =
    lift Html.Attributes.maxlength


{-| Defines which HTTP method to use when submitting a `form`. Can be GET
(default) or POST.
-}
method : String -> Attribute msg
method =
    lift Html.Attributes.method


{-| Indicates whether multiple values can be entered in an `input` of type
email or file. Can also indicate that you can `select` many options.
-}
multiple : Bool -> Attribute msg
multiple =
    lift Html.Attributes.multiple


{-| Name of the element. For example used by the server to identify the fields
in form submits. For `button`, `form`, `fieldset`, `iframe`, `input`,
`object`, `output`, `select`, `textarea`, `map`, `meta`, and `param`.
-}
name : String -> Attribute msg
name =
    lift Html.Attributes.name


{-| This attribute indicates that a `form` shouldn't be validated when
submitted.
-}
novalidate : Bool -> Attribute msg
novalidate =
    lift Html.Attributes.novalidate


{-| Defines a regular expression which an `input`'s value will be validated
against.
-}
pattern : String -> Attribute msg
pattern =
    lift Html.Attributes.pattern


{-| Indicates whether an `input` or `textarea` can be edited.
-}
readonly : Bool -> Attribute msg
readonly =
    lift Html.Attributes.readonly


{-| Indicates whether this element is required to fill out or not.
For `input`, `select`, and `textarea`.
-}
required : Bool -> Attribute msg
required =
    lift Html.Attributes.required


{-| For `input` specifies the width of an input in characters.

For `select` specifies the number of visible options in a drop-down list.

-}
size : Int -> Attribute msg
size =
    lift Html.Attributes.size


{-| The element ID described by this `label` or the element IDs that are used
for an `output`.
-}
for : String -> Attribute msg
for =
    lift Html.Attributes.for


{-| Indicates the element ID of the `form` that owns this particular `button`,
`fieldset`, `input`, `label`, `meter`, `object`, `output`, `progress`,
`select`, or `textarea`.
-}
form : String -> Attribute msg
form =
    lift Html.Attributes.form



-- RANGES


{-| Indicates the maximum value allowed. When using an input of type number or
date, the max value must be a number or date. For `input`, `meter`, and `progress`.
-}
max : String -> Attribute msg
max =
    lift Html.Attributes.max


{-| Indicates the minimum value allowed. When using an input of type number or
date, the min value must be a number or date. For `input` and `meter`.
-}
min : String -> Attribute msg
min =
    lift Html.Attributes.min


{-| Add a step size to an `input`. Use `step "any"` to allow any floating-point
number to be used in the input.
-}
step : String -> Attribute msg
step =
    lift Html.Attributes.step



--------------------------


{-| Defines the number of columns in a `textarea`.
-}
cols : Int -> Attribute msg
cols =
    lift Html.Attributes.cols


{-| Defines the number of rows in a `textarea`.
-}
rows : Int -> Attribute msg
rows =
    lift Html.Attributes.rows


{-| Indicates whether the text should be wrapped in a `textarea`. Possible
values are "hard" and "soft".
-}
wrap : String -> Attribute msg
wrap =
    lift Html.Attributes.wrap



-- MAPS


{-| When an `img` is a descendant of an `a` tag, the `ismap` attribute
indicates that the click location should be added to the parent `a`'s href as
a query string.
-}
ismap : Bool -> Attribute msg
ismap =
    lift Html.Attributes.ismap


{-| Specify the hash name reference of a `map` that should be used for an `img`
or `object`. A hash name reference is a hash symbol followed by the element's name or id.
E.g. `"#planet-map"`.
-}
usemap : String -> Attribute msg
usemap =
    lift Html.Attributes.usemap


{-| Declare the shape of the clickable area in an `a` or `area`. Valid values
include: default, rect, circle, poly. This attribute can be paired with
`coords` to create more particular shapes.
-}
shape : String -> Attribute msg
shape =
    lift Html.Attributes.shape


{-| A set of values specifying the coordinates of the hot-spot region in an
`area`. Needs to be paired with a `shape` attribute to be meaningful.
-}
coords : String -> Attribute msg
coords =
    lift Html.Attributes.coords



-- REAL STUFF


{-| Specifies the horizontal alignment of a `caption`, `col`, `colgroup`,
`hr`, `iframe`, `img`, `table`, `tbody`, `td`, `tfoot`, `th`, `thead`, or
`tr`.
-}
align : String -> Attribute msg
align =
    lift Html.Attributes.align


{-| Contains a URI which points to the source of the quote or change in a
`blockquote`, `del`, `ins`, or `q`.
-}
cite : String -> Attribute msg
cite =
    lift Html.Attributes.cite



-- LINKS AND AREAS


{-| The URL of a linked resource, such as `a`, `area`, `base`, or `link`.
-}
href : String -> Attribute msg
href =
    lift Html.Attributes.href


{-| Specify where the results of clicking an `a`, `area`, `base`, or `form`
should appear. Possible special values include:

  - \_blank &mdash; a new window or tab
  - \_self &mdash; the same frame (this is default)
  - \_parent &mdash; the parent frame
  - \_top &mdash; the full body of the window

You can also give the name of any `frame` you have created.

-}
target : String -> Attribute msg
target =
    lift Html.Attributes.target


{-| Indicates that clicking an `a` and `area` will download the resource
directly. The `String` argument determins the name of the downloaded file.
Say the file you are serving is named `hats.json`.

    download "" -- hats.json

    download "my-hats.json" -- my-hats.json

    download "snakes.json" -- snakes.json

The empty `String` says to just name it whatever it was called on the server.

-}
download : String -> Attribute msg
download =
    lift Html.Attributes.download


{-| Two-letter language code of the linked resource of an `a`, `area`, or `link`.
-}
hreflang : String -> Attribute msg
hreflang =
    lift Html.Attributes.hreflang


{-| Specifies a hint of the target media of a `a`, `area`, `link`, `source`,
or `style`.
-}
media : String -> Attribute msg
media =
    lift Html.Attributes.media


{-| Specify a URL to send a short POST request to when the user clicks on an
`a` or `area`. Useful for monitoring and tracking.
-}
ping : String -> Attribute msg
ping =
    lift Html.Attributes.ping


{-| Specifies the relationship of the target object to the link object.
For `a`, `area`, `link`.
-}
rel : String -> Attribute msg
rel =
    lift Html.Attributes.rel



-- CRAZY STUFF


{-| Indicates the date and time associated with the element.
For `del`, `ins`, `time`.
-}
datetime : String -> Attribute msg
datetime =
    lift Html.Attributes.datetime


{-| Indicates whether this date and time is the date of the nearest `article`
ancestor element. For `time`.
-}
pubdate : String -> Attribute msg
pubdate =
    lift Html.Attributes.pubdate



-- ORDERED LISTS


{-| Indicates whether an ordered list `ol` should be displayed in a descending
order instead of a ascending.
-}
reversed : Bool -> Attribute msg
reversed =
    lift Html.Attributes.reversed


{-| Defines the first number of an ordered list if you want it to be something
besides 1.
-}
start : Int -> Attribute msg
start =
    lift Html.Attributes.start



-- TABLES


{-| The colspan attribute defines the number of columns a cell should span.
For `td` and `th`.
-}
colspan : Int -> Attribute msg
colspan =
    lift Html.Attributes.colspan


{-| A space separated list of element IDs indicating which `th` elements are
headers for this cell. For `td` and `th`.
-}
headers : String -> Attribute msg
headers =
    lift Html.Attributes.headers


{-| Defines the number of rows a table cell should span over.
For `td` and `th`.
-}
rowspan : Int -> Attribute msg
rowspan =
    lift Html.Attributes.rowspan


{-| Specifies the scope of a header cell `th`. Possible values are: col, row,
colgroup, rowgroup.
-}
scope : String -> Attribute msg
scope =
    lift Html.Attributes.scope


{-| Specifies the URL of the cache manifest for an `html` tag.
-}
manifest : String -> Attribute msg
manifest =
    lift Html.Attributes.manifest



-- Additional functions


{-| An attribute that does nothing.
-}
none : Attribute msg
none =
    Batchable.Html.fromAttributes []


{-| Batch bunch of attributes.
    It is especially usefull to create Mixins.
-}
batch : List (Attribute msg) -> Attribute msg
batch =
    Batchable.Html.fromAttributes <<
    List.concatMap Batchable.Html.toAttributes


-- Helper functions


lift : (a -> Html.Attribute msg) -> a -> Attribute msg
lift f a =
    Batchable.Html.fromAttributes [ f a ]


lift2 : (a -> b -> Html.Attribute msg) -> a -> b -> Attribute msg
lift2 f a b =
    Batchable.Html.fromAttributes [ f a b ]
