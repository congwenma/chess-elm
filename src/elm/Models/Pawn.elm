module Models.Pawn exposing (..)

import Models.Coordinate exposing (..)


-- TODO: and later should consider the board


getMovePotential : Coordinate -> List Coordinate
getMovePotential coord =
    let
        { x, y } =
            coord
    in
        if y == 1 then
            -- and black
            [ Coordinate x (y + 1), Coordinate x (y + 2) ]
        else
            [ Coordinate x (y + 1) ]


getKillPotential : Coordinate -> List Coordinate
getKillPotential coord =
    [ coord ]
