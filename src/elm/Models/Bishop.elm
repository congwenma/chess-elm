module Models.Bishop exposing (..)

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
        Debug.log "********8Potential Kills" <|
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
                [ findPotentialLeftUp (x - 1) (y - 1) allCoordinatesWithPiece []
                    |> firstInList myCoord
                    |> applyToMaybeCoord (\coord -> Coordinate (coord.x - 1) (coord.y - 1))
                , findPotentialRightUp (x + 1) (y - 1) allCoordinatesWithPiece []
                    |> firstInList myCoord
                    |> applyToMaybeCoord (\coord -> Coordinate (coord.x + 1) (coord.y - 1))
                , findPotentialLeftDown (x - 1) (y + 1) allCoordinatesWithPiece []
                    |> firstInList myCoord
                    |> applyToMaybeCoord (\coord -> Coordinate (coord.x - 1) (coord.y + 1))
                , findPotentialRightDown (x + 1) (y + 1) allCoordinatesWithPiece []
                    |> firstInList myCoord
                    |> applyToMaybeCoord (\coord -> Coordinate (coord.x + 1) (coord.y + 1))
                ]


potentials : Coordinate -> List Piece -> List Coordinate
potentials { x, y } allPieces =
    let
        allCoordinatesWithPiece =
            List.map (\pce -> pce.coordinate) allPieces
    in
        flatten2D
            [ findPotentialLeftUp (x - 1) (y - 1) allCoordinatesWithPiece []
            , findPotentialRightUp (x + 1) (y - 1) allCoordinatesWithPiece []
            , findPotentialLeftDown (x - 1) (y + 1) allCoordinatesWithPiece []
            , findPotentialRightDown (x + 1) (y + 1) allCoordinatesWithPiece []
            ]


findPotentialLeftUp x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || y < 0 of
            True ->
                accu

            False ->
                findPotentialLeftUp (x - 1) (y - 1) allCoordinatesWithPiece (Coordinate x y :: accu)


findPotentialRightUp x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || y < 0 of
            True ->
                accu

            False ->
                findPotentialRightUp (x + 1) (y - 1) allCoordinatesWithPiece (Coordinate x y :: accu)


findPotentialLeftDown x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || y > 7 of
            True ->
                accu

            False ->
                findPotentialLeftDown (x - 1) (y + 1) allCoordinatesWithPiece (Coordinate x y :: accu)


findPotentialRightDown : Int -> Int -> List Coordinate -> List Coordinate -> List Coordinate
findPotentialRightDown x y allCoordinatesWithPiece accu =
    let
        found =
            List.any (\cwp -> cwp == Coordinate x y) allCoordinatesWithPiece
    in
        case found || y > 7 of
            True ->
                accu

            False ->
                findPotentialRightDown (x + 1) (y + 1) allCoordinatesWithPiece (Coordinate x y :: accu)


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
