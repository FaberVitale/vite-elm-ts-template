module Counter exposing (..)

import Html exposing (..)
import Html.Attributes as A exposing (..)
import Html.Events exposing (onClick, onInput)
import Msg exposing (..)


type alias CounterProps =
    { num : Int, isPrime : Bool, btnDelta : Int }


counter : { num : Int, isPrime : Bool, btnDelta : Int } -> Html Msg
counter { num, isPrime, btnDelta } =
    let
        numAsString =
            String.fromInt num

        increaseDeltaToString =
            String.fromInt btnDelta

        stringFromBool val =
            if val then
                "yes"

            else
                "no"

        isPrimeAsString =
            stringFromBool isPrime
    in
    div []
        [ div [ class "toolbar justify-center" ]
            [ input [ id "counter-range", type_ "range", A.min "1", A.max "100", value numAsString, onInput UpdateTo ] []
            , label [ for "counter-range" ] [ text ("n: " ++ numAsString) ]
            , output [] [ text ("isPrime: " ++ isPrimeAsString) ]
            ]
        , div [ class "toolbar justify-center" ]
            [ button [ type_ "button", onClick (UpdateBy -btnDelta) ] [ text ("-" ++ increaseDeltaToString) ]
            , button [ type_ "button", onClick (UpdateBy btnDelta) ] [ text ("+" ++ increaseDeltaToString) ]
            , button [ type_ "button", onClick Reset ] [ text "reset" ]
            ]
        ]
