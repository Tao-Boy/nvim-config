local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local md = require("utils.functions")

local math_symbols = {
	s(
		{ trig = "...", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\dots") },
		{ condition = md.in_md_mathzone }
	),
	s({
		trig = "c.",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\cdot") }, { condition = md.in_md_mathzone }),
	s({
		trig = "o.",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\odot") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "\\cdot.", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\cdots") },
		{ condition = md.in_md_mathzone }
	),
	s({
		trig = "v.",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\vdot") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "\\vdot.", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\vdots") },
		{ condition = md.in_md_mathzone }
	),

	s({
		trig = "!=",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\neq") }, { condition = md.in_md_mathzone }),
	s({
		trig = "==",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("&=") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "~=", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\approx") },
		{ condition = md.in_md_mathzone }
	),
	s({
		trig = "~~",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\sim") }, { condition = md.in_md_mathzone }),
	s({
		trig = ">=",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\geq") }, { condition = md.in_md_mathzone }),
	s({
		trig = "<=",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\leq") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "\\leq=", wordTrig = false, snippetType = "autosnippet" },
		{ t("&\\leq") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "\\geq=", wordTrig = false, snippetType = "autosnippet" },
		{ t("&\\geq") },
		{ condition = md.in_md_mathzone }
	),
	s({
		trig = ">>",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\gg") }, { condition = md.in_md_mathzone }),
	s({
		trig = "<<",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\ll") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "eqv", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\equiv") },
		{ condition = md.in_md_mathzone }
	),

	s({
		trig = "iff",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\iff") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "=>", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\implies") },
		{ condition = md.in_md_mathzone }
	),
	s({
		trig = "inn",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\in") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "notin", wordTrig = false, snippetType = "autosnippet" },
		{ t("not\\in") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "aa", wordTrig = true, snippetType = "autosnippet" },
		{ t("\\forall") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ee", wordTrig = true, snippetType = "autosnippet" },
		{ t("\\exists") },
		{ condition = md.in_md_mathzone }
	),
	s({
		trig = "land",
		snippetType = "autosnippet",
	}, { t("\\land") }, { condition = md.in_md_mathzone }),
	s({
		trig = "lor",
		snippetType = "autosnippet",
	}, { t("\\lor") }, { condition = md.in_md_mathzone }),

	s({
		trig = "to",
		wordTrig = false,
		snippetType = "autosnippet",
	}, { t("\\to") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "mto", wordTrig = false, snippetType = "autosnippet", priority = 1001 },
		{ t("\\mapsto") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "get", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\gets") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "up", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\uparrow") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "down", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\downarrow") },
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "\\\\\\", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\setminus") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "mid", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mid") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "cap", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\cap") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "cup", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\cup") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "sub", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\subset") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "emp", snippetType = "autosnippet", priority = 2000 },
		{ t("\\emptyset") },
		{ condition = md.in_md_mathzone }
	),

	s({ trig = "+-", wordTrig = false, snippetType = "autosnippet" }, { t("\\pm") }, { condition = md.in_md_mathzone }),
	s({ trig = "-+", wordTrig = false, snippetType = "autosnippet" }, { t("\\mp") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "xx", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\times") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "cir", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\circ") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ot", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\otimes") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "op", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\oplus") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "<>", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\diamond") },
		{ condition = md.in_md_mathzone }
	),

	s({ trig = "sr", wordTrig = false, snippetType = "autosnippet" }, { t("^2") }, { condition = md.in_md_mathzone }),
	s({ trig = "cb", wordTrig = false, snippetType = "autosnippet" }, { t("^3") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "inv", wordTrig = false, snippetType = "autosnippet" },
		{ t("^{-1}") },
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "**", wordTrig = false, snippetType = "autosnippet" }, { t("^*") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "tp", wordTrig = false, snippetType = "autosnippet" },
		{ t("^\\top") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "dr", wordTrig = false, snippetType = "autosnippet" },
		{ t("^\\dagger") },
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "cc", snippetType = "autosnippet" }, { t("^c") }, { condition = md.in_md_mathzone }),
	s({ trig = "++", snippetType = "autosnippet" }, { t("^+") }, { condition = md.in_md_mathzone }),
	s({ trig = "--", snippetType = "autosnippet", priority = 2000 }, { t("^-") }, { condition = md.in_md_mathzone }),

	s(
		{ trig = "oo", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\infty") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "perp", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\perp") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "hbar", wordTrig = false, snippetType = "autosnippet", priority = 1500 },
		{ t("\\hbar") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ell", wordTrig = true, snippetType = "autosnippet", priority = 2000 },
		{ t("\\ell") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ns", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\unlhd") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "not", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		{ t("\\not") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "par", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		{ t("\\partial") },
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "nabla", snippetType = "autosnippet" }, { t("\\nabla") }, { condition = md.in_md_mathzone }),
	s({ trig = "neg", snippetType = "autosnippet" }, { t("\\neg") }, { condition = md.in_md_mathzone }),
	s({ trig = "po", snippetType = "autosnippet" }, { t("\\propto") }, { condition = md.in_md_mathzone }),
	s({ trig = "##", wordTrig = false, snippetType = "autosnippet" }, { t("\\#") }, { condition = md.in_md_mathzone }),

	s({ trig = "ii", snippetType = "autosnippet" }, { t("\\int") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "oii", snippetType = "autosnippet", priority = 2000 },
		{ t("\\oint") },
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "lhs", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mathrm{L.H.S}") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "rhs", wordTrig = false, snippetType = "autosnippet" },
		{ t("\\mathrm{R.H.S}") },
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "b|", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\Big|_{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "jk", wordTrig = false, snippetType = "autosnippet" },
		fmta("_{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "kj", wordTrig = false, snippetType = "autosnippet" },
		fmta("^{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
}

local greek_letters = {
	s(
		{ trig = ";A", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Alpha") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";a", snippetType = "autosnippet", wordTrig = false },
		{ t("\\alpha") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";b", snippetType = "autosnippet", wordTrig = false },
		{ t("\\beta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";B", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Beta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";g", snippetType = "autosnippet", wordTrig = false },
		{ t("\\gamma") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";G", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Gamma") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";d", snippetType = "autosnippet", wordTrig = false },
		{ t("\\delta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";D", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Delta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "eps", snippetType = "autosnippet", wordTrig = false },
		{ t("\\epsilon") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "vps", snippetType = "autosnippet", wordTrig = false },
		{ t("\\varepsilon") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Eps", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Epsilon") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";z", snippetType = "autosnippet", wordTrig = false },
		{ t("\\zeta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";Z", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Zeta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "eta", snippetType = "autosnippet", wordTrig = false },
		{ t("\\eta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Eta", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Eta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";t", snippetType = "autosnippet", wordTrig = false },
		{ t("\\theta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = ";T", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Theta") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "iot", snippetType = "autosnippet", wordTrig = false },
		{ t("\\iota") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Iot", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Iota") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "kap", snippetType = "autosnippet", wordTrig = false },
		{ t("\\kappa") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Kap", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Kappa") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "lam", snippetType = "autosnippet", wordTrig = false },
		{ t("\\lambda") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Lam", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Lambda") },
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "mu", snippetType = "autosnippet", wordTrig = false }, { t("\\mu") }, { condition = md.in_md_mathzone }),
	s({ trig = "Mu", snippetType = "autosnippet", wordTrig = false }, { t("\\Mu") }, { condition = md.in_md_mathzone }),
	s({ trig = "nu", snippetType = "autosnippet", wordTrig = false }, { t("\\nu") }, { condition = md.in_md_mathzone }),
	s({ trig = "Nu", snippetType = "autosnippet", wordTrig = false }, { t("\\Nu") }, { condition = md.in_md_mathzone }),
	s({ trig = "pi", snippetType = "autosnippet", wordTrig = false }, { t("\\pi") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "\\pii", snippetType = "autosnippet", wordTrig = false, priority = 2000 },
		{ t("p_i") },
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "Pi", snippetType = "autosnippet", wordTrig = false }, { t("\\Pi") }, { condition = md.in_md_mathzone }),
	s(
		{ trig = "rho", snippetType = "autosnippet", wordTrig = false },
		{ t("\\rho") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Rho", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Rho") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "sig", snippetType = "autosnippet", wordTrig = false },
		{ t("\\sigma") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Sig", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Sigma") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "tau", snippetType = "autosnippet", wordTrig = false },
		{ t("\\tau") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Tau", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Tau") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ups", snippetType = "autosnippet", wordTrig = false },
		{ t("\\ups") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Ups", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Ups") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "phi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\phi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Phi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Phi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "vhi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\varphi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Vhi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Varphi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "chi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\chi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Chi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Chi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "psi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\psi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Psi", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Psi") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ome", snippetType = "autosnippet", wordTrig = false },
		{ t("\\omega") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Ome", snippetType = "autosnippet", wordTrig = false },
		{ t("\\Omega") },
		{ condition = md.in_md_mathzone }
	),
}

local math_fonts = {
	s({ trig = "msf", snippetType = "autosnippet" }, fmta("\\mathsf{<>}", { i(0) }), { condition = md.in_md_mathzone }),
	s({ trig = "bm", snippetType = "autosnippet" }, fmta("\\bm{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s({ trig = "bf", snippetType = "autosnippet" }, fmta("\\mathbf{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s(
		{ trig = "cal", snippetType = "autosnippet" },
		fmta("\\mathcal{<>}", { i(0) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "scr", snippetType = "autosnippet" },
		fmta("\\mathscr{<>}", { i(0) }),
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "mbb", snippetType = "autosnippet" }, fmta("\\mathbb{<>}", { i(0) }), { condition = md.in_md_mathzone }),
	s({ trig = "mrm", snippetType = "autosnippet" }, fmta("\\mathrm{<>}", { i(0) }), { condition = md.in_md_mathzone }),
	-- Text format
	s({ trig = "tit", snippetType = "autosnippet" }, fmta("*<>*", { i(0) }), {}),
	s({ trig = "tbf", snippetType = "autosnippet" }, fmta("**<>**", { i(0) }), {}),
	s({ trig = "ttt", snippetType = "autosnippet" }, fmta("`<>`", { i(0) }), {}),

	s(
		{ trig = "PP", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{P}") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "SS", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{S}") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "LL", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{L}") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "FF", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathscr{F}") },
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "IS", snippetType = "autosnippet", priority = 3000 },
		{ t("\\mathcal{IS}") },
		{ condition = md.in_md_mathzone }
	),
}

local math_commands = {
	s({ trig = "sin", snippetType = "autosnippet" }, { t("\\sin") }, { condition = md.in_md_mathzone }),
	s({ trig = "asin", snippetType = "autosnippet" }, { t("\\arcsin") }, { condition = md.in_md_mathzone }),
	s({ trig = "cos", snippetType = "autosnippet" }, { t("\\cos") }, { condition = md.in_md_mathzone }),
	s({ trig = "acos", snippetType = "autosnippet" }, { t("\\arccos") }, { condition = md.in_md_mathzone }),
	s({ trig = "tan", snippetType = "autosnippet" }, { t("\\tan") }, { condition = md.in_md_mathzone }),
	s({ trig = "atan", snippetType = "autosnippet" }, { t("\\arctan") }, { condition = md.in_md_mathzone }),
	s({ trig = "cot", snippetType = "autosnippet" }, { t("\\cot") }, { condition = md.in_md_mathzone }),
	s({ trig = "acot", snippetType = "autosnippet" }, { t("\\arccot") }, { condition = md.in_md_mathzone }),
	s({ trig = "csc", snippetType = "autosnippet" }, { t("\\csc") }, { condition = md.in_md_mathzone }),
	s({ trig = "acsc", snippetType = "autosnippet" }, { t("\\arccsc") }, { condition = md.in_md_mathzone }),
	s({ trig = "sec", snippetType = "autosnippet" }, { t("\\sec") }, { condition = md.in_md_mathzone }),
	s({ trig = "asec", snippetType = "autosnippet" }, { t("\\arcsec") }, { condition = md.in_md_mathzone }),

	s({ trig = "log", snippetType = "autosnippet" }, { t("\\log") }, { condition = md.in_md_mathzone }),
	s({ trig = "ln", snippetType = "autosnippet" }, { t("\\ln") }, { condition = md.in_md_mathzone }),
	s({ trig = "exp", snippetType = "autosnippet" }, { t("\\exp") }, { condition = md.in_md_mathzone }),

	s({ trig = "grad", snippetType = "autosnippet" }, { t("\\grad") }, { condition = md.in_md_mathzone }),
	s({ trig = "curl", snippetType = "autosnippet" }, { t("\\curl") }, { condition = md.in_md_mathzone }),
	s({ trig = "div", snippetType = "autosnippet" }, { t("\\div") }, { condition = md.in_md_mathzone }),
	s({ trig = "lap", snippetType = "autosnippet" }, { t("\\laplacian") }, { condition = md.in_md_mathzone }),

	s({ trig = "bbr", snippetType = "autosnippet" }, { t("\\mathbb{R}") }, { condition = md.in_md_mathzone }),
	s({ trig = "bbq", snippetType = "autosnippet" }, { t("\\mathbb{Q}") }, { condition = md.in_md_mathzone }),
	s({ trig = "bbh", snippetType = "autosnippet" }, { t("\\mathbb{H}") }, { condition = md.in_md_mathzone }),
	s({ trig = "bbc", snippetType = "autosnippet" }, { t("\\mathbb{C}") }, { condition = md.in_md_mathzone }),
	s({ trig = "bbz", snippetType = "autosnippet" }, { t("\\mathbb{Z}") }, { condition = md.in_md_mathzone }),
	s({ trig = "bbn", snippetType = "autosnippet" }, { t("\\mathbb{N}") }, { condition = md.in_md_mathzone }),
	s({ trig = "bbe", snippetType = "autosnippet" }, { t("\\mathbb{E}") }, { condition = md.in_md_mathzone }),

	s(
		{ trig = "bb(%w)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\mathbb{<>}", {
			f(function(_, snip)
				return string.upper(snip.captures[1])
			end),
		}),
		{ condition = md.in_md_mathzone }
	),

	s({ trig = "bar", snippetType = "autosnippet" }, fmta("\\bar{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s(
		{ trig = "(%a)bar", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\overline{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ob", snippetType = "autosnippet" },
		fmta("\\overbrace{<>}^{<>}", { i(1), i(2) }),
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "td", snippetType = "autosnippet" }, fmta("\\tilde{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s(
		{ trig = "(\\%a+)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\tilde{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "(%a)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\tilde{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "dot", snippetType = "autosnippet" }, fmta("\\dot{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s(
		{ trig = "doo", snippetType = "autosnippet", priority = 2000 },
		fmta("\\ddot{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "hat", snippetType = "autosnippet" }, fmta("\\hat{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s({ trig = "vec", snippetType = "autosnippet" }, fmta("\\vec{<>}", { i(1) }), { condition = md.in_md_mathzone }),
	s(
		{ trig = "ring", snippetType = "autosnippet", priority = 2000 },
		fmta("\\mathring{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "ub", snippetType = "autosnippet", priority = 2000 },
		fmta("\\underbrace{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),

	s({ trig = "kk", snippetType = "autosnippet" }, fmta("\\operatorname{ker}", {}), { condition = md.in_md_mathzone }),
	s(
		{ trig = "deg", snippetType = "autosnippet" },
		fmta("\\operatorname{deg}", {}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "spp", snippetType = "autosnippet" },
		fmta("\\operatorname{supp}", {}),
		{ condition = md.in_md_mathzone }
	),
	s({ trig = "imm", snippetType = "autosnippet" }, fmta("\\operatorname{im}", {}), { condition = md.in_md_mathzone }),
	s(
		{ trig = "span", snippetType = "autosnippet" },
		fmta("\\operatorname{span}", {}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "dim", snippetType = "autosnippet" },
		fmta("\\operatorname{dim}", {}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "det", snippetType = "autosnippet" },
		fmta("\\operatorname{det}", {}),
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "->", snippetType = "autosnippet" },
		fmta("\\xlongrightarrow{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "<-", snippetType = "autosnippet" },
		fmta("\\xlongleftarrow{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),

	s({ trig = "min", snippetType = "autosnippet" }, fmta("\\min", {}), { condition = md.in_md_mathzone }),
	s({ trig = "max", snippetType = "autosnippet" }, fmta("\\max", {}), { condition = md.in_md_mathzone }),
	s(
		{ trig = "sup", snippetType = "autosnippet", priority = 2000 },
		fmta("\\sup", {}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "inf", snippetType = "autosnippet", priority = 2000 },
		fmta("\\inf", {}),
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "//", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", { i(1), i(2) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "sq", wordTrig = false, snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\sqrt{"), i(1), t("}") }),
			sn(nil, { t("\\sqrt["), i(1), t("]{"), i(2), t("}") }),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "mod", wordTrig = false, snippetType = "autosnippet" },
		fmta("\\mod{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),

	s({ trig = "ang", snippetType = "autosnippet" }, fmta("\\angle ", {}), { condition = md.in_md_mathzone }),
}

local md_environments = {
	-- Inline and display math
	s({ trig = "mk", snippetType = "autosnippet" }, fmta("$<>$", { i(1) }), { condition = md.in_md_text }),
	s({ trig = "dm", snippetType = "autosnippet" }, fmta("$$\n<>\n$$", { i(1) }), { condition = md.in_md_text }),

	-- Headings
	s({ trig = "h1", snippetType = "autosnippet" }, fmta("# <>", { i(1) }), { condition = line_begin }),
	s({ trig = "h2", snippetType = "autosnippet" }, fmta("## <>", { i(1) }), { condition = line_begin }),
	s({ trig = "h3", snippetType = "autosnippet" }, fmta("### <>", { i(1) }), { condition = line_begin }),
	s({ trig = "h4", snippetType = "autosnippet" }, fmta("#### <>", { i(1) }), { condition = line_begin }),
	s({ trig = "h5", snippetType = "autosnippet" }, fmta("##### <>", { i(1) }), { condition = line_begin }),
	s({ trig = "h6", snippetType = "autosnippet" }, fmta("###### <>", { i(1) }), { condition = line_begin }),

	-- Lists
	s({ trig = "bit", snippetType = "autosnippet" }, fmta("- <>", { i(0) }), { condition = line_begin }),
	s({ trig = "ben", snippetType = "autosnippet" }, fmta("1. <>", { i(0) }), { condition = line_begin }),
	s({ trig = "im", snippetType = "autosnippet" }, { t("- ") }, { condition = line_begin }),

	-- Code
	s(
		{ trig = "bcd", snippetType = "autosnippet" },
		fmta("```<>\n<>\n```", { i(1, "lang"), i(0) }),
		{ condition = line_begin }
	),

	-- Quote
	s({ trig = "bqt", snippetType = "autosnippet" }, { t("> "), i(0) }, { condition = line_begin }),

	-- Link and image
	s({ trig = "lnk", snippetType = "autosnippet" }, fmta("[<>](<>)", { i(1, "text"), i(2, "url") }), {}),
	s({ trig = "img", snippetType = "autosnippet" }, fmta("![<>](<>)", { i(1, "alt"), i(2, "url") }), {}),
}

local matrices = {
	s(
		{ trig = "bmat", snippetType = "autosnippet" },
		fmta("\\begin{bmatrix}\n  <>\n\\end{bmatrix}", { i(0) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Bmat", snippetType = "autosnippet" },
		fmta("\\begin{Bmatrix}\n  <>\n\\end{Bmatrix}", { i(0) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "pmat", snippetType = "autosnippet" },
		fmta("\\begin{pmatrix}\n  <>\n\\end{pmatrix}", { i(0) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "Vmat", snippetType = "autosnippet" },
		fmta("\\begin{Vmatrix}\n  <>\n\\end{Vmatrix}", { i(0) }),
		{ condition = md.in_md_mathzone }
	),
}

local paired_delimiters = {
	s(
		{ trig = "lrs", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\left( <> \\right)", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "lrb", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\left\\{ <> \\right\\}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "lrm", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\left[ <> \\right]", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "vab", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		c(1, {
			sn(nil, { t("\\|"), i(1), t("\\|") }),
			sn(nil, { t("\\left|"), i(1), t("\\right|") }),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "lr<", wordTrig = false, snippetType = "autosnippet", priority = 1000 },
		fmta("\\left\\langle <> \\right\\rangle", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
}

local completion = {
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
		{ condition = md.in_md_mathzone }
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
		{ condition = md.in_md_mathzone }
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
		{ condition = md.in_md_mathzone }
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
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "(%d+)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "(%a)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "%((.+)%)/", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "(\\%a+)/", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "lim", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\lim_{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "lsup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\limsup_{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "linf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\liminf_{<>}", { i(1) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "sum", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\sum_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} ") }),
		}),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "pd", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\prod_{"), i(1), t("} ") }),
			sn(nil, { t("\\prod_{"), i(1), t("}^{"), i(2), t("} ") }),
		}),
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "int", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\int_{<>}^{<>} <> \\,d <>", { i(1), i(2), i(3), i(4) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "oint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\oint_{<>}^{<>} <> \\,d <>", { i(1), i(2), i(3), i(4) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "iint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\iint_{<>}^{<>} <> \\,d <>", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "lint", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\int_{<>} <> \\,d <>", { i(1, "\\infty"), i(2), i(3) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "2int", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\int_{<>}^{<>}\\int_{<>}^{<>} <> \\,d <>\\,d <>", { i(1), i(2), i(3), i(4), i(5), i(6), i(7) }),
		{ condition = md.in_md_mathzone }
	),

	s(
		{ trig = "bot", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bigotimes_{<>}^{<>}", { i(1), i(2) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "bcap", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bigcap_{<>}^{<>}", { i(1), i(2) }),
		{ condition = md.in_md_mathzone }
	),
	s(
		{ trig = "bcup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("\\bigcup_{<>}^{<>}", { i(1), i(2) }),
		{ condition = md.in_md_mathzone }
	),
}

local all_snippets = {}
vim.list_extend(all_snippets, math_symbols)
vim.list_extend(all_snippets, greek_letters)
vim.list_extend(all_snippets, math_fonts)
vim.list_extend(all_snippets, math_commands)
vim.list_extend(all_snippets, md_environments)
vim.list_extend(all_snippets, matrices)
vim.list_extend(all_snippets, paired_delimiters)
vim.list_extend(all_snippets, completion)
return all_snippets
