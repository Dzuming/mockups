module Skeleton exposing
    ( Details
    , Segment
    , Warning(..)
    , view
    , loginSegment
    , notFoundSegment
    )

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (..)



-- NODE


type alias Details msg =
    { title : String
    , header : List Segment
    , warning : Warning
    , attrs : List (Attribute msg)
    , kids : List (Html msg)
    }


type Warning
    = NoProblems



-- SEGMENT


type Segment
    = Text String
    | Link String String

loginSegment : Segment
loginSegment =
  Text "login"

notFoundSegment : Segment
notFoundSegment =
  Text "Not Found"

-- VIEW


view : (a -> msg) -> Details a -> Browser.Document msg
view toMsg details =
    { title =
        details.title
    , body =
        [ viewHeader details.header
        , lazy viewWarning details.warning
        , Html.map toMsg <|
            div (class "center" :: details.attrs) details.kids
        , viewFooter
        ]
    }



-- VIEW HEADER


viewHeader : List Segment -> Html msg
viewHeader segments =
    div
        [style "background-color" "red"][text "Generic Header"]

viewWarning : Warning -> Html msg
viewWarning warning =
    div [ class "header-underbar" ] <|
        case warning of
            NoProblems ->
                []



-- VIEW FOOTER


viewFooter : Html msg
viewFooter =
    div footerAttributes
        [ text "Generic Footer"]

footerAttributes : List (Attribute msg)
footerAttributes =
    [ style "position" "absolute"
    , style "bottom" "0"
    ]
