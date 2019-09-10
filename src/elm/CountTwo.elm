port module CountTwo exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode as Encode
import Result
import Task


type Model
    = Solo
    | Duo String Int


init : Value -> ( Model, Cmd Msg )
init flags =
    ( Solo, Task.succeed (SendMail (Encode.object [ ( "type", Encode.string "start" ) ])) |> Task.perform identity )


type Msg
    = SendMail Value
    | YouHaveMail Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendMail mail ->
            ( model, outbox mail )

        YouHaveMail mail ->
            readMail mail
                |> Result.map (handleMail model)
                |> Result.withDefault ( model, Cmd.none )


readMail : Value -> Result Decode.Error Mail
readMail value =
    Decode.decodeValue mailDecoder value


handleMail : Model -> Mail -> ( Model, Cmd Msg )
handleMail model mail =
    case mail of
        Connect key ->
            case model of
                Solo ->
                    ( Duo key 0, Cmd.none )

                Duo _ _ ->
                    ( model, Cmd.none )

        Increase ->
            case model of
                Solo ->
                    ( model, Cmd.none )

                Duo k x ->
                    ( Duo k (x + 1), Cmd.none )


type Mail
    = Connect String
    | Increase


parseMail : String -> Decoder Mail
parseMail mailType =
    case mailType of
        "start" ->
            connectDecoder

        "increase" ->
            increaseDecoder

        _ ->
            Decode.fail ("Invalid mail type: " ++ mailType)


connectDecoder : Decoder Mail
connectDecoder =
    Decode.map Connect keyDecoder


keyDecoder : Decoder String
keyDecoder =
    Decode.field "key" Decode.string


increaseDecoder : Decoder Mail
increaseDecoder =
    Decode.succeed Increase


mailDecoder : Decoder Mail
mailDecoder =
    Decode.field "type" Decode.string
        |> Decode.andThen parseMail


view : Model -> Html Msg
view model =
    case model of
        Solo ->
            Html.div [ id "count-two", class "text-center w-1/2 p-16" ]
                [ Html.h1 [] [ Html.text "Elm App Two: Waiting for friend" ]
                ]

        Duo key count ->
            Html.div [ id "count-two", class "text-center w-1/2 p-16" ]
                [ Html.h1 [ class "text-2xl font-bold mb-4" ] [ Html.text ("Elm App Two: " ++ String.fromInt count) ]
                , Html.button [ class "px-4 py-2 bg-primary hover:bg-primary-dark text-white font-medium shadow hover:shadow-md rounded", onClick (SendMail (Encode.object [ ( "type", Encode.string "increase" ) ])) ] [ Html.text "Add one to other Elm app" ]
                ]


port outbox : Value -> Cmd msg


port inbox : (Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    inbox YouHaveMail


main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
