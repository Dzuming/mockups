module Page.NotFound exposing (..)

import Html exposing (Html, div, text)
import Skeleton exposing (Warning(..))

view : Skeleton.Details never
view =
    { title = "Login"
    , header = [ Skeleton.notFoundSegment ]
    , warning = NoProblems
    , attrs = []
    , kids = [ viewContent ]
    }


viewContent : Html never
viewContent =
    div [] [ text "Not found" ]
