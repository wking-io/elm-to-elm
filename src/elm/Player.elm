module Player exposing (Direction, Player(..), Position, center, decoder, directionDecoder, encode, from, isEdge, maybeRender, move, moveDown, moveLeft, moveRight, moveUp, process, render, start, there, update)

import Dict exposing (Dict)
import Html exposing (Attribute, Html)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Svg
import Svg.Attributes exposing (..)
import Tuple


type Player
    = Here Position
    | There


there : Player
there =
    There


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


type Direction
    = Left
    | Right
    | Up
    | Down


directionToString : Direction -> String
directionToString direction =
    case direction of
        Left ->
            "left"

        Right ->
            "right"

        Up ->
            "up"

        Down ->
            "down"


directionDecoder : Decoder Direction
directionDecoder =
    Decode.andThen toDirection (Decode.field "keyCode" Decode.int)


process : { stayMsg : Direction -> Position -> msg, leaveMsg : Direction -> Position -> msg } -> Player -> Direction -> Decoder msg
process { stayMsg, leaveMsg } player direction =
    case player of
        There ->
            Decode.fail "This is not the room you are looking for."

        Here position ->
            if isEdge direction position then
                Decode.succeed (leaveMsg direction position)

            else
                Decode.succeed (stayMsg direction position)


toDirection : Int -> Decoder Direction
toDirection int =
    case int of
        65 ->
            Decode.succeed Left

        37 ->
            Decode.succeed Left

        68 ->
            Decode.succeed Right

        39 ->
            Decode.succeed Right

        83 ->
            Decode.succeed Down

        40 ->
            Decode.succeed Down

        87 ->
            Decode.succeed Up

        38 ->
            Decode.succeed Up

        _ ->
            Decode.fail "This is not the keypress you are looking for."


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


move : Direction -> Position -> Position
move direction position =
    case direction of
        Left ->
            moveLeft position

        Right ->
            moveRight position

        Up ->
            moveUp position

        Down ->
            moveDown position


update : Direction -> Position -> Player -> Player
update direction position player =
    if isEdge direction position then
        There

    else
        move direction position |> Here


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


maybeRender : Player -> Html msg
maybeRender player =
    case player of
        There ->
            Svg.text ""

        Here position ->
            render position


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


center : Position
center =
    CenterCenter


start : Player
start =
    Here center


from : Position -> Player
from position =
    Here position


decoder : Decoder Player
decoder =
    Decode.map Here positionDecoder


isEdge : Direction -> Position -> Bool
isEdge direction position =
    case ( direction, position ) of
        ( Left, TopLeft ) ->
            True

        ( Left, CenterLeft ) ->
            True

        ( Left, BottomLeft ) ->
            True

        ( Up, TopLeft ) ->
            True

        ( Up, TopCenter ) ->
            True

        ( Up, TopRight ) ->
            True

        ( Right, TopRight ) ->
            True

        ( Right, CenterRight ) ->
            True

        ( Right, BottomRight ) ->
            True

        ( Down, BottomLeft ) ->
            True

        ( Down, BottomCenter ) ->
            True

        ( Down, BottomRight ) ->
            True

        _ ->
            False


positionDecoder : Decoder Position
positionDecoder =
    Decode.map2 Tuple.pair
        (Decode.field "direction" Decode.string)
        (Decode.field "position" Decode.string)
        |> Decode.andThen positionFromData


positionFromData : ( String, String ) -> Decoder Position
positionFromData data =
    case data of
        ( "down", "bottomleft" ) ->
            Decode.succeed TopLeft

        ( "down", "bottomcenter" ) ->
            Decode.succeed TopCenter

        ( "down", "bottomright" ) ->
            Decode.succeed TopRight

        ( "up", "topleft" ) ->
            Decode.succeed BottomLeft

        ( "up", "topcenter" ) ->
            Decode.succeed BottomCenter

        ( "up", "topright" ) ->
            Decode.succeed BottomRight

        ( "left", "topleft" ) ->
            Decode.succeed TopRight

        ( "left", "centerleft" ) ->
            Decode.succeed CenterRight

        ( "left", "bottomleft" ) ->
            Decode.succeed BottomRight

        ( "right", "topright" ) ->
            Decode.succeed TopLeft

        ( "right", "centerright" ) ->
            Decode.succeed CenterLeft

        ( "right", "bottomright" ) ->
            Decode.succeed BottomLeft

        _ ->
            Decode.fail "Unknown position and direction"


positionToString : Position -> String
positionToString position =
    case position of
        TopLeft ->
            "topleft"

        TopCenter ->
            "topcenter"

        TopRight ->
            "topright"

        CenterLeft ->
            "centerleft"

        CenterCenter ->
            "centercenter"

        CenterRight ->
            "centerright"

        BottomLeft ->
            "bottomleft"

        BottomCenter ->
            "bottomcenter"

        BottomRight ->
            "bottomright"


encode : Direction -> Position -> Value
encode direction position =
    Encode.object
        [ ( "direction", Encode.string (directionToString direction) )
        , ( "position", Encode.string (positionToString position) )
        ]
