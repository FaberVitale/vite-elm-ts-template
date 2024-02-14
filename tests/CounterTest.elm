module CounterTest exposing (suite)

import Counter exposing (CounterProps, counter)
import Html.Attributes exposing (value)
import Msg
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Html


props : CounterProps
props =
    { num = 3, isPrime = True, btnDelta = 5 }


deltaAsString : String
deltaAsString =
    String.fromInt props.btnDelta


suite : Test
suite =
    describe "counter"
        [ test "Input field updates triggers a request to update" <|
            \_ ->
                counter props
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "input" ]
                    |> Event.simulate (Event.input "28")
                    |> Event.expect (Msg.UpdateTo "28")
        , test "Input field uses props.num as value" <|
            \_ ->
                counter props
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "input" ]
                    |> Query.has [ Html.attribute <| value (String.fromInt props.num) ]
        , test "Clicking on -btnDelta triggers a request to update by -props.btnDelta" <|
            \_ ->
                counter props
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "button", Html.containing [ Html.text ("+" ++ deltaAsString) ] ]
                    |> Event.simulate Event.click
                    |> Event.expect (Msg.UpdateBy props.btnDelta)
        , test "Clicking on +btnDelta triggers a request to update by +props.btnDelta" <|
            \_ ->
                counter props
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "button", Html.containing [ Html.text ("-" ++ deltaAsString) ] ]
                    |> Event.simulate Event.click
                    |> Event.expect (Msg.UpdateBy -props.btnDelta)
        , test "Clicking on reset triggers a reset request" <|
            \_ ->
                counter props
                    |> Query.fromHtml
                    |> Query.find [ Html.tag "button", Html.containing [ Html.text "reset" ] ]
                    |> Event.simulate Event.click
                    |> Event.expect Msg.Reset
        ]
