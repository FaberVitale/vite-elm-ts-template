module Main exposing (Model, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Math exposing (isPrime)
import Memo exposing (Memo)
import Msg exposing (..)
import VitePluginHelper exposing (asset)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { num : Int, result : Bool, memoized : Memo Int Bool }


init : Model
init =
    { num = 10, result = False, memoized = Memo.memo isPrime }


btnDelta : number
btnDelta =
    5



-- UPDATE


stringFromBool : Bool -> String
stringFromBool val =
    if val then
        "True"

    else
        "False"


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTo value ->
            let
                num =
                    value
                        |> String.toInt
                        |> Maybe.withDefault init.num

                ( memoized, result ) =
                    Memo.apply model.memoized num
            in
            { num = num, result = result, memoized = memoized }

        UpdateBy delta ->
            let
                num =
                    model.num
                        + delta
                        |> clamp 0 100

                ( memoized, result ) =
                    Memo.apply model.memoized num
            in
            { num = num, result = result, memoized = memoized }

        Reset ->
            { init | memoized = model.memoized }



-- View


view : Model -> Html Msg
view model =
    let
        numAsString =
            String.fromInt model.num

        increaseDeltaToString =
            String.fromInt btnDelta

        isPrimeAsString =
            stringFromBool model.result
    in
    main_ [ class "main" ]
        [ header [ class "toolbar" ]
            [ h1 [] [ text "vite-elm-template" ]
            , img [ src <| asset "./assets/logo.png", class "logo" ] []
            ]
        , div [ class "toolbar" ]
            [ input [ attribute "type" "range", attribute "min" "1", attribute "max" "100", value numAsString, onInput UpdateTo ] []
            , p [] [ text ("Input: " ++ numAsString ++ ", isPrime: " ++ isPrimeAsString) ]
            ]
        , div [ class "toolbar" ]
            [ button [ attribute "type" "button", onClick (UpdateBy -btnDelta) ] [ text ("-" ++ increaseDeltaToString) ]
            , button [ attribute "type" "button", onClick (UpdateBy btnDelta) ] [ text ("+" ++ increaseDeltaToString) ]
            , button [ attribute "type" "button", onClick Reset ] [ text "reset" ]
            ]
        ]
