module Memo exposing (..)

import Dict exposing (Dict)
import Html exposing (input)


type alias Memo comparable res =
    { func : comparable -> res, dict : Dict comparable res }



{- Executes memoized function -}


apply : Memo comparable res -> comparable -> ( Memo comparable res, res )
apply memoized input =
    case memoized of
        { func, dict } ->
            case Dict.get input dict of
                Nothing ->
                    let
                        result =
                            func input

                        nextDict =
                            Dict.insert input result dict
                    in
                    ( { func = func, dict = nextDict }, result )

                Just result ->
                    let
                        nextDict =
                            Dict.insert input result dict
                    in
                    ( { func = func, dict = nextDict }, result )



{- Creates a new memoized function -}


memo : (comparable -> b) -> Memo comparable b
memo func =
    { func = func, dict = Dict.empty }
