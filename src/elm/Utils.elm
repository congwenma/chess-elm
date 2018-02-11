module Utils exposing (..)


getFromMaybe : Maybe String -> String
getFromMaybe promise =
    case promise of
        Just promise ->
            promise

        Nothing ->
            ""


incrementFromMaybe : Maybe Int -> Maybe Int
incrementFromMaybe maybeNum =
    case maybeNum of
        Just num ->
            Just (num + 1)

        Nothing ->
            -- if this return Nothing, this key is deleted
            Just 1


expand n =
    List.range 0 (n - 1)
