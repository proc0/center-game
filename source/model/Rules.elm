module Model.Rules exposing (..)

import Matrix exposing (Location, get)
import Maybe.Extra exposing ((?), isJust)
import List exposing (filterMap, concatMap, map, foldl, head, any, length)
import Debug exposing (log)

import Data.Tool exposing (..)
import Data.Type exposing (..)
import Data.Query exposing (..)
import Model.Moves exposing (..)

-- main moves
-- ==========--

pieceMoves : Piece -> Board -> List Translation
pieceMoves piece board = 
    let cast fn = 
            fn board piece
        diagonals =
            cast stepSearch asterisk
        parallels =
            cast stepSearch cross
        moves role =
            case role of
                Pawn   -> cast pawnMoves
                Bishop -> diagonals
                Rook   -> parallels
                Queen  -> 
                    diagonals 
                    ++ 
                    parallels               
                Knight -> 
                    [ up 2 >> right 1
                    , up 2 >> left 1
                    , down 2 >> left 1
                    , down 2 >> right 1
                    , left 2 >> up 1
                    , left 2 >> down 1
                    , right 2 >> up 1
                    , right 2 >> down 1
                    ]
                King ->
                    [ up 1
                    , down 1
                    , left 1
                    , right 1
                    , up 1 >> left 1
                    , up 1 >> right 1
                    , down 1 >> left 1
                    , down 1 >> right 1
                    ]
                    ++
                    cast castle
                _ -> []
    in 
    -- get possible moves by role
    moves piece.role 
    -- and filter squares occupied
    -- by same color pieces
    |> cast distinct

-- helpers
-- =======--

validate : Board -> Piece -> (Translation, Square -> Bool) -> List Translation -> List Translation
validate board piece (move, rule) moves =
    let target = 
        get (move piece.location) board
    in 
    ((\square ->
    if rule square
    then move::moves
    else moves) <? target) ? moves

-- TODO: refactor and take out Rules, flip type
distinct : Board -> Piece -> List Translation -> List Translation
distinct board piece locations = 
    filterMap (\move -> 
        case get (move piece.location) board of
            Just square ->
                case square.piece of
                    Just pc -> 
                        if pc.color == piece.color
                        then Nothing
                        else Just move
                    _ -> Just move
            _ -> Nothing) locations

-- rules
-- =====--

castle : Board -> Piece -> List Translation
castle board king = 
    let sides = 
            [ right
            , left
            ]
        withKing fn =
            fn board king
        analizeK = 
            foldl (withKing validate) []
        clear tests =
            (length <| analizeK tests)
            ==
            (length tests)
        castling step =
            let castlepath =
                    [ (step 1, isVacant)
                    , (step 2, isVacant)
                    ]
                kingRookRule = 
                    [ (step 3, isNewRook)
                    ]
                queenRookRule =
                    [ (step 4, isNewRook)
                    ]
                rookReady = 
                    clear kingRookRule 
                    || clear queenRookRule
            in 
            (rookReady && clear castlepath)
            ??
            (map fst castlepath)
    in
    stationary king ?? concatMap castling sides

pawnMoves : Board -> Piece -> List Translation
pawnMoves board pawn =
    let (y,x) = pawn.location
        step = forward pawn
        checkPawn fn = 
            fn board pawn
        checkRules = 
            foldl (checkPawn validate) []
        rules : List (Translation, Square -> Bool)
        rules = 
            -- if pawn hasn't moved
            (if starting pawn
            -- add two steps if vacant
            then [(step 2, isVacant)] 
            else []) 
            ++ 
            -- can step forward if vacant
            [ (step 1, isVacant)
            -- can eat diagonals if occupied
            , (step 1 >> left 1, isOccupied)
            , (step 1 >> right 1, isOccupied)
            ]
    in
    checkRules rules 
    ++ 
    checkPawn enPassant

enPassant : Board -> Piece -> List Translation
enPassant board pawn = 
    let step = forward pawn
        checkPawn = foldl (validate board pawn) []
        passantRules move = 
            [ (move 1, isUntouched)
            , (move 1, hasPawn)
            ]
        passing : Movement -> Square -> Bool
        passing dir square =
            if isVacant square
            then (length << checkPawn <| passantRules dir)
                 == -- rules length does not change after check
                 (length <| passantRules identity)
            else False
        rules : List (Translation, Square -> Bool)
        rules =
            [ (step 1 >> left 1, passing left)
            , (step 1 >> right 1, passing right)
            ]
    in 
    checkPawn rules

isEnPassant : Board -> Piece -> Bool
isEnPassant board piece = 
    passanting piece && (isJust << head <| enPassant board piece)

