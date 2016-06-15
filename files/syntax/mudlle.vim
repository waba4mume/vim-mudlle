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

syn keyword mudlleCommentTodo       TODO FIXME XXX TBD contained
syn match   mudlleLineComment       "\/\/.*" contains=@Spell,mudlleCommentTodo
syn region  mudlleComment           start="/\*"  end="\*/" contains=@Spell,mudlleCommentTodo,mudlleComment

syn match   mudlleSpecial           "\\."
syn region  mudlleString            start=+"+  skip=+\\\\\|\\"+  end=+"\|$+  contains=mudlleSpecial

syn match   mudlleNumber            "-\?\<\d\+\>"
syn match   mudlleCharacter         /\v\i@<!\?.\i@!/hs=s+1

" Highlight keywords in the module header, only if they are used in the correct
" order and with no stray comma.
syn match   mudlleModule            /\v^module\s+\i+\_s+%(^requires\_s+%(\i+,\_s+)*\i{-}\_s+)?%(^reads\_s+%(\i+,\_s+)*\i{-}\_s+)?%(^writes\_s+%(\i+,\_s+)*\i{-}\_s+)?%(^static\_s+%(\i+,\_s+)*\i{-}\_s+)?/ contains=mudlleModKeyword transparent
syn match   mudlleLibrary           /\v^library\s+\i+\_s+%(^requires\_s+%(\i+,\_s+)*\i{-}\_s+)?^defines\_s+%(\i+,\_s+)*\i{-}\_s+%(^reads\_s+%(\i+,\_s+)*\i{-}\_s+)?%(^writes\_s+%(\i+,\_s+)*\i{-}\_s+)?%(^static\_s+%(\i+,\_s+)*\i{-}\_s+)?/ contains=mudlleModKeyword transparent
syn keyword mudlleModKeyword        module library requires defines reads writes static contained

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
syn match   mudlleFunctionArgs      /\v%(\i+|\(\_[^)]*\))/ contains=mudlleType contained nextgroup=mudlleFunctionBraces skipwhite skipempty
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
  HiLink mudlleError            Error
  HiLink mudlleNull             Keyword
  HiLink mudlleBoolean          Boolean

  HiLink mudlleIdentifier       Identifier
  HiLink mudlleLabel            Label
  HiLink mudlleException        Exception
  HiLink mudlleMessage          Keyword
  HiLink mudlleGlobal           Keyword
  HiLink mudlleMember           Keyword
  HiLink mudlleModKeyword       Keyword
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
