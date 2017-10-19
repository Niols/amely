(******************************************************************************)
(*                                                                            *)
(*                                   Amely                                    *)
(*                                                                            *)
(*                      A library for Lilypond in OCaml                       *)
(*                Copyright (C) 2017 Nicolas "Niols" Jeannerod                *)
(*                                                                            *)
(*   This program is free software: you can redistribute it and/or modify     *)
(*   it under the terms of the GNU General Public License as published by     *)
(*   the Free Software Foundation, either version 3 of the License, or        *)
(*   (at your option) any later version.                                      *)
(*                                                                            *)
(*   This program is distributed in the hope that it will be useful,          *)
(*   but WITHOUT ANY WARRANTY; without even the implied warranty of           *)
(*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *)
(*   GNU General Public License for more details.                             *)
(*                                                                            *)
(*   You should have received a copy of the GNU General Public License        *)
(*   along with this program.  If not, see <http://www.gnu.org/licenses/>.    *)
(*                                                                            *)
(******************************************************************************)

{
  open Parser

  exception SyntaxError of int * int * string

  let newline lexbuf =
    let open Lexing in
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos_fname = pos.pos_fname ;
        pos_lnum = pos.pos_lnum + 1 ;
        pos_bol = pos.pos_cnum ;
        pos_cnum = 1 }

  let special_tokens = [
      "accepts"      , ACCEPTS ;
      "addlyrics"    , ADDLYRICS;
      "alias"        , ALIAS;
      "alternative"  , ALTERNATIVE;
      "book"         , BOOK;
      "bookpart "    , BOOKPART;
      "change"       , CHANGE;
      "chordmode"    , CHORDMODE    ;
      "chords"       , CHORDS       ;
      "consists"     , CONSISTS     ;
      "context"      , CONTEXT      ;
      "default"      , DEFAULT      ;
      "defaultchild" , DEFAULTCHILD ;
      "denies"       , DENIES      ;
      "description"  , DESCRIPTION  ;
      "drummode"     , DRUMMODE    ;
      "drums"        , DRUMS        ;
      "etc"          , ETC         ;
      "figuremode"   , FIGUREMODE;
      "figures"      , FIGURES  ;
      "header"       , HEADER    ;
      "layout"       , LAYOUT     ;
      "lyricmode"    , LYRICMODE ;
      "lyrics"       , LYRICS     ;
      "lyricsto"     , LYRICSTO  ;
      "markup"       , MARKUP      ;
      "markuplist"   , MARKUPLIST;
      "midi"         , MIDI     ;
      "name"         , NAME      ;
      "new"          , NEW        ;
      "notemode"     , NOTEMODE;
      "override"     , OVERRIDE ;
      "paper"        , PAPER    ;
      "remove"       , REMOVE  ;
      "repeat"       , REPEAT   ;
      "rest"         , REST       ;
      "revert"       , REVERT     ;
      "score"        , SCORE       ;
      "scorelines"   , SCORELINES;
      "sequential"   , SEQUENTIAL ;
      "set"          , SET    ;
      "simultaneous" , SIMULTANEOUS;
      "tempo"        , TEMPO  ;
      "type"         , TYPE    ;
      "unset"        , UNSET   ;
      "versionerror" , VERSIONERROR;
      "with"         , WITH
    ]
}

rule token = parse

(* | "\\"  { BSLASH } *)
(* | "\\!" { BSLASHEXCL } *)
(* | "\\+" { BSLASHPLUS } *)
(* | '^'   { CARET } *)
(* | ':'   { COLON } *)
(* | ','   { COMMA } *)
(* | '-'   { DASH } *)
(* | "--"  { DDASH } *)
| ">>"  { DGREAT }
| "<<"  { DLESS }
(* | '.'   { DOT } *)
(* | "__"  { DUNDERSCORE } *)
| '='   { EQUAL }
(* | '!'   { EXCL } *)
(* | '>'   { GREAT } *)
(* | "#{"  { HASHLBRACE } *)
(* | '?'   { INTER } *)
| '{'   { LBRACE }
(* | '['   { LBRACKET } *)
(* | '<'   { LESS } *)
(* | '+'   { PLUS } *)
| '}'   { LBRACE }
(* | ']'   { RBRACKET } *)
(* | '/'   { SLASH } *)
(* | "/+"  { SLASHPLUS } *)
(* | '*'   { STAR } *)
(* | '\''  { QUOTE } *)
(* | '_'   { UNDERSCORE } *)

(* | "(backed-up?)" { BACKEDUP } *)
(* | "(reparsed?)"  { REPARSED } *)
(* | "optional?"    { OPTIONAL } *)
(* | "scheme?"      { SCHEME } *)

| _ { failwith "nooooo :-(" }
