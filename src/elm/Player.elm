module Player exposing (Player, Position, decoder, moveDown, moveLeft, moveRight, moveUp, render, start)

import Dict exposing (Dict)
import Html exposing (Attribute, Html)
import Json.Decode as Decode exposing (Decoder)
import Svg
import Svg.Attributes exposing (..)
import Tuple


type Player
    = Here Position
    | There


type Position
    = TopLeft
    | TopCenter
    | TopRight
    | CenterLeft
    | CenterCenter
    | CenterRight
    | BottomLeft
    | BottomCenter
    | BottomRight


moveRight : Position -> Position
moveRight position =
    case position of
        TopLeft ->
            TopCenter

        TopCenter ->
            TopRight

        TopRight ->
            position

        CenterLeft ->
            CenterCenter

        CenterCenter ->
            CenterRight

        CenterRight ->
            position

        BottomLeft ->
            BottomCenter

        BottomCenter ->
            BottomRight

        BottomRight ->
            position


moveLeft : Position -> Position
moveLeft position =
    case position of
        TopLeft ->
            position

        TopCenter ->
            TopLeft

        TopRight ->
            TopCenter

        CenterLeft ->
            position

        CenterCenter ->
            CenterLeft

        CenterRight ->
            CenterCenter

        BottomLeft ->
            position

        BottomCenter ->
            BottomLeft

        BottomRight ->
            BottomCenter


moveUp : Position -> Position
moveUp position =
    case position of
        TopLeft ->
            position

        TopCenter ->
            position

        TopRight ->
            position

        CenterLeft ->
            TopLeft

        CenterCenter ->
            TopCenter

        CenterRight ->
            TopRight

        BottomLeft ->
            CenterLeft

        BottomCenter ->
            CenterCenter

        BottomRight ->
            CenterRight


moveDown : Position -> Position
moveDown position =
    case position of
        TopLeft ->
            CenterLeft

        TopCenter ->
            CenterCenter

        TopRight ->
            CenterRight

        CenterLeft ->
            BottomLeft

        CenterCenter ->
            BottomCenter

        CenterRight ->
            BottomRight

        BottomLeft ->
            position

        BottomCenter ->
            position

        BottomRight ->
            position


render : Position -> Html msg
render position =
    Svg.rect
        (getPosition position
            ++ [ width "90"
               , height "90"
               , class "fill-current text-primary"
               ]
        )
        []


getPosition : Position -> List (Attribute msg)
getPosition position =
    case position of
        TopLeft ->
            [ x "0", y "0" ]

        TopCenter ->
            [ x "90", y "0" ]

        TopRight ->
            [ x "180", y "0" ]

        CenterLeft ->
            [ x "0", y "90" ]

        CenterCenter ->
            [ x "90", y "90" ]

        CenterRight ->
            [ x "180", y "90" ]

        BottomLeft ->
            [ x "0", y "180" ]

        BottomCenter ->
            [ x "90", y "180" ]

        BottomRight ->
            [ x "180", y "180" ]


start : Position
start =
    CenterCenter


decoder : Decoder Player
decoder =
    Decode.map Here positionDecoder


positionDecoder : Decoder Position
positionDecoder =
    Decode.map2 Tuple.pair
        (Decode.field "direction" Decode.string)
        (Decode.field "position" Decode.string)
        |> Decode.andThen positionFromData


positionFromData : ( String, String ) -> Decoder Position
positionFromData data =
    case data of
        ( "down", "left" ) ->
            Decode.succeed TopLeft

        ( "down", "center" ) ->
            Decode.succeed TopCenter

        ( "down", "right" ) ->
            Decode.succeed TopRight

        ( "up", "left" ) ->
            Decode.succeed BottomLeft

        ( "up", "center" ) ->
            Decode.succeed BottomCenter

        ( "up", "right" ) ->
            Decode.succeed BottomRight

        ( "left", "top" ) ->
            Decode.succeed TopRight

        ( "left", "center" ) ->
            Decode.succeed CenterRight

        ( "left", "bottom" ) ->
            Decode.succeed BottomRight

        ( "right", "top" ) ->
            Decode.succeed TopLeft

        ( "right", "center" ) ->
            Decode.succeed CenterLeft

        ( "right", "bottom" ) ->
            Decode.succeed BottomLeft

        _ ->
            Decode.fail "Unknown position and direction"
