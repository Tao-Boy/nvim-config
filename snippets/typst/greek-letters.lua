local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local typst = require("utils.typst")

ls.add_snippets("typst", {
	s({ trig = ";a", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("alpha"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";A", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Alpha"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";b", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("beta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";t", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("theta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";B", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Beta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";g", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("gamma"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";G", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Gamma"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";d", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("delta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";D", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Delta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";e", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("epsilon"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ":e", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("epsilon.alt"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";E", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Epsilon"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";z", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("zeta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";Z", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Zeta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "eta", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("eta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Eta", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Eta"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "iot", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("iota"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Iot", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Iota"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";k", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("kappa"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";K", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Kappa"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";l", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("lambda"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";L", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Lambda"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "mu", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("mu"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Mu", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Mu"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "nu", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("nu"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Nu", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Nu"),
	}, { condition = typst.in_mathzone }),
	-- s({ trig = "xi", snippetType = "autosnippet", wordTrig = true }, {
	--   t("\\xi"),
	-- }, { condition = tex.in_mathzone }),
	-- s({ trig = "Xi", snippetType = "autosnippet", wordTrig = true }, {
	--   t("\\Xi"),
	-- }, { condition = tex.in_mathzone }),
	s({ trig = "omi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("omicron"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "pi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("pi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Pi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Pi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";r", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("rho"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";R", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Rho"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";s", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("sigma"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";S", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Sigma"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "tau", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("tau"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Tau", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Tau"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "ups", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("ups"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Ups", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Ups"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";p", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("phi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";P", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Phi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "phi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("phi.alt"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "chi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("chi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Chi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Chi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "psi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("psi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = "Psi", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Psi"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";o", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("omega"),
	}, { condition = typst.in_mathzone }),
	s({ trig = ";O", snippetType = "autosnippet", wordTrig = true, hidden = true }, {
		t("Omega"),
	}, { condition = typst.in_mathzone }),
})
