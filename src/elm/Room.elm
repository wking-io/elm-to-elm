module Room exposing (Doors, Room, RoomPosition(..), Source, decoder, only, render, roomDecoder, updateDoors, validate)

import Dict exposing (Dict)
import Html exposing (Attribute, Html)
import Json.Decode as Decode exposing (Decoder)
import Svg
import Svg.Attributes exposing (..)


type Room
    = Room String


type RoomPosition
    = RoomRight
    | RoomLeft
    | RoomTop
    | RoomBottom


positionFromString : String -> Decoder RoomPosition
positionFromString str =
    case str of
        "left" ->
            Decode.succeed RoomLeft

        "right" ->
            Decode.succeed RoomRight

        "up" ->
            Decode.succeed RoomTop

        "down" ->
            Decode.succeed RoomBottom

        _ ->
            Decode.fail "Not a valid position"


type Doors
    = One Room
    | Two DoorAssignments
    | Three DoorAssignments
    | Four DoorAssignments


type alias DoorAssignments =
    { top : Room
    , right : Room
    , bottom : Room
    , left : Room
    }


type Source
    = Source Room RoomPosition


validate : Source -> Doors -> Bool
validate (Source room roomDirection) doors =
    getDoorFromDirection roomDirection doors
        |> equals room


getDoorFromDirection : RoomPosition -> Doors -> Room
getDoorFromDirection roomPosition doors =
    case doors of
        One room ->
            room

        Two assignments ->
            assignments |> directionToGetter roomPosition

        Three assignments ->
            assignments |> directionToGetter roomPosition

        Four assignments ->
            assignments |> directionToGetter roomPosition


directionToGetter : RoomPosition -> (DoorAssignments -> Room)
directionToGetter roomPosition =
    case roomPosition of
        RoomRight ->
            .right

        RoomLeft ->
            .left

        RoomTop ->
            .top

        RoomBottom ->
            .bottom


equals : Room -> Room -> Bool
equals (Room x) (Room y) =
    x == y


only : Room -> Doors
only room =
    One room


updateDoors : RoomPosition -> Room -> Doors -> Doors
updateDoors pos room doors =
    case doors of
        One oldRoom ->
            case pos of
                RoomRight ->
                    Two
                        { top = oldRoom
                        , bottom = oldRoom
                        , left = room
                        , right = room
                        }

                RoomLeft ->
                    Two
                        { top = oldRoom
                        , bottom = oldRoom
                        , left = room
                        , right = room
                        }

                RoomTop ->
                    Two
                        { top = room
                        , bottom = room
                        , left = oldRoom
                        , right = oldRoom
                        }

                RoomBottom ->
                    Two
                        { top = room
                        , bottom = room
                        , left = oldRoom
                        , right = oldRoom
                        }

        Two { left, right, top, bottom } ->
            case pos of
                RoomRight ->
                    Three
                        { top = top
                        , bottom = bottom
                        , left = left
                        , right = room
                        }

                RoomLeft ->
                    Three
                        { top = top
                        , bottom = bottom
                        , left = room
                        , right = right
                        }

                RoomTop ->
                    Three
                        { top = room
                        , bottom = bottom
                        , left = left
                        , right = right
                        }

                RoomBottom ->
                    Three
                        { top = top
                        , bottom = room
                        , left = left
                        , right = right
                        }

        Three { left, right, top, bottom } ->
            case pos of
                RoomRight ->
                    Four
                        { top = top
                        , bottom = bottom
                        , left = left
                        , right = room
                        }

                RoomLeft ->
                    Four
                        { top = top
                        , bottom = bottom
                        , left = room
                        , right = right
                        }

                RoomTop ->
                    Four
                        { top = room
                        , bottom = bottom
                        , left = left
                        , right = right
                        }

                RoomBottom ->
                    Four
                        { top = top
                        , bottom = room
                        , left = left
                        , right = right
                        }

        Four _ ->
            doors


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


decoder : Decoder Source
decoder =
    Decode.map2 Source roomDecoder positionDecoder


roomDecoder : Decoder Room
roomDecoder =
    Decode.map Room (Decode.field "key" Decode.string)


positionDecoder : Decoder RoomPosition
positionDecoder =
    Decode.andThen positionFromString (Decode.field "direction" Decode.string)
