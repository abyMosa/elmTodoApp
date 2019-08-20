module Layouts.DefaultLayout exposing (..)


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
        [ viewHeader 
        , Html.map toMsg <|
            div (class "center" :: details.attrs) details.kids
        , viewFooter
        ]
    }


-- VIEW HEADER
viewHeader : Html msg
viewHeader =
  div
    [ style "backgroundColor" "#eeeeee"
    ]
    [ div [class "center"]
        [ h1 [ class "header", style "margin" "0px" ] [ text "Header" ]
        , ul []
            [ li [] [ createLink "" ]
            , li [] [ createLink "about" ]
            ]
        ]
    ]


viewFooter : Html msg
viewFooter =
  div [class "footer"]
    [ text "All code for this site is open source and written in Elm. "
    , a [ class "grey-link", href "https://github.com/elm/package.elm-lang.org/" ] [ text "Check it out" ]
    , text "! — © 2012-present Evan Czaplicki"
    ]


createLink : String -> Html msg
createLink path =
    a [ href ("/" ++ path) ] 
    [ 
        if path == "" then 
            text "Home"
        else
            text path
    ]