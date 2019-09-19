port module GameFour exposing (main)

import Browser
import Browser.Events exposing (onKeyDown)
import Html exposing (Html)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Player exposing (Player, Position)
import Result
import Room exposing (Doors, Room, RoomPosition)
import Set exposing (Set)
import Svg
import Task


type Model
    = Solo Position
    | Multiple Player Doors


init : Value -> ( Model, Cmd Msg )
init flags =
    ( Solo Player.center, Task.succeed (SendMail (Encode.object [ ( "type", Encode.string "gameStart" ) ])) |> Task.perform identity )


type Msg
    = SendMail Value
    | YouHaveMail Value
    | Left
    | Right
    | Up
    | Down
    | OtherKeyPressed


keypressDecoder : Decode.Decoder Msg
keypressDecoder =
    Decode.map toDirection (Decode.field "keyCode" Decode.int)


toDirection : Int -> Msg
toDirection int =
    case int of
        65 ->
            Left

        37 ->
            Left

        68 ->
            Right

        39 ->
            Right

        83 ->
            Down

        40 ->
            Down

        87 ->
            Up

        38 ->
            Up

        _ ->
            OtherKeyPressed


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendMail mail ->
            ( model, outbox mail )

        YouHaveMail mail ->
            readMail mail
                |> Result.map (handleMail model)
                |> Result.withDefault ( model, Cmd.none )

        Left ->
            case model of
                Solo position ->
                    ( Solo (Player.moveLeft position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        Right ->
            case model of
                Solo position ->
                    ( Solo (Player.moveRight position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        Up ->
            case model of
                Solo position ->
                    ( Solo (Player.moveUp position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        Down ->
            case model of
                Solo position ->
                    ( Solo (Player.moveDown position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        OtherKeyPressed ->
            ( model, Cmd.none )


readMail : Value -> Result Decode.Error Mail
readMail value =
    Decode.decodeValue mailDecoder value


handleMail : Model -> Mail -> ( Model, Cmd Msg )
handleMail model mail =
    case mail of
        Connect room roomPosition ->
            case model of
                Solo position ->
                    ( Multiple Player.there (Room.only room), Cmd.none )

                Multiple player doors ->
                    ( Multiple player (Room.updateDoors roomPosition room doors), Cmd.none )

        NewPlayer player ->
            case model of
                Solo _ ->
                    ( model, Cmd.none )

                Multiple oldPlayer doors ->
                    ( Multiple player doors, Cmd.none )

        NotMine _ ->
            ( model, Cmd.none )


type Mail
    = Connect Room RoomPosition
    | NewPlayer Player
    | NotMine String


parseMail : String -> Decoder Mail
parseMail mailType =
    case mailType of
        "gameStart" ->
            Decode.andThen getNeighbor keyDecoder
                |> Decode.map2 Connect Room.decoder

        "playerTransfer" ->
            Decode.map NewPlayer (Decode.field "details" Player.decoder)

        _ ->
            Decode.succeed (NotMine mailType)


getNeighbor : String -> Decoder RoomPosition
getNeighbor roomId =
    case roomId of
        "game-two" ->
            Decode.succeed Room.RoomTop

        "game-three" ->
            Decode.succeed Room.RoomLeft

        _ ->
            Decode.fail "Not my neighbor"


keyDecoder : Decoder String
keyDecoder =
    Decode.field "key" Decode.string


mailDecoder : Decoder Mail
mailDecoder =
    Decode.field "type" Decode.string
        |> Decode.andThen parseMail


view : Model -> Html Msg
view model =
    case model of
        Solo position ->
            Html.div [ id "game-four" ]
                [ Player.render position |> Room.render ]

        Multiple player _ ->
            Html.div [ id "game-four" ]
                [ Player.maybeRender player |> Room.render ]


port outbox : Value -> Cmd msg


port inbox : (Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ inbox YouHaveMail
        , onKeyDown keypressDecoder
        ]


main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
