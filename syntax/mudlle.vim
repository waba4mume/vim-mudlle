" Vim syntax file
" Language: Mudlle
" Maintainer:   Thomas Equeter <waba@waba.be>
" Updaters: 
" URL:      
" Changes:  
" Last Change:  2016-06-xx

" Tricks used in this file:
" - The wrapping region: it is usually transparent, has an empty end pattern
"   and a contains list. It serves as a specific wrapper for the contained generic
"   item, for example to name it as part of a syntax chain.
" - Syntax chain: a set of nextgroup-chained items, usually with skipwhite and
"   skipempty. All items except the first are contained, to enforce the nextgroup.
"   It expresses a syntax sequence in a more radable form than a long regexp.

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'mudlle'
endif

syn case ignore

syn keyword mudlleCommentTodo       TODO FIXME XXX TBD contained
syn match   mudlleLineComment       "\/\/.*" contains=@Spell,mudlleCommentTodo
syn region  mudlleComment           start="/\*"  end="\*/" contains=@Spell,mudlleCommentTodo,mudlleComment

" Files starting with ** are meant to be ignored at boot
syn match   mudlleDoNotLoad         /\v%^\*\*.*/

syn match   mudlleSpecial           "\\." contained
syn match   mudlleFnHelpVar         /\v`\k+/hs=s+1 contained
syn region  mudlleString            start=/"/  skip=/\v\\%(\\|"|\n)/  end=/\v"|$/  contains=mudlleSpecial,mudlleFnHelpVar

syn match   mudlleNumber            "-\?\<\d\+\>"
" A lone ?x is C's 'x'. x may also be a \-sequence like \r
syn match   mudlleCharacter         /\v\k@<!\?\\?.\k@!/hs=s+1

" Highlight keywords in the module header, only if they are used in the correct
" order and with no stray comma.
syn match   mudlleModModule         /\v^module\s+\k+/he=s+6 nextgroup=mudlleModRequiresM,mudlleModReads,mudlleModWrites,mudlleModStatic skipwhite skipempty
syn match   mudlleModLibrary        /\v^library\s+\k+/he=s+7 nextgroup=mudlleModRequiresL,mudlleModDefines skipwhite skipempty
syn region  mudlleModRequiresM      start=/^requires/ end=// nextgroup=mudlleModReads,mudlleModWrites,mudlleModStatic skipwhite skipempty contained contains=mudlleModRequires transparent
syn region  mudlleModRequiresL      start=/^requires/ end=// nextgroup=mudlleModDefines skipwhite skipempty contained contains=mudlleModRequires transparent
syn match   mudlleModRequires       /\v^requires\_s+%(\k+,\_s+)*\k+/he=s+8 contained
syn match   mudlleModDefines        /\v^defines\_s+%(\k+,\_s+)*\k+/he=s+7 nextgroup=mudlleModReads,mudlleModWrites,mudlleModStatic skipwhite skipempty contained
syn match   mudlleModReads          /\v^reads\_s+%(\k+,\_s+)*\k+/he=s+5 nextgroup=mudlleModWrites,mudlleModStatic skipwhite skipempty contained
syn match   mudlleModWrites         /\v^writes\_s+%(\k+,\_s+)*\k+/he=s+6 nextgroup=mudlleModStatic skipwhite skipempty contained
syn match   mudlleModStatic         /\v^static\_s+%(\k+,\_s+)*\k+/he=s+6 contained

syn match   mudlleStatement         "exit\(<[\w?!]\+>\)\?"
syn keyword mudlleConditional       if else
syn keyword mudlleRepeat            for while loop
syn keyword mudlleMatch             match
syn keyword mudlleBoolean           true false
syn keyword mudlleNull              null
syn keyword mudlleGlobal            actor
syn keyword mudlleType              int string table vector list null character object contained

syn keyword mudlleFunction          fn nextgroup=mudlleFunctionHelpStr,mudlleFunctionArgs skipwhite skipempty
syn region  mudlleFunctionHelpStr   start=/"/ end=// transparent contains=mudlleString contained nextgroup=mudlleFunctionArgs skipwhite skipempty
syn match   mudlleFunctionArgs      /\v%(\k+|\(\_[^)]*\))/ contains=mudlleType contained nextgroup=mudlleFunctionBraces skipwhite skipempty
syn region  mudlleFunctionBraces    start=/\[/ end=// transparent contains=mudlleBracesReg contained fold
syn region  mudlleBracesReg         matchgroup=mudlleBraces start=/\[/ end=/\]/ contains=TOP

syn sync fromstart
syn sync maxlines=100

if main_syntax == "mudlle"
  syn sync ccomment mudlleComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_mudlle_syn_inits")
  if version < 508
    let did_mudlle_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink mudlleComment          Comment
  HiLink mudlleLineComment      Comment
  HiLink mudlleCommentTodo      Todo
  HiLink mudlleSpecial          Special
  HiLink mudlleString           String
  HiLink mudlleCharacter        Character
  HiLink mudlleNumber           String
  HiLink mudlleConditional      Conditional
  HiLink mudlleRepeat           Repeat
  HiLink mudlleBranch           Conditional
  HiLink mudlleOperator         Operator
  HiLink mudlleType             Type
  HiLink mudlleStatement        Statement
  HiLink mudlleFunction         Function
  HiLink mudlleBraces           Function
  HiLink mudlleDoNotLoad        Error
  HiLink mudlleNull             Keyword
  HiLink mudlleBoolean          Boolean

  HiLink mudlleFnHelpVar        Identifier
  HiLink mudlleLabel            Label
  HiLink mudlleException        Exception
  HiLink mudlleMessage          Keyword
  HiLink mudlleGlobal           Keyword
  HiLink mudlleMember           Keyword
  HiLink mudlleModModule        Keyword
  HiLink mudlleModLibrary       Keyword
  HiLink mudlleModRequires      Keyword
  HiLink mudlleModDefines       Keyword
  HiLink mudlleModReads         Keyword
  HiLink mudlleModWrites        Keyword
  HiLink mudlleModStatic        Keyword
  HiLink mudlleDeprecated       Exception 
  HiLink mudlleReserved         Keyword
  HiLink mudlleDebug            Debug
  HiLink mudlleConstant         Label

  delcommand HiLink
endif

let b:current_syntax = "mudlle"
if main_syntax == 'mudlle'
  unlet main_syntax
endif

" vim: ts=8
