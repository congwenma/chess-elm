module Msg exposing (..)

import Models.Coordinate exposing (..)
import Models.Piece exposing (..)


type Msg
    = SelectPiece Piece
    | MovePiece Coordinate
    | OtherSelectPiece
    | OtherMovePiece
