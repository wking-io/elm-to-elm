port module GameThree exposing (main)

import Board exposing (BoardList, Player, Position)
import Browser
import Browser.Events exposing (onKeyDown)
import Html exposing (Html)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Result
import Svg
import Task


type Model
    = Solo Position
    | Multiple Player BoardList


init : Value -> ( Model, Cmd Msg )
init flags =
    ( Solo Board.startingPosition, Task.succeed (SendMail (Encode.object [ ( "type", Encode.string "game-start" ) ])) |> Task.perform identity )


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
                    ( Solo (Board.moveLeft position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        Right ->
            case model of
                Solo position ->
                    ( Solo (Board.moveRight position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        Up ->
            case model of
                Solo position ->
                    ( Solo (Board.moveUp position), Cmd.none )

                Multiple _ _ ->
                    ( model, Cmd.none )

        Down ->
            case model of
                Solo position ->
                    ( Solo (Board.moveDown position), Cmd.none )

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
        Connect _ ->
            ( model, Cmd.none )

        NotMine _ ->
            ( model, Cmd.none )


type Mail
    = Connect String
    | NotMine String


parseMail : String -> Decoder Mail
parseMail mailType =
    case mailType of
        "count-start" ->
            connectDecoder

        _ ->
            notMineDecoder mailType


connectDecoder : Decoder Mail
connectDecoder =
    Decode.map Connect keyDecoder


keyDecoder : Decoder String
keyDecoder =
    Decode.field "key" Decode.string


notMineDecoder : String -> Decoder Mail
notMineDecoder unknownType =
    Decode.succeed (NotMine unknownType)


mailDecoder : Decoder Mail
mailDecoder =
    Decode.field "type" Decode.string
        |> Decode.andThen parseMail


view : Model -> Html Msg
view model =
    case model of
        Solo position ->
            Html.div [ id "game-three" ]
                [ Board.render position ]

        Multiple _ _ ->
            Html.div [ id "game-three" ]
                []


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
