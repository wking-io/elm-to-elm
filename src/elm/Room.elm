module Room exposing (Doors, Room, RoomPosition(..), decoder, only, render, updateDoors)

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


decoder : Decoder Room
decoder =
    Decode.map Room (Decode.field "key" Decode.string)
