/******************************************************************************/
/*                                                                            */
/*                                   Amely                                    */
/*                                                                            */
/*                      A library for Lilypond in OCaml                       */
/*                Copyright (C) 2017 Nicolas "Niols" Jeannerod                */
/*                                                                            */
/*   This program is free software: you can redistribute it and/or modify     */
/*   it under the terms of the GNU General Public License as published by     */
/*   the Free Software Foundation, either version 3 of the License, or        */
/*   (at your option) any later version.                                      */
/*                                                                            */
/*   This program is distributed in the hope that it will be useful,          */
/*   but WITHOUT ANY WARRANTY; without even the implied warranty of           */
/*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            */
/*   GNU General Public License for more details.                             */
/*                                                                            */
/*   You should have received a copy of the GNU General Public License        */
/*   along with this program.  If not, see <http://www.gnu.org/licenses/>.    */
/*                                                                            */
/******************************************************************************/

%{
  open CST
%}

//%token BSLASH       // "\"
//%token BSLASHEXCL   // "\!"
//%token BSLASHPLUS   // "\+"
//%token CARET        // "^"
//%token COLON        // ":"
//%token COMMA        // ','
//%token DASH         // "-"
//%token DDASH        // "--"
%token DGREAT       // ">>"
%token DLESS        // "<<"
//%token DOT          // '.'
//%token DUNDERSCORE  // "__"
%token EQUAL        // '='
//%token EXCL         // '!'
//%token GREAT        // ">"
//%token HASHLBRACE   // "#{"
//%token INTER        // '?'
%token LBRACE       // '{'
//%token LBRACKET     // '['
//%token LESS         // "<"
//%token PLUS         // '+'
%token RBRACE       // '}'
//%token RBRACKET     // ']'
//%token SLASH        // "/"
//%token SLASHPLUS    // "/+"
//%token STAR         // '*'
//%token QUOTE        // '''
//%token UNDERSCORE   // "_"

//%token BACKEDUP     // "(backed-up?)"
//%token REPARSED     // "(reparsed?)"
//%token OPTIONAL     // "optional?"
//%token SCHEME       // "scheme?"

//%token ACCEPTS      // "\accepts"
//%token ADDLYRICS    // "\addlyrics"
//%token ALIAS        // "\alias"
%token ALTERNATIVE  // "\alternative"
//%token BOOK         // "\book"
//%token BOOKPART     // "\bookpart"
//%token CHANGE       // "\change"
//%token CHORDMODE    // "\chordmode"
//%token CHORDS       // "\chords"
//%token CONSISTS     // "\consists"
//%token CONTEXT      // "\context"
//%token DEFAULT      // "\default"
//%token DEFAULTCHILD // "\defaultchild"
//%token DENIES       // "\denies"
//%token DESCRIPTION  // "\description"
//%token DRUMMODE     // "\drummode"
//%token DRUMS        // "\drums"
//%token ETC          // "\etc"
//%token FIGUREMODE   // "\figuremode"
//%token FIGURES      // "\figures"
%token HEADER       // "\header"
//%token LAYOUT       // "\layout"
//%token LYRICMODE    // "\lyricmode"
//%token LYRICS       // "\lyrics"
//%token LYRICSTO     // "\lyricsto"
//%token MARKUP       // "\markup"
//%token MARKUPLIST   // "\markuplist"
//%token MIDI         // "\midi"
//%token NAME         // "\name"
//%token NEW          // "\new"
//%token NOTEMODE     // "\notemode"
//%token OVERRIDE     // "\override"
//%token PAPER        // "\paper"
//%token REMOVE       // "\remove"
%token REPEAT       // "\repeat"
//%token REST         // "\rest"
//%token REVERT       // "\revert"
%token SCORE        // "\score"
//%token SCORELINES   // "\score-lines"
%token SEQUENTIAL   // "\sequential"
//%token SET          // "\set"
%token SIMULTANEOUS // "\simultaneous"
//%token TEMPO        // "\tempo"
//%token TYPE         // "\type"
//%token UNSET        // "\unset"
%token VERSIONERROR // "\version-error"
//%token WITH         // "\with"

