module Utils exposing (..)


getFromMaybe : Maybe String -> String
getFromMaybe promise =
    case promise of
        Just promise ->
            promise

        Nothing ->
            ""
