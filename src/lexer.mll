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

}

(** This lexer is an OCaml copy of the Flex lexer in Lilypond sources:
    https://github.com/lilypond/lilypond/blob/master/lily/lexer.ll *)

let a = ['a'-'z' 'A'-'Z'] (*'\200'-'\377'*)
let aa = a | '_'
let n = ['0'-'9']
let any_char = . | '\n'
let word = a (['-' '_'] a | a)*
let command = '\\' word

(* SPECIAL category is for every letter that needs to get passed to
 * the parser rather than being redefinable by the user *)
let special = ['-' '+' '*' '/' '=' '<' '>' '{' '}' '!' '?' '_' '^' '\'' ',' '.' ':']
let shorthand = . | ('\\' .)
let unsigned = n+
let e_unsigned = '\\' n+
let fraction = n+ '/' n+
let int = '-'? unsigned
let read = (int '.' n*) | ('-'? '.' n+)
let strictreal = unsigned '.' unsigned
let white = [' ' '\n' '\t' '\f' '\r']
let horizontalwhite = [' ' '\t']
let black = [^ ' ' '\n' '\t' '\f' '\r']
let restname = ['r' 's']
let escaped = ['n' 't' '\\' '\'' '"']
let extender = "__"
let hyphen = "--"
(*let bom_utf8 = "\357\273\277"*)

rule token = parse
