module ChessUtils exposing (..)

import Utils exposing (..)
import Models.Piece exposing (Piece)
import Dict


countPiecesByAvatar : List Piece -> List ( String, Int )
countPiecesByAvatar pieceList =
    List.sortBy Tuple.first <|
        Dict.toList <|
            List.foldl
                (\piece accu ->
                    let
                        avatarType =
                            piece.avatar.name

                        avatarTypeString =
                            toString avatarType
                    in
                        Dict.update avatarTypeString incrementFromMaybe accu
                )
                Dict.empty
                pieceList
