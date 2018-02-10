module Models.Castle exposing (..)

import Models.Coordinate exposing (Coordinate)
import Models.Piece exposing (Piece)
import ChessUtils exposing (areAnyPieceOnCoordinate, areAnyEnemiesOnCoordinate)
import Debug


flatten2D : List (List a) -> List a
flatten2D list =
    List.foldr (++) [] list


lastInList : List a -> Maybe a
lastInList list =
    List.reverse list |> List.head


applyToLast func maybeCoord =
    case maybeCoord of
        Just coord ->
            Just (func coord)

        Nothing ->
            Nothing


potentials : Coordinate -> List Piece -> List Coordinate
potentials { x, y } allPieces =
    let
        allCoordinatesWithPiece =
            List.map (\pce -> pce.coordinate) allPieces
    in
        [ findPotentialLeft (x - 1) y allCoordinatesWithPiece []
            |> lastInList
            |> applyToLast (\coord -> Coordinate (coord.x - 1) coord.y)
        , findPotentialRight (x + 1) y allCoordinatesWithPiece []
            |> lastInList
            |> applyToLast (\coord -> Coordinate (coord.x + 1) coord.y)
        , findPotentialUp x (y - 1) allCoordinatesWithPiece []
            |> lastInList
            |> applyToLast (\coord -> Coordinate coord.x (coord.y - 1))
        , findPotentialDown x (y + 1) allCoordinatesWithPiece []
            |> lastInList
            |> applyToLast (\coord -> Coordinate coord.x (coord.y + 1))
        ]
            |> List.filter (\maybeValue -> maybeValue /= Nothing)
            |> List.map
                (\maybeValue ->
                    case maybeValue of
                        Just value ->
                            value
                )


potentialKills : Coordinate -> List Piece -> List Coordinate
potentialKills { x, y } allPieces =
    let
        allCoordinatesWithPiece =
            List.map (\pce -> pce.coordinate) allPieces
    in
        flatten2D
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


findPotentialUp x y allCoordinatesWithPiece accu =
    let
        info =
            Debug.log "findPotentialUp" ( x, y )

        found =
            Debug.log "findPotentialUp" <| List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
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
            not <| areAnyPieceOnCoordinate allPieces coord
        )
        (potentials coordinate allPieces)
