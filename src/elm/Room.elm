module Room exposing (Room, render)

import Dict exposing (Dict)
import Html exposing (Attribute, Html)
import Svg
import Svg.Attributes exposing (..)


type Room
    = Room String


render : Html msg -> Html msg
render player =
    Svg.svg
        [ width "270"
        , height "270"
        , viewBox "0 0 270 270"
        ]
        [ Svg.rect
            [ x "0"
            , y "0"
            , width "270"
            , height "270"
            , class "fill-current text-grey-100"
            ]
            []
        , player
        ]
