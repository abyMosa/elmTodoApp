module Routes exposing ( Route(..) , matchRoute, matchedRoute, content, Msg(..) )

import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Browser.Navigation as Navigation
import Url
import Url.Parser as Url exposing (Parser, (</>), custom, fragment, map, oneOf, s, top)
import Url.Parser.Query as Query

import Home as Home
import About as About
import PageNotFound as NotFound

import Layouts.MainLayout as MainLayout

type alias Model =
    { url : Url.Url
    , key : Navigation.Key
    }

type Route
    = Home
    | About

type Msg
    = PageNotFound NotFound.Msg
    | PageHome Home.Msg
    | PageAbout About.Msg

matchRoute : Url.Parser (Route -> a) a
matchRoute =
    Url.oneOf
        [ Url.map About <| Url.s "about"
        , Url.map Home <| Url.top
        ]

matchedRoute : Model -> Html Msg
matchedRoute model =
    case Url.parse matchRoute model.url of
        Just path ->
            case path of
                Home ->
                    Home.view |> Html.map PageHome

                About ->
                    About.view |> Html.map PageAbout
            
        Nothing ->
            NotFound.view |> Html.map PageNotFound

content : Model -> Html Msg
content model =
    div []
        [ matchedRoute model
        ]
