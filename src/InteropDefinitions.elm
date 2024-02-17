module InteropDefinitions exposing (Flags, FromElm(..), ToElm(..), interop)

import TsJson.Decode as TsDecode exposing (Decoder)
import TsJson.Encode as TsEncode exposing (Encoder)


interop :
    { toElm : Decoder ToElm
    , fromElm : Encoder FromElm
    , flags : Decoder Flags
    }
interop =
    { toElm = toElm
    , fromElm = fromElm
    , flags = flags
    }


type FromElm
    = PingFromElm


type ToElm
    = PingFromTs


type alias CounterFlags =
    { btnDelta : Int, initialValue : Int }


type alias Flags =
    { counter : { btnDelta : Int, initialValue : Int }
    }


fromElm : Encoder FromElm
fromElm =
    TsEncode.union
        (\vPong value ->
            case value of
                PingFromElm ->
                    vPong
        )
        |> TsEncode.variant0 "ping"
        |> TsEncode.buildUnion


toElm : Decoder ToElm
toElm =
    TsDecode.discriminatedUnion "tag"
        [ ( "ping"
          , TsDecode.succeed PingFromTs
          )
        ]


counterFlagDecoder : Decoder CounterFlags
counterFlagDecoder =
    TsDecode.succeed CounterFlags
        |> TsDecode.andMap (TsDecode.field "btnDelta" TsDecode.int |> TsDecode.map (\x -> clamp 0 100 x))
        |> TsDecode.andMap (TsDecode.field "initialValue" TsDecode.int |> TsDecode.map (\x -> clamp 0 100 x))


flags : Decoder Flags
flags =
    TsDecode.map Flags
        (TsDecode.field "counter" counterFlagDecoder)
