module Models.Pawn exposing (..)

import Models.Coordinate exposing (..)
import Models.Piece exposing (Piece)
import Models.Avatar exposing (FactionType(..))


-- TODO: and later should consider the board


getMovePotential : Piece -> List Coordinate
getMovePotential { coordinate, avatar } =
    let
        { x, y } =
            coordinate

        { faction } =
            avatar
    in
        case faction of
            BlackPlayer ->
                if y == 1 then
                    -- and black
                    [ Coordinate x (y + 1), Coordinate x (y + 2) ]
                else
                    [ Coordinate x (y + 1) ]

            WhitePlayer ->
                if y == 6 then
                    -- and black
                    [ Coordinate x (y - 1), Coordinate x (y - 2) ]
                else
                    [ Coordinate x (y - 1) ]


getKillPotential : Piece -> List Coordinate
getKillPotential { coordinate, avatar } =
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
