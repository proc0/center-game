module View.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import SvgParser exposing (parse)
import Debug exposing (..)

import Data.Main exposing (..)
import Data.Game as G exposing (..)
import Settings exposing (..)
import Toolkit exposing (..)
import Frame.Main exposing (..)
import View.Assets.Pieces exposing (..)

render : Model -> Html Msg
render { game, select, player } =
    node "main" 
        [ onMouseDown 
        ]
        [ r_player player
        , r_pieces game.board
        , r_board select game.board 
        ]

-- render player layer
----------------------
r_player : Maybe Moving -> Html Msg
r_player mv =
    let mv_piece = case mv of
                        Just {current,piece} -> case piece of
                                       Just p -> ([class "visible"], [r_svg2 (toPosition (current.y,current.x)) p])
                                       Nothing -> ([], [])
                        Nothing -> ([], [])
    in (uncurry (node "player")) mv_piece

-- render pieces
----------------
r_pieces : Board -> Html Msg
r_pieces board = 
    let pieces = map_board r_piece board
    in node "pieces" [] pieces

map_board : (Square -> Maybe (Html Msg)) -> Board -> List (Html Msg)
map_board f b = List.map (\r -> filter_rank f r) b |> List.concat

-- empty squares will be filtered
filter_rank : (Square -> Maybe (Html Msg)) -> Rank -> List (Html Msg)
filter_rank f r = List.filterMap (\s -> f s) r

-- render piece from square
r_piece : Square -> Maybe (Html Msg)
r_piece s = case s of
                 Occupied ps pc -> Just (r_svg ps pc)
                 Vacant ps -> Nothing

-- render svg piece
r_svg : G.Position -> Piece -> Html Msg
r_svg {x,y} piece = 
    let svgTag : String
        svgTag = case piece of
                      Black figure -> getSvgTag "b_" figure
                      White figure -> getSvgTag "w_" figure
    -- parse SVG from String
    in case parse svgTag of
            Err e -> text e
            Ok svg -> node "piece" 
                        [ style 
                            [ "left" => px (x * squareSize)
                            , "top" => px (y * squareSize)
                            ]
                        ] [svg]

r_svg2 : G.Position -> Piece -> Html Msg
r_svg2 {x,y} piece = 
    let svgTag : String
        svgTag = case piece of
                      Black figure -> getSvgTag "b_" figure
                      White figure -> getSvgTag "w_" figure
    -- parse SVG from String
    in case parse svgTag of
            Err e -> text e
            Ok svg -> node "piece" 
                        [ style 
                            [ "position" => "absolute"
                            , "top" => px (x - 32)
                            , "left" => px (y - 32)
                            ]
                        ] [svg]
-- render board
---------------
r_board : Square -> Board -> Html Msg 
r_board selected board =
    let checker = List.map (r_rank (r_square selected)) board
    in node "board" [] checker

r_rank : (Square -> Html Msg) -> Rank -> Html Msg
r_rank f r = node "rank" [] (List.map f r)

r_square : Square -> Square -> Html Msg
r_square sel sq = 
    let attrs = if sel == sq then [class "selected"] else []
    in node "square" attrs []