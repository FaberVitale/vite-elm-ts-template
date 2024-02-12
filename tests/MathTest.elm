module MathTest exposing (suite)

import Expect
import Math exposing (..)
import Set
import Test exposing (..)


primeNumbersList : List Int
primeNumbersList =
    [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 ]


primeNumbersSet : Set.Set Int
primeNumbersSet =
    Set.fromList primeNumbersList


list0To100 : List Int
list0To100 =
    List.range 0 100


nonPrimeNumbersList : List Int
nonPrimeNumbersList =
    List.filter (\x -> not (Set.member x primeNumbersSet)) list0To100


suite : Test
suite =
    describe "Math"
        [ describe "isPrime"
            [ test "detects prime numbers correctly" <| \_ -> Expect.equal (List.all isPrime primeNumbersList) True
            , test "detects non prime numbers correctly" <| \_ -> Expect.equal (List.all (isPrime >> not) nonPrimeNumbersList) True
            ]
        ]
