module Layouts.EmptyLayout exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as D

type alias Details msg =
    { title : String
    , attrs : List (Attribute msg)
    , kids : List (Html msg)
    }



-- VIEW
view : (a -> msg) -> Details a -> Browser.Document msg
view toMsg details =
    { title =
        details.title
    , body =
        [ Html.map toMsg <|
            div (class "center" :: details.attrs) details.kids
        ]
    }
