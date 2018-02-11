module Model exposing (..)

import Models.Coordinate exposing (Coordinate)
import Models.Piece exposing (Piece, PieceStatus(..))
import Models.GameSet exposing (gameSet)


type alias Model =
    { selectedPiece : Maybe Piece

    -- status
    , potentialMoves : List Coordinate
    , potentialKills : List Coordinate
    , previousMovedPiece : Maybe Piece
    , winner : String

    -- all Pieces
    , pieces : List Piece
    , alivePieces : List Piece
    }


init : Model
init =
    { selectedPiece = Nothing
    , potentialMoves = []
    , potentialKills = []
    , previousMovedPiece = Nothing
    , winner = ""

    -- all pieces
    , pieces = gameSet
    , alivePieces = gameSet
    }
