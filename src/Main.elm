module Main exposing (Model, main)

import Browser
import Counter exposing (counter)
import Html exposing (..)
import Html.Attributes exposing (..)
import InteropDefinitions exposing (Flags)
import InteropPorts exposing (decodeFlags)
import Json.Decode
import Math exposing (isPrime)
import Memo exposing (Memo)
import Msg exposing (..)
import VitePluginHelper exposing (asset)



-- MAIN


main : Program Json.Decode.Value Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { num : Int, result : Bool, memoized : Memo Int Bool, flags : Flags, latestIncomingMessageError : Maybe Json.Decode.Error }


init : Json.Decode.Value -> ( Model, Cmd Msg )
init rawFlags =
    let
        flags =
            rawFlags
                |> decodeFlags
                |> Result.withDefault defaultFlags

        { initialValue } =
            flags.counter
    in
    ( { num = initialValue, result = isPrime initialValue, memoized = Memo.memo isPrime, flags = flags, latestIncomingMessageError = Nothing }, Cmd.none )


defaultFlags : Flags
defaultFlags =
    { counter = { btnDelta = 3, initialValue = 1 } }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTo value ->
            let
                num =
                    value
                        |> String.toInt
                        |> Maybe.withDefault 2

                ( memoized, result ) =
                    Memo.apply model.memoized num
            in
            ( { model
                | num = num
                , result = result
                , memoized = memoized
              }
            , Cmd.none
            )

        Ping ->
            ( model, InteropPorts.fromElm InteropDefinitions.PingFromElm )

        UpdateBy delta ->
            let
                num =
                    model.num
                        + delta
                        |> clamp 0 100

                ( memoized, result ) =
                    Memo.apply model.memoized num
            in
            ( { model | num = num, result = result, memoized = memoized }, Cmd.none )

        DecodeIncomingMessageError err ->
            ( { model | latestIncomingMessageError = Just err }, Cmd.none )

        Reset ->
            ( { model | num = model.flags.counter.initialValue, result = isPrime model.flags.counter.initialValue }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    main_ [ class "main" ]
        [ header [ class "toolbar header" ]
            [ h1 [] [ text "vite-elm-ts-template" ]
            , img [ src <| asset "./assets/logo.png", class "logo" ] []
            ]
        , counter { num = model.num, isPrime = model.result, btnDelta = model.flags.counter.btnDelta }
        , footer [ class "footer" ] [ text "A ", a [ href "https://vitejs.dev/" ] [ text "Vite" ], text " template for building apps with ", a [ href "https://elm-lang.org/" ] [ text "Elm" ], text " and ", a [ href "https://www.typescriptlang.org/" ] [ text "Typescript" ] ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    InteropPorts.toElm
        |> Sub.map
            (\toElm ->
                case toElm of
                    Ok msg ->
                        case msg of
                            InteropDefinitions.PingFromTs ->
                                Ping

                    Err decodingError ->
                        DecodeIncomingMessageError decodingError
            )
