" Vim syntax file
" Language: Mudlle
" Maintainer:   Thomas Equeter <waba@waba.be>
" Updaters: 
" URL:      
" Changes:  
" Last Change:  2011-05-06

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
syn region  mudlleStringD           start=+"+  skip=+\\\\\|\\"+  end=+"\|$+  contains=mudlleSpecial

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

" is a match (not a kw) to be lower priority than mudlleFunctionReg
syn match   mudlleFunction          /\v<fn>/
syn region  mudlleBraces            start=/\[/ end=/\]/ contains=ALL
syn region  mudlleFunctionReg       start=/\v<fn\_s+%("%(\\"|[^"])*")?\_s*%(\i+|\([^)]*\))\_s*\[/rs=s+2 end=/\z1\]/ fold transparent contains=ALL

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
  HiLink mudlleStringD          String
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
