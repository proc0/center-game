module Data.Type exposing (..)

import Mouse exposing (Position)
import Keyboard exposing (KeyCode)
import Matrix exposing (Matrix, Location)
import Material exposing (Model, Msg)

--=======================--

type alias Game =
    { ui      : UI
    , chess   : Chess
    , players : Players
    }

--           ♔           --
--=======================--

type alias Chess =
    { board   : Board
    , history : History
    }

type Color = 
      White 
    | Black

type Role =
      Pawn
    | Rook
    | Bishop
    | Knight
    | Queen
    | King
    | Joker

type alias Piece =
    { position : Position
    , location : Location
    , color : Color
    , role : Role
    , tick : Int
    , path : List Location
    }

type alias Square = 
    { location : Location
    , piece : Maybe Piece
    , valid : Bool
    , active : Bool
    }

type alias Rank =
    List Square

type alias Board =
    Matrix Square

--     Interaction       --
--=======================--

type alias Selection =
    { board : Board
    , player : Player
    , square : Square
    , piece : Piece
    }

type alias Move =
    { start : Location
    , end : Location
    , piece : Piece
    , capture : Maybe Piece
    , enPassant : Bool
    }

type alias History = 
    List Move

type alias Translation = 
    Location -> Location

type alias Translations =
    List Translation

type alias Movement =
    Int -> Translation

type alias Movements =
    List (Int -> Translation)
      
type Action =
      Moving Selection
    | Playing Selection
    | End Move
    | Idle

--        Agents         --
--=======================--

type alias Player =
    { color  : Color
    , name   : String
    -- performs actions
    , action : Action
    -- captures pieces
    , pieces : List Piece
    }

type alias Players = 
    (Player, Player)

--       Rules           --
--=======================--

type alias Condition =
    (Translation, Square -> Bool)

--      Interface        --
--=======================--

type Event = 
      Click Position
    | Drag Position
    | Drop Position
    | Mdl (Msg Event)
    | Debug Bool

type alias UI =
    { mdl : Model
    , turn : String
    , debug : Bool
    }

