" Candy Colorscheme
"
" Hex colour conversion functions borrowed from the theme 'Desert256'"

" Colors
let s:foreground = "4f4f4f"
let s:background = "f9f9f9"

let s:blue = "4271ae"
let s:lightblue = "b5d5ff"
let s:aqua = "3e999f"

let s:grey = '808080'
let s:lightgrey = "cccccc"
let s:verylightgrey = "efefef"

let s:red = "d70000"
let s:lightred = "ff6155"
let s:orange = "f5871f"

let s:yellow = "ffff55"
let s:gold = "e2b100"

let s:purple = "8959a8"
let s:brown = "6d5e30"
let s:green = "718c00"

set background=light
hi clear
syntax reset

let g:colors_name = "candy"


if has("gui_running") || &t_Co == 88 || &t_Co == 256

    " Color conversion functions {{{

	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)  " {{{
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun  " }}}

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)  " {{{
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun  " }}}

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)  " {{{
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun  " }}}

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)  " {{{
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun  " }}}

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)  " {{{
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun  " }}}

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)  " {{{
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun  " }}}

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)  " {{{
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun  " }}}

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)  " {{{
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun  " }}}

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)  " {{{
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun  " }}}

    " }}}

	" Vim Highlighting
	call <SID>X("Normal", s:foreground, s:background, "")
    highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=#cccccc guibg=NONE
	call <SID>X("NonText", s:blue, "", "")
	call <SID>X("SpecialKey", s:lightgrey, "", "")
	call <SID>X("Search", "", s:yellow, "")
	call <SID>X("IncSearch", s:yellow, s:foreground, "")
	call <SID>X("StatusLine", s:blue, s:verylightgrey, "none")
	call <SID>X("StatusLineNC", s:verylightgrey, s:lightgrey, "reverse")
    call <SID>X("StlErr", s:lightred, s:verylightgrey, "")
	call <SID>X("StlFname", s:blue, s:verylightgrey, "bold")
	call <SID>X("VertSplit", s:blue, s:background, "none")
	call <SID>X("Visual", "", s:lightblue, "")
	call <SID>X("Directory", s:purple, "", "")
	call <SID>X("ModeMsg", s:green, "", "")
	call <SID>X("MoreMsg", s:green, "", "")
	call <SID>X("Question", s:green, "", "")
	call <SID>X("WarningMsg", s:lightred, s:background, "")
	call <SID>X("MatchParen", "", s:lightblue, "")
	call <SID>X("Folded", s:lightgrey, s:background, "")
	call <SID>X("FoldColumn", "", s:background, "")
	call <SID>X("Cursor", s:background, s:lightred, "")
	call <SID>X("ErrorMsg", s:red, s:background, "")
	call <SID>X("WildMenu", s:blue, s:lightblue, "")
	call <SID>X("SignColumn", "", s:background, "")
	call <SID>X("SignErr", s:red, s:background, "")
	call <SID>X("SignWrn", s:orange, s:background, "")
	if version >= 700
		call <SID>X("CursorLine", "", s:verylightgrey, "none")
		call <SID>X("CursorColumn", "", s:verylightgrey, "none")
		call <SID>X("PMenu", s:blue, s:lightblue, "none")
		call <SID>X("PMenuSel", s:lightblue, s:blue, "none")
		call <SID>X("PMenuSBar", s:grey, s:grey, "none")
		call <SID>X("PMenuThumb", s:grey, s:lightgrey, "none")
		call <SID>X("TabLine", s:grey, s:verylightgrey, "none")
		call <SID>X("TabLineSel", s:background, s:lightblue, "none")
		call <SID>X("TabLineFill", s:lightgrey, s:verylightgrey,"none")
    end
	if version >= 703
		call <SID>X("ColorColumn", "", s:verylightgrey, "none")
		call <SID>X("Conceal", s:verylightgrey, "", "")
	end

	" Standard Language Highlighting
	call <SID>X("Comment", s:lightgrey, "", "")
	call <SID>X("Todo", s:grey, s:verylightgrey, "")
	call <SID>X("Statement", s:blue, "", "none")
	call <SID>X("Identifier", s:foreground, "", "none")
	call <SID>X("Conditional", s:purple, "", "")
	call <SID>X("Repeat", s:orange, "", "")
	call <SID>X("Function", s:blue, "", "")
	call <SID>X("Constant", s:gold, "", "")
	call <SID>X("Number", s:grey, "", "")
	call <SID>X("String", s:green, "", "")
	call <SID>X("Character", s:green, "", "")
	call <SID>X("Operator", s:aqua, "", "none")
	call <SID>X("Type", s:aqua, "", "none")
	call <SID>X("Exception", s:red, "", "")
	call <SID>X("Keyword", s:foreground, "", "")
	call <SID>X("Title", s:foreground, "", "bold")
	call <SID>X("Structure", s:foreground, "", "")
	call <SID>X("Special", s:grey, "", "")
	call <SID>X("PreProc", s:purple, "", "")
	call <SID>X("Define", s:purple, "", "none")
	call <SID>X("Include", s:orange, "", "")

	" Python Highlighting
	call <SID>X("pythonFunction", s:foreground, "", "")
	call <SID>X("pythonPreCondit", s:orange, "", "")

	" Go Highlighting
	call <SID>X("goDirective", s:orange, "", "")
	call <SID>X("goGoroutine", s:red, "", "")
	call <SID>X("goSpecial", s:red, "", "")
	call <SID>X("goDeclaration", s:blue, "", "")
	call <SID>X("goFunction", s:foreground, "", "underline")
	call <SID>X("goConstants", s:grey, "", "")

	" Vim Highlighting
	call <SID>X("vimCommand", s:red, "", "none")

	" C Highlighting
	call <SID>X("cType", s:gold, "", "")
	call <SID>X("cStorageClass", s:purple, "", "")
	call <SID>X("cConditional", s:purple, "", "")
	call <SID>X("cRepeat", s:purple, "", "")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:green, "", "")
	call <SID>X("rubyConstant", s:gold, "", "")
	call <SID>X("rubyAttribute", s:blue, "", "")
	call <SID>X("rubyInclude", s:blue, "", "")
	call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
	call <SID>X("rubyCurlyBlock", s:orange, "", "")
	call <SID>X("rubyStringDelimiter", s:green, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
	call <SID>X("rubyConditional", s:purple, "", "")
	call <SID>X("rubyRepeat", s:purple, "", "")

	" Java Highlighting
	call <SID>X("javaFuncDef", s:blue, "", "")
	call <SID>X("javaExternal", s:red, "", "")
	call <SID>X("javaConditional", s:purple, "", "")
	call <SID>X("javaRepeat", s:orange, "", "")
	call <SID>X("javaExceptions", s:red, "", "")
	call <SID>X("javaTypedef", s:grey, "", "")
	call <SID>X("javaType", s:aqua, "", "")
	call <SID>X("javaStorageClass", s:blue, "", "")
	call <SID>X("javaOperator", s:red, "", "")
	call <SID>X("javaStatement", s:purple, "", "")
	call <SID>X("javaConstant", s:grey, "", "")
	call <SID>X("javaGLType", s:grey, "", "")

    " reST highlighting
	call <SID>X("rstEmphasis", s:aqua, "", "")    
	call <SID>X("rstStrongEmphasis", s:aqua, "", "")    
	call <SID>X("rstLiteralBlock", s:purple, "", "")    
	call <SID>X("rstLiteralBlock", s:purple, "", "")    
	call <SID>X("rstInlineLiteral", s:purple, "", "")    
	call <SID>X("rstBulletedList", s:red, "", "")    
	call <SID>X("rstFieldList", s:red, "", "")    

	" JavaScript Highlighting
	call <SID>X("javaScriptBraces", s:foreground, "", "")
	call <SID>X("javaScriptFunction", s:purple, "", "")
	call <SID>X("javaScriptConditional", s:purple, "", "")
	call <SID>X("javaScriptRepeat", s:purple, "", "")
	call <SID>X("javaScriptNumber", s:orange, "", "")
	call <SID>X("javaScriptMember", s:orange, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:red, "", "")
	call <SID>X("htmlTagName", s:red, "", "")
	call <SID>X("htmlArg", s:red, "", "")
	call <SID>X("htmlScriptTag", s:red, "", "")

	" Diff Highlighting
	call <SID>X("diffAdded", s:green, "", "")
	call <SID>X("diffRemoved", s:red, "", "")

	" Delete Functions {{{
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
    " }}}
endif