//%token<string> BOOK_IDENTIFIER
//%token<string> CHORD_MODIFIER
//%token<string> CHORD_REPETITION
//%token<string> COMPOSITE
//%token<string> DRUM_PITCH
//%token<string> DURATION_ARG
//%token<string> DURATION_IDENTIFIER
//%token<string> E_UNSIGNED
//%token<string> ERROR                   // error
//%token<string> EVENT_FUNCTION
//%token<string> EVENT_IDENTIFIER
//%token<string> EXPECT_NO_MORE_ARGS
//%token<string> FIGURE_CLOSE
//%token<string> FIGURE_OPEN
//%token<string> FRACTION
//%token<string> LOOKUP_IDENTIFIER
//%token<string> LYRIC_ELEMENT
//%token<string> MARKUP_FUNCTION
//%token<string> MARKUP_IDENTIFIER
//%token<string> MARKUP_LIST_FUNCTION
//%token<string> MARKUPLIST_IDENTIFIER
//%token<string> MULTI_MEASURE_REST
//%token<string> MUSIC_FUNCTION
%token<string> MUSIC_IDENTIFIER
//%token<string> NOTENAME_PITCH
%token<string> NUMBER_IDENTIFIER
//%token<string> PITCH_IDENTIFIER
//%token<string> PREC_BOT
//%token<string> PREC_TOP
//%token<string> REAL
//%token<string> RESTNAME
//%token<string> SCM_ARG
//%token<string> SCM_FUNCTION
//%token<string> SCM_IDENTIFIER
//%token<string> SCM_TOKEN
%token<string> STRING
//%token<string> SYMBOL
//%token<string> SYMBOL_LIST
//%token<string> TONICNAME_PITCH
//%token<string> UNARY_MINUS
%token<string> UNSIGNED

%start<CST.lilypond> lilypond
%%

lilypond:
| /* empty */                                          { Lilypond_Empty }
| l=lilypond te=toplevel_expression                    { Lilypond_Lilypond_ToplevelExpression (l, te) }
| l=lilypond a=assignment                              { Lilypond_Lilypond_Assignment (l, a) }
// | lilypond error
| l=lilypond VERSIONERROR                              { Lilypond_Lilypond_VERSIONERROR l }
;

toplevel_expression:
| hb=header_block                                      { ToplevelExpression_HeaderBlock hb }
// | book_block
// | bookpart_block
// | BOOK_IDENTIFIER
| sb=score_block                                       { ToplevelExpression_ScoreBlock sb }
// | composite_music
// | full_markup
// | full_markup_list
// | SCM_TOKEN
// | embedded_scm_active
// | output_def
;

lilypond_header_body:
| /* empty */                                          { LilypondHeaderBody_Empty }
| lhb=lilypond_header_body a=assignment                { LilypondHeaderBody_LilypondHeaderBody_Assignment (lhb, a) }
// | lilypond_header_body SCM_TOKEN
// | lilypond_header_body embedded_scm_active
;

lilypond_header:
| HEADER LBRACE lhb=lilypond_header_body RBRACE        { LilypondHeader_LilypondHeaderBody lhb }
;

header_block:
| lh=lilypond_header                                   { HeaderBlock_LilypondHeader lh }
;

assignment_id:
| s=STRING                                             { AssignmentId_String s }
// | SYMBOL
;

assignment:
| ai=assignment_id EQUAL ii=identifier_init            { Assignment_AssignmentId_EQUAL_IdentifierInit (ai, ii) }
// | assignment_id DOT property_path EQUAL identifier_init
// | assignment_id COMMA property_path EQUAL identifier_init
;

identifier_init:
| iin=identifier_init_nonumber                         { IdentifierInit_IdentifierInitNonumber iin }
// | number_expression
// | symbol_list_part_bare DOT property_path
// | symbol_list_part_bare COMMA property_path
// | post_event_nofinger post_events
;

identifier_init_nonumber:
| hb=header_block                                      { IdentifierInitNonumber_HeaderBlock hb }
| sb=score_block                                       { IdentifierInitNonumber_ScoreBlock sb }
// | book_block
// | bookpart_block
// | output_def
// | context_def_spec_block
// | music_assign
// | pitch_or_music
// | FRACTION
| s=cstring                                            { IdentifierInitNonumber_String s }
// | embedded_scm
// | partial_markup
// | full_markup_list
// | context_modification
// | partial_function "\etc"
;

