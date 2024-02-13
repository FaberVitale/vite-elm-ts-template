module Main exposing (Model, main)

import Browser
import Counter exposing (counter)
import Html exposing (..)
import Html.Attributes exposing (..)
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
    { num = 2, result = False, memoized = Memo.memo isPrime }


btnDelta : number
btnDelta =
    5



-- UPDATE


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
    main_ [ class "main" ]
        [ header [ class "toolbar header" ]
            [ h1 [] [ text "vite-elm-ts-template" ]
            , img [ src <| asset "./assets/logo.png", class "logo" ] []
            ]
        , counter { num = model.num, isPrime = model.result, btnDelta = btnDelta }
        , footer [ class "footer" ] [ text "A ", a [ href "https://vitejs.dev/" ] [ text "Vite" ], text " template for building apps with ", a [ href "https://elm-lang.org/" ] [ text "Elm" ], text " and ", a [ href "https://www.typescriptlang.org/" ] [ text "Typescript" ] ]
        ]
