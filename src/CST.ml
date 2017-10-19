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

type lilypond =
  | Lilypond_Empty
  | Lilypond_Lilypond_ToplevelExpression of lilypond * toplevel_expression
  | Lilypond_Lilypond_Assignment of lilypond * assignment

 and toplevel_expression =
   | ToplevelExpression_HeaderBlock of header_block
   | ToplevelExpression_ScoreBlock of score_block

 and lilypond_header_body =
   | LilypondHeaderBody_Empty
   | LilypondHeaderBody_LilypondHeaderBody_Assignment of lilypond_header_body * assignment

 and lilypond_header =
   | LilypondHeader_LilypondHeaderBody of lilypond_header_body

 and header_block =
   | HeaderBlock_LilypondHeader of lilypond_header

 and assignment_id =
   | AssignmentId_String of string

 and assignment =
   | Assignment_AssignmentId_IdentifierInit of assignment_id * identifier_init

 and identifier_init =
   | IdentifierInit_IdentifierInitNonumber of identifier_init_nonumber

 and identifier_init_nonumber =
   | IdentifierInitNonumber_HeaderBlock of header_block
   | IdentifierInitNonumber_ScoreBlock of score_block
   | IdentifierInitNonumber_String of cstring

 and score_block =
   | ScoreBlock_ScoreBody of score_body

 and score_body =
   | ScoreBody_ScoreItems of score_items

 and score_item =
   | ScoreItem_Music of music

 and score_items =
   | ScoreItems_Empty
   | ScoreItems_ScoreItems_ScoreItem of score_items * score_item
   | ScoreItems_ScoreItems_LilypondHeader of score_items * lilypond_header

 and music_list =
   | MusicList_Empty
   | MusicList_MusicList_MusicEmbedded of music_list * music_embedded

 and braced_music_list =
   | BracedMusicList_LBRACE_MusicList_RBRACE of music_list

 and music =
   | Music_MusicAssign of music_assign
   (* | Music_LyricElementMusic of lyric_element_music *)
   (* | Music_PitchAsMusic of pitch_as_music *)

 and music_embedded =
   | MusicEmbedded_Music of music

 and music_assign =
   (* | MusicAssign_SimpleMusic of simple_music *)
   | MusicAssign_CompositeMusic of composite_music
                          
 and repeated_music =
   | RepeatedMusic_REPEAT_SimpleString_UnsignedNumber_Music of simple_string * unsigned_number * music
   | RepeatedMusic_REPEAT_SimpleString_UnsignedNumber_Music_ALTERNATIVE_BracedMusicList of simple_string * unsigned_number * music * braced_music_list

 and sequential_music =
   | SequentialMusic_SEQUENTIAL_BracedMusicList of braced_music_list
   | SequentialMusic_BracedMusicList of braced_music_list

 and simultaneous_music =
   | SimultaneousMusic_SIMULTANEOUS_BracedMusicList of braced_music_list
   | SimultaneousMusic_DLESS_MusicList_DGREAT of music_list

 and basic_music =
   | BasicMusic_RepeatedMusic of repeated_music
   | BasicMusic_MusicBare of music_bare

 and contextable_music =
   | ContextableMusic_BasicMusic of basic_music

 and composite_music =
   | CompositeMusic_BasicMusic of basic_music

 and music_bare =
   | MusicBare_MusicIdentifier of music_identifier
   | MusicBare_GroupedMusicList of grouped_music_list

 and grouped_music_list =
   | GroupedMusicList_SimultaneousMusic of simultaneous_music
   | GroupedMusicList_SequentialMusic of sequential_music

 and cstring = (* 'string' in the grammar *)
   | Cstring_String of string

 and simple_string =
   | SimpleString_STRING of string

 and unsigned_number =
   | UnsignedNumber_Unsigned
   | UnsignedNumber_NumberIdentifier
