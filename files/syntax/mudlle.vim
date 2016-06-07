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
syn match   mudlleCommentSkip       "^[ \t]*\*\($\|[ \t]\+\)"
syn region  mudlleComment           start="/\*"  end="\*/" contains=@Spell,mudlleCommentTodo
syn match   mudlleSpecial           "\\."
syn region  mudlleStringD           start=+"+  skip=+\\\\\|\\"+  end=+"\|$+  contains=mudlleSpecial,@htmlPreproc
"syn match   mudlleLabel             start="<" end=">"
syn match   mudlleNumber            "-\?\<\d\+\>"
syn match   mudlleStatement         "exit\(<[\w?!]\+>\)\?"

syn keyword mudlleConditional       if else
syn keyword mudlleRepeat            while loop
"syn keyword mudlleBranch            break continue
"syn keyword mudlleOperator          new delete instanceof typeof
"syn keyword mudlleType              Array Boolean Date Function Number Object String RegExp
"syn keyword mudlleStatement         exit
syn keyword mudlleBoolean           true false
syn keyword mudlleNull              null NULL
"syn keyword mudlleIdentifier        actor
"syn keyword mudlleLabel             case default
"syn keyword mudlleException         try catch finally throw
"syn keyword mudlleMessage           alert confirm prompt status
syn keyword mudlleGlobal            actor
"syn keyword mudlleMember            document event location 
"syn keyword mudlleDeprecated        escape unescape
"syn keyword mudlleReserved          abstract boolean byte char class const debugger double enum export extends final float goto implements import int interface long native package private protected public short static super synchronized throws transient volatile 

syn keyword mudlleFunction          fn
syn match   mudlleBraces            "[\[\]]"
syn match   mudlleParens            "[()]"

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
