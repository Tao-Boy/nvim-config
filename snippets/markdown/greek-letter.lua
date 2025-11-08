local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local tex = require("utils.latex")

ls.add_snippets("org", {
	s({ trig = ";a", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\alpha"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";A", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Alpha"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";b", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\beta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";t", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\theta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";B", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Beta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";g", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\gamma"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";G", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Gamma"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";d", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\delta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";D", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Delta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";e", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\epsilon"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ":e", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\varepsilon"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";E", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Epsilon"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";z", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\zeta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";Z", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Zeta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "eta", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\eta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Eta", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Eta"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "iot", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\iota"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Iot", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Iota"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";k", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\kappa"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";K", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Kappa"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";l", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\lambda"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";L", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Lambda"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "mu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\mu"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Mu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Mu"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "nu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\nu"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Nu", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Nu"),
	}, { condition = tex.in_mathzone }),
	-- s({ trig = "xi", snippetType = "autosnippet", wordTrig = false }, {
	--   t("\\xi"),
	-- }, { condition = tex.in_mathzone }),
	-- s({ trig = "Xi", snippetType = "autosnippet", wordTrig = false }, {
	--   t("\\Xi"),
	-- }, { condition = tex.in_mathzone }),
	s({ trig = "omi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\omicron"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "pi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\pi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Pi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Pi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";r", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\rho"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";R", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Rho"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";s", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\sigma"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";S", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Sigma"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "tau", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\tau"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Tau", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Tau"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "ups", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\ups"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Ups", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Ups"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";p", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\phi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";P", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Phi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "phi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\varphi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Vhi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Varphi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "chi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\chi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Chi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Chi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "psi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\psi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = "Psi", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Psi"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";o", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\omega"),
	}, { condition = tex.in_mathzone }),
	s({ trig = ";O", snippetType = "autosnippet", wordTrig = false, hidden = true }, {
		t("\\Omega"),
	}, { condition = tex.in_mathzone }),
})
