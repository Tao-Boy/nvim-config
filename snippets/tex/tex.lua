local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex = require("utils.functions")

local math_symbols = {
	s(
		{ trig = "...", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\dots") },
		{ condition = tex.in_tex_mathzone }
	),
	s({
		trig = "c.",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\cdot") }, { condition = tex.in_tex_mathzone }),
	s({
		trig = "o.",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\odot") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "\\cdot.", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\cdots") },
		{ condition = tex.in_tex_mathzone }
	),
	s({
		trig = "v.",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\vdot") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "\\vdot.", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\vdots") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Equality and inequality
	s({
		trig = "!=",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\neq") }, { condition = tex.in_tex_mathzone }),
	s({
		trig = "==",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("&=") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "~=", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\approx") },
		{ condition = tex.in_tex_mathzone }
	),
	s({
		trig = "~~",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\sim") }, { condition = tex.in_tex_mathzone }),
	s({
		trig = ">=",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\geq") }, { condition = tex.in_tex_mathzone }),
	s({
		trig = "<=",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\leq") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "\\leq=", wordTrig = false, snippetType = "autosnippet" },
		{ t("&\\leq") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "\\geq=", wordTrig = false, snippetType = "autosnippet" },
		{ t("&\\geq") },
		{ condition = tex.in_tex_mathzone }
	),
	s({
		trig = ">>",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\gg") }, { condition = tex.in_tex_mathzone }),
	s({
		trig = "<<",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\ll") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "eqv", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\equiv") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Logic symbols
	s({
		trig = "iff",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\iff") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "=>", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\implies") },
		{ condition = tex.in_tex_mathzone }
	),
	s({
		trig = "inn",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\in") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "notin", wordTrig = false, snippetType = "autosnippet" },
		{ t("not\\in") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "aa", wordTrig = true, snippetType = "autosnippet" },
		{ t("\\forall") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "ee", wordTrig = true, snippetType = "autosnippet" },
		{ t("\\exists") },
		{ condition = tex.in_tex_mathzone }
	),
	s({
		trig = "land",
		snippetType = "autosnippet",
	}, { t("\\land") }, { condition = tex.in_tex_mathzone }),
	s({
		trig = "lor",
		snippetType = "autosnippet",
	}, { t("\\lor") }, { condition = tex.in_tex_mathzone }),

	-- Arrows
	s({
		trig = "to",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\to") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "mto", wordTrig = false, snippetType = "autosnippet", priority = 1001 },
		{ t("\\mapsto") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "get", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\gets") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "up", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\uparrow") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "down", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\downarrow") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Set operations
	s(
		{ trig = "\\\\\\", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\setminus") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "mid", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mid") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "cap", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\cap") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "cup", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\cup") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "sub", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\subset") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "emp", snippetType = "autosnippet", priority = 2000 },
		{ t("\\emptyset") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Binary operations
	s(
		{ trig = "+-", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\pm") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "-+", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mp") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "xx", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\times") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "cir", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\circ") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "ot", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\otimes") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "op", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\oplus") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "<>", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\diamond") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Superscripts and subscripts
	s({ trig = "sr", wordTrig = false, snippetType = "autosnippet" }, { t("^2") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "cb", wordTrig = false, snippetType = "autosnippet" }, { t("^3") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "inv", wordTrig = false, snippetType = "autosnippet" },
		{ t("^{-1}") },
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "**", wordTrig = false, snippetType = "autosnippet" }, { t("^*") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "tp", wordTrig = false, snippetType = "autosnippet" },
		{ t("^\\top") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "dr", wordTrig = false, snippetType = "autosnippet" },
		{ t("^\\dagger") },
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "cc", snippetType = "autosnippet" }, { t("^c") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "++", snippetType = "autosnippet" }, { t("^+") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "--", snippetType = "autosnippet", priority = 2000 }, { t("^-") }, { condition = tex.in_tex_mathzone }),

	-- Other symbols
	s(
		{ trig = "oo", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\infty") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "perp", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\perp") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "hbar", wordTrig = false, snippetType = "autosnippet", priority = 1500 },
		{ t("\\hbar") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "ell", wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		{ t("\\ell") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "ns", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\unlhd") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "not", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		{ t("\\not") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "par", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		{ t("\\partial") },
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "nabla", snippetType = "autosnippet" }, { t("\\nabla") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "neg", snippetType = "autosnippet" }, { t("\\neg") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "po", snippetType = "autosnippet" }, { t("\\propto") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "##", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\#") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Integrals
	s({ trig = "ii", snippetType = "autosnippet" }, { t("\\int") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "oii", snippetType = "autosnippet", priority = 2000 },
		{ t("\\oint") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Text in math
	s(
		{ trig = "lhs", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mathrm{L.H.S}") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "rhs", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mathrm{R.H.S}") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Positional snippets
	s(
		{ trig = "b|", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\Big|_{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "jk", wordTrig = false, snippetType = "autosnippet" },
		fmta("_{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "kj", wordTrig = false, snippetType = "autosnippet" },
		fmta("^{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
}

local greek_letters = {
	-- Alpha
	s(
		{ trig = ";A", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Alpha") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = ";a", snippetType = "autosnippet", wordTrig = false },
		{ t("\\alpha") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Beta
	s(
		{ trig = ";b", snippetType = "autosnippet", wordTrig = false },
		{ t("\\beta") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = ";B", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Beta") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Gamma
	s(
		{ trig = ";g", snippetType = "autosnippet", wordTrig = false },
		{ t("\\gamma") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = ";G", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Gamma") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Delta
	s(
		{ trig = ";d", snippetType = "autosnippet", wordTrig = false },
		{ t("\\delta") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = ";D", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Delta") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Epsilon
	s(
		{ trig = "eps", snippetType = "autosnippet", wordTrig = false },
		{ t("\\epsilon") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "vps", snippetType = "autosnippet", wordTrig = false },
		{ t("\\varepsilon") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Eps", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Epsilon") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Zeta
	s(
		{ trig = ";z", snippetType = "autosnippet", wordTrig = false },
		{ t("\\zeta") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = ";Z", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Zeta") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Eta
	s(
		{ trig = "eta", snippetType = "autosnippet", wordTrig = false },
		{ t("\\eta") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Eta", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Eta") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Theta
	s(
		{ trig = ";t", snippetType = "autosnippet", wordTrig = false },
		{ t("\\theta") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = ";T", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Theta") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Iota
	s(
		{ trig = "iot", snippetType = "autosnippet", wordTrig = false },
		{ t("\\iota") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Iot", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Iota") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Kappa
	s(
		{ trig = "kap", snippetType = "autosnippet", wordTrig = false },
		{ t("\\kappa") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Kap", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Kappa") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Lambda
	s(
		{ trig = "lam", snippetType = "autosnippet", wordTrig = false },
		{ t("\\lambda") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Lam", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Lambda") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Mu
	s(
		{ trig = "mu", snippetType = "autosnippet", wordTrig = false },
		{ t("\\mu") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Mu", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Mu") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Nu
	s(
		{ trig = "nu", snippetType = "autosnippet", wordTrig = false },
		{ t("\\nu") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Nu", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Nu") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Pi
	s(
		{ trig = "pi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\pi") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "\\pii", snippetType = "autosnippet", wordTrig = false, priority = 2000 },
		{ t("p_i") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Pi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Pi") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Rho
	s(
		{ trig = "rho", snippetType = "autosnippet", wordTrig = false },
		{ t("\\rho") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Rho", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Rho") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Sigma
	s(
		{ trig = "sig", snippetType = "autosnippet", wordTrig = false },
		{ t("\\sigma") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Sig", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Sigma") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Tau
	s(
		{ trig = "tau", snippetType = "autosnippet", wordTrig = false },
		{ t("\\tau") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Tau", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Tau") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Upsilon
	s(
		{ trig = "ups", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ups") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Ups", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Ups") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Phi
	s(
		{ trig = "phi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\phi") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Phi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Phi") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "vhi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\varphi") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Vhi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Varphi") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Chi
	s(
		{ trig = "chi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\chi") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Chi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Chi") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Psi
	s(
		{ trig = "psi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\psi") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Psi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Psi") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Omega
	s(
		{ trig = "ome", snippetType = "autosnippet", wordTrig = false },
		{ t("\\omega") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "Ome", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Omega") },
		{ condition = tex.in_tex_mathzone }
	),
}

local math_fonts = {
	-- Math font styles
	s(
		{ trig = "msf", snippetType = "autosnippet" },
		fmta("\\mathsf{<>}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "bm", snippetType = "autosnippet" },
		fmta("\\bm{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "bf", snippetType = "autosnippet" },
		fmta("\\mathbf{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "cal", snippetType = "autosnippet" },
		fmta("\\mathcal{<>}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "scr", snippetType = "autosnippet" },
		fmta("\\mathscr{<>}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "mbb", snippetType = "autosnippet" },
		fmta("\\mathbb{<>}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "mrm", snippetType = "autosnippet" },
		fmta("\\mathrm{<>}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Text font styles
	s({ trig = "tit", snippetType = "autosnippet" }, fmta("\\textit{<>}", { i(0) }), {}),

	s({ trig = "ttt", snippetType = "autosnippet" }, fmta("\\texttt{<>}", { i(0) }), {}),

	s({ trig = "tbf", snippetType = "autosnippet" }, fmta("\\textbf{<>}", { i(0) }), {}),

	s({ trig = "eph", snippetType = "autosnippet" }, fmta("\\emph{<>}", { i(0) }), {}),

	-- Math calligraphic letters (temporary.lua)
	s(
		{ trig = "PP", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{P}") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "SS", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{S}") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "LL", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{L}") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "FF", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathscr{F}") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "IS", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{IS}") },
		{ condition = tex.in_tex_mathzone }
	),
}

local math_commands = {
	-- Trigonometric functions
	s({ trig = "sin", snippetType = "autosnippet" }, { t("\\sin") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "asin", snippetType = "autosnippet" }, { t("\\arcsin") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "cos", snippetType = "autosnippet" }, { t("\\cos") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "acos", snippetType = "autosnippet" }, { t("\\arccos") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "tan", snippetType = "autosnippet" }, { t("\\tan") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "atan", snippetType = "autosnippet" }, { t("\\arctan") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "cot", snippetType = "autosnippet" }, { t("\\cot") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "acot", snippetType = "autosnippet" }, { t("\\arccot") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "csc", snippetType = "autosnippet" }, { t("\\csc") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "acsc", snippetType = "autosnippet" }, { t("\\arccsc") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "sec", snippetType = "autosnippet" }, { t("\\sec") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "asec", snippetType = "autosnippet" }, { t("\\arcsec") }, { condition = tex.in_tex_mathzone }),

	-- Logarithms and exponentials
	s({ trig = "log", snippetType = "autosnippet" }, { t("\\log") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "ln", snippetType = "autosnippet" }, { t("\\ln") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "exp", snippetType = "autosnippet" }, { t("\\exp") }, { condition = tex.in_tex_mathzone }),

	-- Vector calculus
	s({ trig = "grad", snippetType = "autosnippet" }, { t("\\grad") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "curl", snippetType = "autosnippet" }, { t("\\curl") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "div", snippetType = "autosnippet" }, { t("\\div") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "lap", snippetType = "autosnippet" }, { t("\\laplacian") }, { condition = tex.in_tex_mathzone }),

	-- Blackboard bold
	s({ trig = "bbr", snippetType = "autosnippet" }, { t("\\mathbb{R}") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "bbq", snippetType = "autosnippet" }, { t("\\mathbb{Q}") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "bbh", snippetType = "autosnippet" }, { t("\\mathbb{H}") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "bbc", snippetType = "autosnippet" }, { t("\\mathbb{C}") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "bbz", snippetType = "autosnippet" }, { t("\\mathbb{Z}") }, { condition = tex.in_tex_mathzone }),
	s({ trig = "bbn", snippetType = "autosnippet" }, { t("\\mathbb{N}") }, { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "bb1", snippetType = "autosnippet", priority = 2000 },
		{ t("\\mathbbm{1}") },
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "bbe", snippetType = "autosnippet" }, { t("\\mathbb{E}") }, { condition = tex.in_tex_mathzone }),

	s(
		{ trig = "bb(%w)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\mathbb{<>}", {
			f(function(_, snip)
				return string.upper(snip.captures[1])
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Convolution
	s({ trig = "cv", snippetType = "autosnippet" }, fmta("\\conv", {}), { condition = tex.in_tex_mathzone }),

	-- Accents and decorations
	s({ trig = "bar", snippetType = "autosnippet" }, fmta("\\bar{<>}", { i(1) }), { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "(%a)bar", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\overline{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "ob", snippetType = "autosnippet" },
		fmta("\\overbrace{<>}^{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	s({ trig = "td", snippetType = "autosnippet" }, fmta("\\tilde{<>}", { i(1) }), { condition = tex.in_tex_mathzone }),

	s(
		{ trig = "(\\%a+)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\tilde{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "(%a)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\tilde{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s({ trig = "dot", snippetType = "autosnippet" }, fmta("\\dot{<>}", { i(1) }), { condition = tex.in_tex_mathzone }),

	s(
		{ trig = "doo", snippetType = "autosnippet", priority = 2000 },
		fmta("\\ddot{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s({ trig = "hat", snippetType = "autosnippet" }, fmta("\\hat{<>}", { i(1) }), { condition = tex.in_tex_mathzone }),

	s({ trig = "vec", snippetType = "autosnippet" }, fmta("\\vec{<>}", { i(1) }), { condition = tex.in_tex_mathzone }),

	s(
		{ trig = "ring", snippetType = "autosnippet", priority = 2000 },
		fmta("\\mathring{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "ub", snippetType = "autosnippet", priority = 2000 },
		fmta("\\underbrace{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Vector packages
	s(
		{ trig = "vb", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\vb{"), i(1), t("}") }),
			sn(nil, { t("\\vb*{"), i(1), t("}") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "vu", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\vu{"), i(1), t("}") }),
			sn(nil, { t("\\vu*{"), i(1), t("}") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Operators
	s(
		{ trig = "kk", snippetType = "autosnippet" },
		fmta("\\operatorname{ker}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "deg", snippetType = "autosnippet" },
		fmta("\\operatorname{deg}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "spp", snippetType = "autosnippet" },
		fmta("\\operatorname{supp}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "imm", snippetType = "autosnippet" },
		fmta("\\operatorname{im}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "tr", snippetType = "autosnippet" }, fmta("\\tr", {}), { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "span", snippetType = "autosnippet" },
		fmta("\\operatorname{span}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "aut", snippetType = "autosnippet" }, fmta("\\Aut", {}), { condition = tex.in_tex_mathzone }),
	s({ trig = "gal", snippetType = "autosnippet" }, fmta("\\Gal", {}), { condition = tex.in_tex_mathzone }),
	s({ trig = "rank", snippetType = "autosnippet" }, fmta("\\rank", {}), { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "dim", snippetType = "autosnippet" },
		fmta("\\operatorname{dim}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "det", snippetType = "autosnippet" },
		fmta("\\operatorname{det}", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "vol", snippetType = "autosnippet" }, fmta("\\Vol", {}), { condition = tex.in_tex_mathzone }),

	-- Arrows with labels
	s(
		{ trig = "->", snippetType = "autosnippet" },
		fmta("\\xlongrightarrow{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "<-", snippetType = "autosnippet" },
		fmta("\\xlongleftarrow{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "--", snippetType = "autosnippet" },
		fmta("\\longleftrightarrow", {}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Min/Max
	s({ trig = "min", snippetType = "autosnippet" }, fmta("\\min", {}), { condition = tex.in_tex_mathzone }),
	s({ trig = "max", snippetType = "autosnippet" }, fmta("\\max", {}), { condition = tex.in_tex_mathzone }),
	s(
		{ trig = "sup", snippetType = "autosnippet", priority = 2000 },
		fmta("\\sup", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "inf", snippetType = "autosnippet", priority = 2000 },
		fmta("\\inf", {}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Fractions
	s(
		{ trig = "//", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Differential
	s({ trig = "dd", snippetType = "autosnippet" }, fmta("\\d ", {}), { condition = tex.in_tex_mathzone }),

	-- Square root
	s(
		{ trig = "sq", wordTrig = false, snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\sqrt{"), i(1), t("}") }),
			sn(nil, { t("\\sqrt["), i(1), t("]{"), i(2), t("}") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Modulo
	s(
		{ trig = "mod", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\mod{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "bmod", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bmod{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "nmod", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\nmod{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "pmod", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\pmod{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- SI units
	s(
		{ trig = "SI", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\SI{<>}{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "cond", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\cond(<>)", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "cqty", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\complexqty{<>}{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Probability
	s(
		{ trig = "pr", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\Pr", {}),
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "sch", snippetType = "autosnippet" }, { t("\\Sch") }, { condition = tex.in_tex_mathzone }),

	-- Brackets and absolute
	s(
		{ trig = "bv", snippetType = "autosnippet", priority = 2000 },
		{ t("\\bigg\\vert") },
		{ condition = tex.in_tex_mathzone }
	),

	-- Special symbols (temporary.lua)
	s(
		{ trig = "\\psii", snippetType = "autosnippet", priority = 3000 },
		{ t("\\psi_i") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "\\varphii", snippetType = "autosnippet", priority = 3000 },
		{ t("\\varphi_i") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "\\psi~", snippetType = "autosnippet", priority = 3000 },
		{ t("\\tilde{\\psi}") },
		{ condition = tex.in_tex_mathzone }
	),
	s(
		{ trig = "\\varphi~;", snippetType = "autosnippet", priority = 3000 },
		{ t("\\tilde{\\varphi}") },
		{ condition = tex.in_tex_mathzone }
	),
	s({ trig = "ang", snippetType = "autosnippet" }, fmta("\\angle ", {}), { condition = tex.in_tex_mathzone }),
	s({ trig = "ed", snippetType = "autosnippet" }, { t("\\ed") }, { condition = tex.in_tex_mathzone }),
}

local environments = {
	-- Inline and display math
	s({ trig = "mk", snippetType = "autosnippet" }, fmta("\\(<>\\)", { i(1) }), { condition = tex.in_tex_text }),
	s({ trig = "dm", snippetType = "autosnippet" }, fmta("\\[\n  <>\n\\]", { i(1) }), { condition = tex.in_tex_text }),

	-- Document structures
	s(
		{ trig = "beg", snippetType = "autosnippet" },
		fmta("\\begin{<>}[<>]\n  <>\n\\end{<>}", { i(1), i(2), i(0), rep(1) }),
		{ condition = line_begin }
	),

	-- Lists
	s(
		{ trig = "ben", snippetType = "autosnippet" },
		fmta("\\begin{enumerate}[<>]\n  \\item <>\n\\end{enumerate}", { i(1, "(a)"), i(0) }),
		{ condition = line_begin }
	),

	s(
		{ trig = "bit", snippetType = "autosnippet" },
		fmta("\\begin{itemize}\n  \\item <>\n\\end{itemize}", { i(0) }),
		{ condition = line_begin }
	),

	s({ trig = "im", snippetType = "autosnippet" }, { t("\\item") }, { condition = tex.in_tex_item * line_begin }),

	-- Math environments

	s(
		{ trig = "case", snippetType = "autosnippet" },
		fmta("\\begin{cases}\n  <>\n\\end{cases}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "bal", snippetType = "autosnippet" },
		fmta("\\begin{align*}\n  <>\n\\end{align*}", { i(0) }),
		{ condition = tex.in_tex_text }
	),

	-- Other structures
	s(
		{ trig = "bcr", snippetType = "autosnippet" },
		fmta("\\begin{center}\n  <>\n\\end{center}", { i(0) }),
		{ condition = line_begin }
	),

	-- Document sections
	s(
		{ trig = "cha", snippetType = "autosnippet" },
		fmta("\\chapter{<>}", { i(1) }),
		{ condition = line_begin * tex.in_tex_text }
	),

	s(
		{ trig = "par", snippetType = "autosnippet" },
		fmta("\\paragraph{<>}", { i(1) }),
		{ condition = line_begin * tex.in_tex_text }
	),

	s(
		{ trig = "sec", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\section{"), i(1), t("}") }),
			sn(nil, { t("\\section*{"), i(1), t("}") }),
		}),
		{ condition = tex.in_tex_text * line_begin }
	),

	s(
		{ trig = "ssec", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\subsection{"), i(1), t("}") }),
			sn(nil, { t("\\subsection*{"), i(1), t("}") }),
		}),
		{ condition = tex.in_tex_text * line_begin }
	),
}

local matrices = {
	s(
		{ trig = "bmat", snippetType = "autosnippet" },
		fmta("\\begin{bmatrix}\n  <>\n\\end{bmatrix}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "Bmat", snippetType = "autosnippet" },
		fmta("\\begin{Bmatrix}\n  <>\n\\end{Bmatrix}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "pmat", snippetType = "autosnippet" },
		fmta("\\begin{pmatrix}\n  <>\n\\end{pmatrix}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "Vmat", snippetType = "autosnippet" },
		fmta("\\begin{Vmatrix}\n  <>\n\\end{Vmatrix}", { i(0) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Identity matrices
	s(
		{ trig = "II3", snippetType = "autosnippet", priority = 2000 },
		fmta("\\begin{bmatrix}\n  1 & & \\\\\n  & 1 & \\\\\n  & & 1 \\\\\n\\end{bmatrix}", {}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "II4", snippetType = "autosnippet", priority = 2000 },
		fmta("\\begin{bmatrix}\n  1 & & & \\\\\n  & 1 & & \\\\\n  & & 1 & \\\\\n  & & & 1 \\\\\n\\end{bmatrix}", {}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "II5", snippetType = "autosnippet", priority = 2000 },
		fmta(
			"\\begin{bmatrix}\n  1 & & & &\\\\\n  & 1 & & &\\\\\n  & & 1 & &\\\\\n  & & & 1 &\\\\\n  & & & & 1\\\\\n\\end{bmatrix}",
			{}
		),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "II6", snippetType = "autosnippet", priority = 2000 },
		fmta(
			"\\begin{bmatrix}\n  1 & & & & &\\\\\n  & 1 & & & &\\\\\n  & & 1 & & &\\\\\n  & & & 1 & &\\\\\n  & & & & 1 &\\\\\n  & & & & & 1\\\\\n\\end{bmatrix}",
			{}
		),
		{ condition = tex.in_tex_mathzone }
	),
}

local derivatives = {
	s(
		{ trig = "pv", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\pdv{"), i(1), t("}{"), i(2), t("}") }),
			sn(nil, { t("\\pdv["), i(1), t("]{"), i(2), t("}{"), i(3), t("}") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),
}

local physics_braket = {
	-- Bra-ket notation
	s(
		{ trig = "bra", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\bra{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "ket", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\ket{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "bk", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\braket{"), i(1), t("}{"), i(2), t("}") }),
			sn(nil, { t("\\braket{"), i(1), t("}{"), i(2), t("}{"), i(3), t("}") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "kb", snippetType = "autosnippet" },
		fmta("\\dyad{<>}{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Paired delimiters
	s(
		{ trig = "lrs", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("{\\left( <> \\right)}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "lrb", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("{\\left\\{ <> \\right\\}}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "lrm", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("{\\left[ <> \\right]}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "vab", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		c(1, {
			sn(nil, { t("\\|"), i(1), t("\\|") }),
			sn(nil, { t("\\left|"), i(1), t("\\right|") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "lr<", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\left\\langle <> \\right\\rangle", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),
}

local completion = {
	-- Subscript and superscript completion
	s(
		{ trig = "([%a%)%]%}])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "([%a%)%]%}])_(%d)(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<><>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			f(function(_, snip)
				return snip.captures[3]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "([%a%)%]%}])(%a)%2", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
		fmta("<>_<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{
			trig = "([%a%)%]%}])_(%a)(%a)%3",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 2000,
		},
		fmta("<>_{<><>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			f(function(_, snip)
				return snip.captures[3]
			end),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Fraction completion
	s(
		{ trig = "(%d+)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "(%a)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "%((.+)%)/", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "(\\%a+)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "(\\%a+%{%a+%})/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 3000 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Limits and sums
	s(
		{ trig = "lim", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\lim_{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "lsup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\limsup_{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "linf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\liminf_{<>}", { i(1) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "sum", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\sum_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} ") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "pd", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\prod_{"), i(1), t("} ") }),
			sn(nil, { t("\\prod_{"), i(1), t("}^{"), i(2), t("} ") }),
		}),
		{ condition = tex.in_tex_mathzone }
	),

	-- Big operators
	s(
		{ trig = "bot", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bigotimes_{<>}^{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "bcap", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bigcap_{<>}^{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "bcup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bigcup_{<>}^{<>}", { i(1), i(2) }),
		{ condition = tex.in_tex_mathzone }
	),

	-- Integrals
	s(
		{ trig = "int", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>} <> \\d <>", { i(1), i(2), i(3), i(4) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "oint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\oint_{<>}^{<>} <> \\d <>", { i(1), i(2), i(3), i(4) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "2int", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\int_{<>}^{<>}\\int_{<>}^{<>} <> \\d <>\\d <>", { i(1), i(2), i(3), i(4), i(5), i(6), i(7) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "iint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\iint_{<>}^{<>} <> \\d <>", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4) }),
		{ condition = tex.in_tex_mathzone }
	),

	s(
		{ trig = "lint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\int_{<>} <> \\d <>", { i(1, "\\infty"), i(2), i(3) }),
		{ condition = tex.in_tex_mathzone }
	),
}

local all_snippets = {}
vim.list_extend(all_snippets, math_symbols)
vim.list_extend(all_snippets, greek_letters)
vim.list_extend(all_snippets, math_fonts)
vim.list_extend(all_snippets, math_commands)
vim.list_extend(all_snippets, environments)
vim.list_extend(all_snippets, matrices)
vim.list_extend(all_snippets, derivatives)
vim.list_extend(all_snippets, physics_braket)
vim.list_extend(all_snippets, completion)
return all_snippets
