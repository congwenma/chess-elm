module Models.Pawn exposing (..)

import Models.Coordinate exposing (..)
import Models.Piece exposing (Piece)
import Models.Avatar exposing (FactionType(..))


-- TODO: and later should consider the board


getMovePotential : Piece -> List Piece -> List Coordinate
getMovePotential { coordinate, avatar } allPieces =
    let
        { x, y } =
            coordinate

        { faction } =
            avatar
    in
        case faction of
            BlackPlayer ->
                let
                    oneStep =
                        Coordinate x (y + 1)

                    twoStep =
                        Coordinate x (y + 2)

                    noPieceOnOneStep =
                        List.all (\piece -> piece.coordinate /= oneStep) allPieces
                in
                    if y == 1 && noPieceOnOneStep then
                        [ oneStep, twoStep ]
                    else
                        [ oneStep ]

            WhitePlayer ->
                let
                    oneStep =
                        Coordinate x (y - 1)

                    twoStep =
                        Coordinate x (y - 2)

                    noPieceOnOneStep =
                        List.all (\piece -> piece.coordinate /= oneStep) allPieces
                in
                    if y == 6 && noPieceOnOneStep then
                        -- and black
                        [ oneStep, twoStep ]
                    else
                        [ oneStep ]


getKillPotential : Piece -> List Piece -> List Coordinate
getKillPotential { coordinate, avatar } allPieces =
    let
        { x, y } =
            coordinate

        { faction } =
            avatar
    in
        case faction of
            BlackPlayer ->
                [ Coordinate (x + 1) (y + 1), Coordinate (x - 1) (y + 1) ]

            WhitePlayer ->
                [ Coordinate (x + 1) (y - 1), Coordinate (x - 1) (y - 1) ]
