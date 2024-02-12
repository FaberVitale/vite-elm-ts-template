module MemoTest exposing (..)

import Expect
import Math exposing (..)
import Memo as M
import Test exposing (..)


suite : Test
suite =
    describe "Memo"
        [ test "It returns the correct output" <|
            \_ ->
                let
                    memoFunc =
                        M.memo (\x -> x * x)

                    first =
                        M.apply memoFunc 4

                    second =
                        M.apply (Tuple.first first) 4

                    results =
                        { first = Tuple.second first, second = Tuple.second second }
                in
                Expect.equal results { first = 16, second = 16 }
        ]
