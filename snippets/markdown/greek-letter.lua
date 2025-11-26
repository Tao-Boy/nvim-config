local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local tex = require("utils.latex")

ls.add_snippets("markdown", {
	s({ trig = ";a", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\alpha"),
	}, { condition = tex.in_latex }),
	s({ trig = ";A", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Alpha"),
	}, { condition = tex.in_latex }),
	s({ trig = ";b", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\beta"),
	}, { condition = tex.in_latex }),
	s({ trig = ";t", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\theta"),
	}, { condition = tex.in_latex }),
	s({ trig = ";B", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Beta"),
	}, { condition = tex.in_latex }),
	s({ trig = ";g", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\gamma"),
	}, { condition = tex.in_latex }),
	s({ trig = ";G", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Gamma"),
	}, { condition = tex.in_latex }),
	s({ trig = ";d", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\delta"),
	}, { condition = tex.in_latex }),
	s({ trig = ";D", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Delta"),
	}, { condition = tex.in_latex }),
	s({ trig = ";e", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\epsilon"),
	}, { condition = tex.in_latex }),
	s({ trig = ":e", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\varepsilon"),
	}, { condition = tex.in_latex }),
	s({ trig = ";E", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Epsilon"),
	}, { condition = tex.in_latex }),
	s({ trig = ";z", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\zeta"),
	}, { condition = tex.in_latex }),
	s({ trig = ";Z", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Zeta"),
	}, { condition = tex.in_latex }),
	s({ trig = "eta", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\eta"),
	}, { condition = tex.in_latex }),
	s({ trig = "Eta", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Eta"),
	}, { condition = tex.in_latex }),
	s({ trig = "iot", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\iota"),
	}, { condition = tex.in_latex }),
	s({ trig = "Iot", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Iota"),
	}, { condition = tex.in_latex }),
	s({ trig = ";k", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\kappa"),
	}, { condition = tex.in_latex }),
	s({ trig = ";K", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Kappa"),
	}, { condition = tex.in_latex }),
	s({ trig = ";l", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\lambda"),
	}, { condition = tex.in_latex }),
	s({ trig = ";L", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Lambda"),
	}, { condition = tex.in_latex }),
	s({ trig = "mu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\mu"),
	}, { condition = tex.in_latex }),
	s({ trig = "Mu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Mu"),
	}, { condition = tex.in_latex }),
	s({ trig = "nu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\nu"),
	}, { condition = tex.in_latex }),
	s({ trig = "Nu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Nu"),
	}, { condition = tex.in_latex }),
	-- s({ trig = "xi", snippetType = "autosnippet", wordTrig = false }, {
	--   t("\\xi"),
	-- }, { condition = tex.in_latex }),
	-- s({ trig = "Xi", snippetType = "autosnippet", wordTrig = false }, {
	--   t("\\Xi"),
	-- }, { condition = tex.in_latex }),
	s({ trig = "omi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\omicron"),
	}, { condition = tex.in_latex }),
	s({ trig = "pi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\pi"),
	}, { condition = tex.in_latex }),
	s({ trig = "Pi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Pi"),
	}, { condition = tex.in_latex }),
	s({ trig = ";r", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\rho"),
	}, { condition = tex.in_latex }),
	s({ trig = ";R", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Rho"),
	}, { condition = tex.in_latex }),
	s({ trig = ";s", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\sigma"),
	}, { condition = tex.in_latex }),
	s({ trig = ";S", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Sigma"),
	}, { condition = tex.in_latex }),
	s({ trig = "tau", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\tau"),
	}, { condition = tex.in_latex }),
	s({ trig = "Tau", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Tau"),
	}, { condition = tex.in_latex }),
	s({ trig = "ups", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\ups"),
	}, { condition = tex.in_latex }),
	s({ trig = "Ups", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Ups"),
	}, { condition = tex.in_latex }),
	s({ trig = ";p", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\phi"),
	}, { condition = tex.in_latex }),
	s({ trig = ";P", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Phi"),
	}, { condition = tex.in_latex }),
	s({ trig = "phi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\varphi"),
	}, { condition = tex.in_latex }),
	s({ trig = "Vhi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Varphi"),
	}, { condition = tex.in_latex }),
	s({ trig = "chi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\chi"),
	}, { condition = tex.in_latex }),
	s({ trig = "Chi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Chi"),
	}, { condition = tex.in_latex }),
	s({ trig = "psi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\psi"),
	}, { condition = tex.in_latex }),
	s({ trig = "Psi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Psi"),
	}, { condition = tex.in_latex }),
	s({ trig = ";o", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\omega"),
	}, { condition = tex.in_latex }),
	s({ trig = ";O", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Omega"),
	}, { condition = tex.in_latex }),
})
