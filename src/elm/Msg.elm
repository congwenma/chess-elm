module Msg exposing (..)

import Models.Coordinate exposing (..)
import Models.Piece exposing (..)
import Ui.Modal


type Msg
    = SelectPiece Piece
    | MovePiece Coordinate
    | KillPiece Piece
    | OtherSelectPiece
    | OtherMovePiece
    | ResetGame Ui.Modal.Msg
    | ResetGame2
