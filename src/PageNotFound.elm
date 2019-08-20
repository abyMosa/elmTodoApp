module PageNotFound exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Layouts.DefaultLayout as DefaultLayout

type alias Model =
    {
        title: String
    }


type Msg
    = NotFoundMsg


init : Model
init = { title = "Home" }



-- VIEW
view : Model -> DefaultLayout.Details msg
view model =
    { title = "PAGE NOT FOUND!!"
    , attrs = []
    , kids = [
            div[]
            [ h1[][ text "PAGE NOT FOUND!!" ]
            , p[][ text "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ]
            ]
        ]
    }
