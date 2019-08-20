module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, b, a, ul, li)
import Html.Attributes exposing (src, class, href)

import Browser.Navigation as Navigation
import Url
import Url.Parser as Url exposing (Parser, (</>), custom, fragment, map, oneOf, s, top)
import Url.Parser.Query as Query

import Home as Home
import About as About
import PageNotFound as NotFound
import Layouts.DefaultLayout as DefaultLayout exposing (..)
import Layouts.EmptyLayout as EmptyLayout exposing (..)

---- MODEL ----
type alias Model =
    { route: Route
    , key : Navigation.Key
    }

type Route
    = Home Home.Model
    | About About.Model
    | NotFound NotFound.Model


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    ( 
      { route = matchedRoute url
      , key = key 
      }
    , Cmd.none
    )

---- UPDATE ----
type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | PageNotFound NotFound.Msg
    | PageHome Home.Msg
    | PageAbout About.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlRequested urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model
          , Navigation.pushUrl model.key (Url.toString url) 
          )

        Browser.External href ->
          ( model, Navigation.load href )

    UrlChanged url ->
            ( { model | route = matchedRoute url }
            , Cmd.none
            )

    PageNotFound _ ->
        ( model , Cmd.none )

    PageHome _ ->
        ( model , Cmd.none )

    PageAbout _ ->
        ( model , Cmd.none )

---- VIEW ----
view : Model -> Browser.Document Msg
view model =
    case model.route of
        NotFound notfound ->
            EmptyLayout.view PageNotFound (NotFound.view notfound)
        Home home ->
            DefaultLayout.view PageHome (Home.view home)
        About about -> 
            DefaultLayout.view PageAbout (About.view about)
        
        -- 


-- SUBSCRIPTION
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


---- PROGRAM ----
main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }
        

-- HELPERS
matchRoute : Url.Parser (Route -> a) a
matchRoute =   
    Url.oneOf
        [ Url.map (About About.init) <| Url.s "about"
        , Url.map ( Home Home.init) <| Url.top
        ]


matchedRoute : Url.Url -> Route
matchedRoute url =
    case Url.parse matchRoute url of
        Just route -> 
            route

        Nothing ->
            NotFound NotFound.init