module Login exposing (..)

import Browser
import Html exposing (Attribute, Html, button, form, input, text)
import Html.Attributes exposing (placeholder, style, type_, value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { name : String
    , password : String
    }


init : Model
init =
    Model "" ""


type Msg
    = Name String
    | Password String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }


view : Model -> Html Msg
view model =
    form formAttributes
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , button [ type_ "submit" ] [ text "Submit" ]
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


formAttributes : List (Attribute msg)
formAttributes =
    [ style "position" "absolute"
    , style "top" "50%"
    , style "left" "50%"
    , style "transform" "translate(-50%, -50%)"
    , style "background" "rgb(250, 250, 250)"
    , style "padding" "20px"
    , style "border" "1px solid"
    , style "display" "flex"
    , style "flex-direction" "column"
    , style "justify-content" "center"
    , style "align-items" "center"
    ]
