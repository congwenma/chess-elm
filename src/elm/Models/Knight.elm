module Models.Knight exposing (..)

import Models.Coordinate exposing (..)


getMovePotential : Coordinate -> List Coordinate
getMovePotential coord =
    [ coord ]


getKillPotential : Coordinate -> List Coordinate
getKillPotential coord =
    [ coord ]
