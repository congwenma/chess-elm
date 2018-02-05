module Models.Coordinate exposing (..)


type alias Coordinate =
    { x : Int, y : Int }


intoString : Coordinate -> String
intoString { x, y } =
    "(" ++ (toString x) ++ ", " ++ (toString y) ++ ")"


intoStringXY : Int -> Int -> String
intoStringXY x y =
    "(" ++ (toString x) ++ ", " ++ (toString y) ++ ")"
