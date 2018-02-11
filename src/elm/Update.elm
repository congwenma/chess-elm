-- UPDATE: make moves


module Update exposing (..)

import Model exposing (..)
import Models.MoveForPiece exposing (..)
import Models.Piece exposing (Piece, PieceStatus(..))
import Models.Avatar exposing (AvatarType(King))
import Models.Coordinate exposing (..)
import Ui.Modal


type Msg
    = SelectPiece Piece
    | MovePiece Coordinate
    | KillPiece Piece
    | OtherSelectPiece
    | OtherMovePiece
    | ResetGame Ui.Modal.Msg
    | ResetGame2


noWinner : String
noWinner =
    ""


replacePieceInPieces : Piece -> List Piece -> List Piece
replacePieceInPieces selected allPieces =
    allPieces
        |> List.indexedMap
            (\index pce ->
                if pce.id == selected.id then
                    selected
                else
                    pce
            )


update : Msg -> Model -> Model
update msg model =
    case msg of
        ResetGame2 ->
            init

        ResetGame uimsg ->
            Debug.log "****Reset Game" <| init

        SelectPiece piece ->
            { model
                | selectedPiece = Just piece
                , potentialMoves =
                    Debug.log
                        "potentialMoves"
                    <|
                        getMoveForAnyPiece piece model.alivePieces
                , potentialKills =
                    Debug.log
                        "potentialKills"
                    <|
                        getKillForAnyPiece piece model.alivePieces
            }

        MovePiece coordinate ->
            let
                -- info = Debug.log "MOVING PIECE" (toString coordinate)
                coordinateIsPotentialMove =
                    List.member coordinate model.potentialMoves

                coordinateHasNoPiece =
                    List.all (\piece -> not (piece.coordinate == coordinate)) model.alivePieces

                selectedPieceAfterMove =
                    -- Debug.log "SELECT PIECE AFTER MOVE" <|
                    case model.selectedPiece of
                        Just selectedPiece ->
                            -- Debug.log "SELECT PIECE" <|
                            if coordinateIsPotentialMove && coordinateHasNoPiece then
                                Just { selectedPiece | coordinate = coordinate }
                            else
                                model.selectedPiece

                        Nothing ->
                            Nothing

                afterMovePieces =
                    case selectedPieceAfterMove of
                        Just selectedPiece ->
                            replacePieceInPieces selectedPiece model.pieces

                        Nothing ->
                            model.pieces
            in
                { model
                    | pieces = afterMovePieces
                    , selectedPiece = Nothing
                    , potentialMoves = []
                    , potentialKills = []
                    , previousMovedPiece = selectedPieceAfterMove
                }

        KillPiece piece ->
            killPieceFn piece model

        OtherSelectPiece ->
            model

        OtherMovePiece ->
            model


killPieceFn : Piece -> Model -> Model
killPieceFn pieceToBeKilled model =
    let
        coordinateIsPotentialKill =
            List.member pieceToBeKilled.coordinate model.potentialKills

        selectedPieceAfterKill =
            -- Debug.log "SELECT pieceToBeKilled AFTER MOVE" <|
            case model.selectedPiece of
                Just selectedPiece ->
                    -- Debug.log "SELECT pieceToBeKilled" <|
                    if coordinateIsPotentialKill then
                        Just { selectedPiece | coordinate = pieceToBeKilled.coordinate }
                    else
                        model.selectedPiece

                Nothing ->
                    Nothing

        afterMovePieces =
            if coordinateIsPotentialKill then
                case selectedPieceAfterKill of
                    Just newPiece ->
                        -- markAsDead newPiece model.pieces
                        replacePieceInPieces newPiece model.pieces
                            |> List.map
                                (\pce ->
                                    if pce == pieceToBeKilled then
                                        { pce | status = Dead }
                                    else
                                        pce
                                )

                    Nothing ->
                        model.pieces
            else
                model.pieces

        winningCondition =
            if pieceToBeKilled.avatar.name == King && not (List.member pieceToBeKilled afterMovePieces) then
                toString <| Models.Avatar.enemyOf pieceToBeKilled.avatar.faction
            else
                noWinner
    in
        Debug.log "Update completed" <|
            { model
                | pieces = afterMovePieces
                , selectedPiece = Nothing
                , potentialMoves = []
                , potentialKills = []
                , previousMovedPiece = selectedPieceAfterKill
                , alivePieces = List.filter (\pce -> pce.status == Alive) afterMovePieces
                , winner = winningCondition
            }
