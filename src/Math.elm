module Math exposing (isPrime)


isPrime : Int -> Bool
isPrime val =
    case val of
        2 ->
            True

        3 ->
            True

        _ ->
            if val < 2 || modBy 2 val == 0 || modBy 3 val == 0 then
                False

            else
                val
                    |> toFloat
                    |> sqrt
                    |> floor
                    |> List.range 2
                    |> List.any (\n -> modBy n val == 0)
                    |> not
