module Models.Castle exposing (..)

import Models.Coordinate exposing (Coordinate)
import Models.Piece exposing (Piece)
import ChessUtils exposing (areAnyPieceOnCoordinate, areAnyEnemiesOnCoordinate)
import Debug


flatten2D : List (List a) -> List a
flatten2D list =
    List.foldr (++) [] list


firstInList : a -> List a -> Maybe a
firstInList defaultCoord listCoords =
    case List.head listCoords of
        Just value ->
            Just value

        Nothing ->
            Just defaultCoord


applyToMaybeCoord : (b -> a) -> Maybe b -> Maybe a
applyToMaybeCoord func maybeCoord =
    case maybeCoord of
        Just coord ->
            Just (func coord)

        Nothing ->
            Nothing


potentialKills : Coordinate -> List Piece -> List Coordinate
potentialKills myCoord allPieces =
    let
        { x, y } =
            myCoord

        allCoordinatesWithPiece =
            List.map (\pce -> pce.coordinate) allPieces
    in
        -- Debug.log "********8Potential Kills" <|
        List.foldl
            (\maybeValue accu ->
                case maybeValue of
                    Just value ->
                        value :: accu

                    Nothing ->
                        accu
            )
            []
        <|
            [ findPotentialLeft (x - 1) y allCoordinatesWithPiece []
                |> firstInList myCoord
                |> applyToMaybeCoord (\coord -> Coordinate (coord.x - 1) coord.y)
            , findPotentialRight (x + 1) y allCoordinatesWithPiece []
                |> firstInList myCoord
                |> applyToMaybeCoord (\coord -> Coordinate (coord.x + 1) coord.y)
            , findPotentialUp x (y - 1) allCoordinatesWithPiece []
                |> firstInList myCoord
                |> applyToMaybeCoord (\coord -> Coordinate coord.x (coord.y - 1))
            , findPotentialDown x (y + 1) allCoordinatesWithPiece []
                |> firstInList myCoord
                |> applyToMaybeCoord (\coord -> Coordinate coord.x (coord.y + 1))
            ]


potentials : Coordinate -> List Piece -> List Coordinate
potentials { x, y } allPieces =
    let
        allCoordinatesWithPiece =
            List.map (\pce -> pce.coordinate) allPieces

        info =
            Debug.log "*CONTAINS pawn" <|
                List.any (\p -> p.coordinate.x == 7 && p.coordinate.y == 6) allPieces
    in
        flatten2D <|
            Debug.log "*POTENTIALS"
                [ findPotentialLeft (x - 1) y allCoordinatesWithPiece []
                , findPotentialRight (x + 1) y allCoordinatesWithPiece []
                , findPotentialUp x (y - 1) allCoordinatesWithPiece []
                , findPotentialDown x (y + 1) allCoordinatesWithPiece []
                ]


findPotentialLeft x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || x < 0 of
            True ->
                accu

            False ->
                findPotentialLeft (x - 1) y allCoordinatesWithPiece (Coordinate x y :: accu)


findPotentialRight x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || x > 7 of
            True ->
                accu

            False ->
                findPotentialRight (x + 1) y allCoordinatesWithPiece (Coordinate x y :: accu)


findPotentialDown x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || y > 7 of
            True ->
                accu

            False ->
                findPotentialDown x (y + 1) allCoordinatesWithPiece (Coordinate x y :: accu)


findPotentialUp : Int -> Int -> List Coordinate -> List Coordinate -> List Coordinate
findPotentialUp x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || y < 0 of
            True ->
                accu

            False ->
                findPotentialUp x (y - 1) allCoordinatesWithPiece (Coordinate x y :: accu)


getMovePotential : Piece -> List Piece -> List Coordinate
getMovePotential { coordinate, avatar } allPieces =
    List.filter
        (\coord ->
            not <| areAnyPieceOnCoordinate allPieces coord
        )
        (potentials coordinate allPieces)


getKillPotential : Piece -> List Piece -> List Coordinate
getKillPotential { coordinate, avatar } allPieces =
    List.filter
        (\coord ->
            areAnyEnemiesOnCoordinate avatar allPieces coord
        )
        (potentialKills coordinate allPieces)
