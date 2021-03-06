module Model.Rules exposing (..)

import Matrix exposing (Location, get, mapWithLocation, flatten)
import Maybe.Extra exposing ((?), isJust)
import List exposing (any, concat, concatMap, filterMap, foldl, head, isEmpty, length, map)
import Debug exposing (log)

import Data.Cast exposing (..)
import Data.Type exposing (..)
import Data.Query exposing (..)
import Depo.Moves exposing (..)
import Depo.Lib exposing (..)

-- main moves
-- ==========--

pieceMoves : Piece -> Board -> Translations
pieceMoves piece board = 
    let find f = f piece board
        linear = find linearMove
        moves role =
            case role of
                Pawn   -> find pawnMoves
                Bishop -> linear diagonals
                Rook   -> linear straights
                Queen  -> linear asterisk               
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
                    find castle
                _ -> []
    in 
    -- get possible moves by role
    moves piece.role 
    -- and filter squares occupied
    -- by same color pieces
    |> distinct piece board

-- helpers
-- =======--

validate : Piece -> Board -> (Translation, Square -> Bool) -> Translations -> Translations
validate piece board (move, rule) moves =
    let target = Matrix.get (move piece.point) board
    in 
    (target |> Maybe.map 
        (\square ->
            if rule square
            then move::moves
            else moves)) ? moves

distinct : Piece -> Board -> Translations -> Translations
distinct piece board locations = 
    filterMap (\move -> 
        case Matrix.get (move piece.point) board of
            Just square ->
                case square.piece of
                    Just pc -> 
                        if pc.color == piece.color
                        then Nothing
                        else Just move
                    _ -> Just move
            _ -> Nothing) locations

findNextOpponent : Piece -> Board -> List Movements -> Translations
findNextOpponent piece board =
    stepSearch piece board (isVacant, (not << friendlyOccupied piece.color)) (flip always, (::))

findKing : Piece -> Board -> List Movements -> Translations
findKing piece board = 
    stepSearch piece board (isVacant, isKingSquare) (flip always,(::))

findThreat : Piece -> Board -> Translations
findThreat piece board = 
    let stopWhen sq =
            let pinner =
                case sq.piece of
                    Just pc -> isPinner pc && pc.color /= piece.color
                    _ -> False
            in
            pinner
        res = stepSearch piece board (isVacant, stopWhen) (flip always,(::)) asterisk
        _ = log "-" res
    in res

-- rule like queries
-- =================--

withKing : Piece -> Board -> (Piece -> Board -> Board) -> Board
withKing piece board fn =
    case piece.role of
        King -> fn piece board
        _ -> board
        
withPinner : Piece -> Board -> (Piece -> Board -> List Movements -> Translations) -> Translations
withPinner piece board fn =
    case piece.role of
        Bishop -> fn piece board diagonals
        Rook -> fn piece board straights
        Queen -> fn piece board asterisk
        _ -> []
        
startingRank : Piece -> Int
startingRank piece =
    let offset n = 
        case piece.color of
            White -> 7 - n
            Black -> n
    in
    case piece.role of
        Pawn -> offset 1
        _ -> offset 0

starting : Piece -> Bool
starting piece = 
    let (y,x) = 
        piece.point
    in 
    startingRank piece == y

capturing : Player -> Maybe Selection -> Bool 
capturing player selection =
    selection |> Maybe.map (\s -> 
                s.piece.color /= player.color
              ) |> Maybe.withDefault False

isEnPassant : Piece -> Board -> Bool
isEnPassant piece board = 
    passanting piece && (not << isEmpty <| enPassant piece board)

isCastling : Piece -> Bool
isCastling piece =
    let castlesLocations = 
            toLocations 
               ([ (7,6)
                , (7,2)
                , (0,6)
                , (0,2)
                ])
    in
    case piece.role of
        King -> any ((==) piece.point) castlesLocations
        _ -> False

isChecking : Piece -> Board -> Bool
isChecking piece board =
    any identity <| flatten <| mapWithLocation (\lc sq -> 
        if sq.valid
        then 
            case sq.piece of
                Just p ->
                    case p.role of
                        King -> True
                        _ -> False
                _ -> False
        else False) board

-- general rules
-- =================--
   
castle : Piece -> Board -> Translations
castle king board = 
    let sides = 
            [ right
            , left
            ]
        withKing fn =
            fn king board
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

pawnMoves : Piece -> Board -> Translations
pawnMoves pawn board =
    let (y,x) = pawn.point
        step = forwardMove pawn
        checkPawn fn = 
            fn pawn board
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
            -- can step forwardMove if vacant
            [ (step 1, isVacant)
            -- can eat diagonals if occupied
            , (step 1 >> left 1, isOccupied)
            , (step 1 >> right 1, isOccupied)
            ]
    in
    checkRules rules ++ (if passanting pawn then checkPawn enPassant else [])

enPassant : Piece -> Board -> Translations
enPassant pawn board = 
    let step = forwardMove pawn
        checkPawn = foldl (validate pawn board) []
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

