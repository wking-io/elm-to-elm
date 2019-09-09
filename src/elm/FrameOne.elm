port module FrameOne exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (Value)
import Json.Encode as Encode
import Result


type Model
    = Solo String
    | Duo String


init : Value -> ( Model, Cmd Msg )
init flags =
    ( Solo "Make init work", Cmd.none )


type Msg
    = Ping


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ping ->
            ( model, outbox (Encode.object [ ( "type", Encode.string "start" ) ]) )


view : Model -> Html Msg
view model =
    case model of
        Solo modelMsg ->
            Html.div [ id "frameOne" ]
                [ Html.h1 [] [ Html.text ("FrameOne Solo: " ++ modelMsg) ]
                ]

        Duo modelMsg ->
            Html.div [ id "frameOne" ]
                [ Html.h1 [] [ Html.text ("FrameOne Duo: " ++ modelMsg) ]
                ]


port outbox : Value -> Cmd msg


port inbox : (Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