score_block:
| SCORE LBRACE sb=score_body RBRACE                    { ScoreBlock_SCORE_LBRACE_ScoreBody_RBRACE sb }
;

score_body:
| si=score_items                                       { ScoreBody_ScoreItems si }
// | score_body error
;

score_item:
// | embedded_scm
| m=music                                              { ScoreItem_Music m }
// | output_def
;

score_items:
| /* empty */                                          { ScoreItems_Empty }
| sil=score_items si=score_item                        { ScoreItems_ScoreItems_ScoreItem (sil, si) }
| si=score_items lh=lilypond_header                    { ScoreItems_ScoreItems_LilypondHeader (si, lh) }
;

music_list:
| /* empty */                                          { MusicList_Empty }
| ml=music_list me=music_embedded                      { MusicList_MusicList_MusicEmbedded (ml, me) }
// | ml=music_list e=error
;

braced_music_list:
| LBRACE ml=music_list RBRACE                          { BracedMusicList_LBRACE_MusicList_RBRACE ml }
;

music:
| ma=music_assign                                      { Music_MusicAssign ma }
// | lyric_element_music
// | pitch_as_music
;

music_embedded:
| m=music                                              { MusicEmbedded_Music m }
// | music_embedded_backup
// | music_embedded_backup "(backed-up?)" lyric_element_music
// | multiplied_duration post_events
;

music_assign:
// | sm=simple_music                                      { MusicAssign_SimpleMusic sm }
| cm=composite_music                                   { MusicAssign_CompositeMusic cm }
;

repeated_music:
| REPEAT ss=simple_string un=unsigned_number m=music
                                                       { RepeatedMusic_REPEAT_SimpleString_UnsignedNumber_Music (ss, un, m) }
| REPEAT ss=simple_string un=unsigned_number m=music ALTERNATIVE bml=braced_music_list
                                                       { RepeatedMusic_REPEAT_SimpleString_UnsignedNumber_Music_ALTERNATIVE_BracedMusicList (ss, un, m, bml) }
;

sequential_music:
| SEQUENTIAL bml=braced_music_list                     { SequentialMusic_SEQUENTIAL_BracedMusicList bml }
| bml=braced_music_list                                { SequentialMusic_BracedMusicList bml }
;

simultaneous_music:
| SIMULTANEOUS bml=braced_music_list                   { SimultaneousMusic_SIMULTANEOUS_BracedMusicList bml }
| DLESS ml=music_list DGREAT                           { SimultaneousMusic_DLESS_MusicList_DGREAT ml }
;

basic_music:
// | music_function_call
| rm=repeated_music                                    { BasicMusic_RepeatedMusic rm }
| mb=music_bare                                        { BasicMusic_MusicBare mb }
// | "\lyricsto" simple_string lyric_mode_music
// | "\lyricsto" symbol '=' simple_string lyric_mode_music
;

composite_music:
| bm=basic_music                                       { CompositeMusic_BasicMusic bm }
// | contexted_basic_music
// | basic_music new_lyrics
;

music_bare:
// | mode_changed_music
| mi=MUSIC_IDENTIFIER                                  { MusicBare_MusicIdentifier mi }
| gml=grouped_music_list                               { MusicBare_GroupedMusicList gml }
;

grouped_music_list:
| sm=simultaneous_music                                { GroupedMusicList_SimultaneousMusic sm }
| sm=sequential_music                                  { GroupedMusicList_SequentialMusic sm }
;

cstring:
| s=STRING                                             { String_String s }
// | s=SYMBOL
// | full_markup
;

simple_string:
| s=STRING                                             { SimpleString_STRING s }
// | SYMBOL
// | embedded_scm_bare
;

unsigned_number:
| u=UNSIGNED                                           { UnsignedNumber_UNSIGNED u }
| ni=NUMBER_IDENTIFIER                                 { UnsignedNumber_NUMBERIDENTIFIER ni }
// | embedded_scm
;