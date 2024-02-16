module Msg exposing (Msg(..))

import Json.Decode


type Msg
    = UpdateTo String
    | Reset
    | UpdateBy Int
    | Ping
    | DecodeIncomingMessageError Json.Decode.Error
