module Depo.FEN exposing (..)

import Regex
import String exposing (contains, split, toInt, toList)
import Char exposing (isUpper, toCode)
import Array exposing (get)
import Matrix exposing (Location, loc, fromList, mapWithLocation)
import List exposing (head, map, map2)
import Tuple exposing (mapFirst)
import Maybe.Extra exposing ((?))
import Debug exposing (log)

import Data.Type exposing (..)
import Data.Cast exposing (..)
import Data.Pure exposing (..)
import Data.Query exposing (..)
import Depo.SAN exposing (..)
import Depo.Moves exposing (..)
import Depo.Lib exposing (..)
import Config.Settings exposing (..)

--             Forsythe Edwards Notation (FEN)             --
--=========================================================--

initialPieces = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
openingBoard = initialPieces ++ " w KQkq - 0 1"
--openingBoard = enPassantBoard

-- other examples
--testingEngine = "K6k/3n2pp/8/1P6/B7/8/6PP/8 w - - 0 1"
--whiteInCheck = "rnb1kbnr/pppppppp/4q3/8/8/8/PPP2PPP/RNBQKBNR w KQkq - 0 1"
--blackCheckMate = "1R6/8/kQ6/8/8/8/6K1/8 w - - 0 1"
enPassantBoard = "rnbqkbnr/1ppppppp/8/pP6/8/8/P1PPPPPP/RNBQKBNR w KQkq a6 0 1"
--whiteCastlingAvailable = "rnbqkbnr/1ppppppp/8/pP6/8/8/P1PPPPPP/R3K2R w KQkq - 0 1"
--blackCastlingAvailable = "r3k2r/1ppppppp/8/pP6/8/8/P1PPPPPP/R3K2R b KQkq - 0 1"

fromFEN : String -> Board
fromFEN fen =
    let parts =
        String.split " " fen |> Array.fromList
        -- TODO: update state when initial FEN has en passant flag
        passantPoint = Maybe.withDefault "-" (Array.get 3 parts)
        colorTurn = 
            case (Array.get 1 parts ? "w") of
                "w" -> White
                "b" -> Black
                _ -> White
        processPassant =
            if passantPoint /= "-" 
            then fenPassant passantPoint colorTurn 
            else identity
        board = parsePieces (Maybe.withDefault initialPieces (Array.get 0 parts))
    in
    board |> processPassant
            --(maybeContains (Array.get 1 parts) "w")
            --(maybeContains (Array.get 2 parts) "Q")
            --(maybeContains (Array.get 2 parts) "K")
            --(maybeContains (Array.get 2 parts) "q")
            --(maybeContains (Array.get 2 parts) "k")
            --(Maybe.withDefault "-" (Array.get 3 parts))
            --(Result.withDefault 0 (String.toInt (Maybe.withDefault "0" (Array.get 4 parts))))
            --(Result.withDefault 1 (String.toInt (Maybe.withDefault "0" (Array.get 5 parts))))

maybeContains str value =
    case str of
        Just s ->
            String.contains value s
        Nothing ->
            False

fenPassant : String -> Color -> Board -> Board
fenPassant coor player board =
    let capturePoint = 
            toSANLocation coor
        jester = ({ joker | color = opponent player })
        opponentPoint =
            forwardMove jester 1 capturePoint
        adjustPassant lc sq =
            if lc == opponentPoint
            then
                case sq.piece of
                Just pc ->
                    case pc.role of
                        Pawn ->
                            ({ sq 
                             | piece = 
                                Just ({ pc | tick = 1, path = pc.path ++ [forwardMove jester 1 capturePoint] })})
                        _ -> sq
                _ -> sq
            else sq
    in
    mapWithLocation adjustPassant board

parsePieces : String -> Board
parsePieces s =
    String.split "/" s |> List.map2 toRank boardside |> Matrix.fromList

toRank : Int -> String -> Rank
toRank y row =
    let pieces = expand row 
                 |> String.toList
        points = List.map2 (,) boardside (List.repeat 8 y)
                 |> List.map swap |> List.map (uncurry loc)
    in List.map2 toSquare points pieces

expand : String -> String
expand s =
    Regex.replace Regex.All (Regex.regex "[12345678]") expandMatch s

expandMatch { match } =
    String.repeat (Result.withDefault 0 (String.toInt match)) " "

toSquare : Location -> Char -> Square
toSquare lc ch = 
    let vacant = Square lc Nothing False False
        occupied = Square lc (Just <| toPiece ch lc) False False
    in 
    if toRole ch == Joker -- empty square sentinel
    then vacant           -- guards against invalid 
    else occupied         -- piece letters

toPiece : Char -> Location -> Piece
toPiece ch point =
    let drag = 
            toBoardPosition point
        -- initial point
        path = [point]
        role = toRole ch
        tick = 0
        lock = False
        check = False
        newPiece color = 
            (Piece 
                point 
                drag 
                color 
                role 
                tick
                lock
                check
                path)
    in 
    if isUpper ch
    then newPiece White
    else newPiece Black
