module Models.Pawn exposing (..)

import Models.Coordinate exposing (..)


getMovePotential : Coordinate -> List Coordinate
getMovePotential coord =
    [ coord ]
