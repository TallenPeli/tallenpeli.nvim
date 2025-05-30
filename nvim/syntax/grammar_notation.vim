" ~/.config/nvim/syntax/grammar_notation.vim

if exists("b:current_syntax")
  finish
endif

syntax region grammarNotationComment matchgroup=grammarNotationDelimiter start=/`/ end=/`/ keepend

syntax region grammarNotationComment matchgroup=grammarNotationDelimiter start=/```/ end=/```/ keepend

syntax match grammarNotationHashComment /^#.*/
syntax match grammarNotationNonTerminal /<[^>]\+>/
syntax match grammarNotationString /"[^"]\+"/
syntax match grammarNotationPunctuation /::=/
syntax match grammarNotationPunctuation /;/
syntax match grammarNotationPunctuation /\[/
syntax match grammarNotationPunctuation /\]/
syntax match grammarNotationPunctuation /{/
syntax match grammarNotationPunctuation /}/
syntax match grammarNotationPunctuation /(/
syntax match grammarNotationPunctuation /)/
syntax match grammarNotationPunctuation /|/

highlight default link grammarNotationHashComment Constant
highlight default link grammarNotationComment Comment
highlight default link grammarNotationDelimiter Operator
highlight default link grammarNotationNonTerminal Keyword
highlight default link grammarNotationString String
highlight default link grammarNotationPunctuation Operator

let b:current_syntax = "grammar_notation"
