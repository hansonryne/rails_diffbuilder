function diffRender(z, t) {
    function A(E, f) {
        function e(d, a) {
            var b = document.createElement("span");
            b.setAttribute("class", "nav_filename");
            b.appendChild(document.createTextNode("" == a ? "Unknown" : a));
            var c = document.createElement("div");
            c.setAttribute("class", "nav_filename_bar");
            c.appendChild(b);
            d.appendChild(c)
        }

        function n(d, a) {
            function b(a, b, c, d) {
                function e(a, b) {
                    var d = document.createElement("td"),
                        c = document.createElement("pre");
                    d.setAttribute("class", "linenum_cell");
                    c.setAttribute("class", "linenum_text");
                    c.appendChild(document.createTextNode(a));
                    d.appendChild(c);
                    return d
                }

                function k(a, b, d) {
                    var c = document.createElement("td"),
                        e = document.createElement("pre");
                    switch (d) {
                        case y:
                            c.setAttribute("class", "diff_basic diff_context");
                            break;
                        case u:
                            c.setAttribute("class", "diff_basic diff_info diff_split");
                            c.setAttribute("colspan", "2");
                            break;
                        case w:
                            c.setAttribute("class", "diff_basic diff_info diff_sec_title");
                            c.setAttribute("colspan", "4");
                            b = "Section: " + b;
                            break;
                        case B:
                            a ? c.setAttribute("class", "diff_basic diff_add") : c.setAttribute("class",
                                "diff_basic diff_del");
                            break;
                        case C:
                            c.setAttribute("class", "diff_basic diff_pad");
                            c.setAttribute("colspan", "2");
                            break;
                        case x:
                            null == b ? (c.setAttribute("class", "diff_basic diff_pad"), c.setAttribute(
                                "colspan", "2")) : c.setAttribute("class", "diff_basic diff_mod")
                    }
                    null == b && (b = "");
                    e.appendChild(document.createTextNode(b));
                    c.appendChild(e);
                    return c
                }
                if (d != u || null != b || null != c) {
                    var g = document.createElement("tr"),
                        f = d;
                    switch (d) {
                        case B:
                            f = C;
                            break;
                        case C:
                            f = B
                    }
                    g.setAttribute("class", "code_row");
                    if (d == u || d == w ? 0 : null != b) g.appendChild(e(m, f)), m++;
                    g.appendChild(k(!1, b, f));
                    if (d != w) {
                        if (d == u || d == w ? 0 : null != c) g.appendChild(e(h, f)), h++;
                        g.appendChild(k(!0, c, d))
                    }
                    a.appendChild(g)
                }
            }
            var c = l[0],
                k = s[0];
            switch (a) {
                case u:
                    var g = null != p;
                    g && b(d, p, null, w);
                    p = null;
                    var e = parseInt(c.text),
                        f = parseInt(k.text),
                        n = e - m;
                    e > m && n == f - h ? (c = n + " unchanged line" + (1 == n ? "" : "s") + " skipped...", b(d,
                        c, c, a)) : 0 == e || 1 == e || 0 == f || 1 == f ? g || d.setAttribute("style",
                        "border-top-style: solid") : b(d, c.text, k.text, a);
                    m = e;
                    h = f;
                    l.shift();
                    s.shift();
                    break;
                case w:
                    p = c.text;
                    l.shift();
                    break;
                case y:
                    if (k.state != y) {
                        b(d, c.text, c.text, a);
                        l.shift();
                        break
                    }
                    if (c.state != y) {
                        b(d, k.text, k.text, a);
                        s.shift();
                        break
                    }
                    c.text == k.text ? (b(d, c.text, k.text, a), l.shift(), s.shift()) : (b(d, c.text, c.text,
                        a), l.shift());
                    break;
                case B:
                    b(d, null, k.text, a);
                    s.shift();
                    break;
                case C:
                    b(d, c.text, null, a);
                    l.shift();
                    break;
                case x:
                    f = e = null, c.state == x && (e = c.text, l.shift()), k.state == x && (f = k.text, s
                        .shift()), b(d, e, f, a)
            }
        }

        function r() {
            0 == l.length && v(l, null, u);
            0 == s.length && v(s, null, u);
            var d = l[0],
                a = s[0];
            return d.state == u ? a.state : a.state == u || d.state == w || d.state == C ? d.state : a.state ==
                B ? a.state : d.state == x || a.state == x ? x : y
        }
        var m, h, p = null;
        if (!D()) {
            h = m = 1;
            for (var q = document.createElement("table"); 0 < l.length || 0 < s.length;) n(q, r());
            q.setAttribute("class", "result_table");
            e(f, E);
            f.appendChild(q)
        }
    }

    function v(l, f, e) {
        var n = {};
        n.text = f;
        n.state = e;
        l.push(n)
    }

    function D() {
        return 0 == l.length && 0 == s.length
    }

    function F(t, f) {
        function e(c, b) {
            if (b == w) v(l, c, b);
            else switch (m) {
                case n:
                    v(l, c, b);
                    break;
                case r:
                    v(s, c, b)
            }
        }
        for (var n = 200, r = 300, m = 100, h = t.split("\n"), p = "", q = "", d = 0; d < h.length; d++) {
            var a = h[d],
                b;
            null != (b = /^- ([^\n]*)/.exec(a)) || null != (b = /^-($)/.exec(a)) ? e(b[1], C) : null != (b =
                /^\+ ([^\n]*)/.exec(a)) || null != (b = /^\+($)/.exec(a)) ? e(b[1], B) : null != (b =
                /^! ([^\n]*)/.exec(a)) || null != (b = /^!($)/.exec(a)) ? e(b[1], x) : null != (b =
                /^\*{3} ([0-9]+)[0-9,]* \*{3}/.exec(a)) ? (m = n, e(b[1], u)) : null != (b =
                /^-{3} ([0-9]+)[0-9,]* -{3}/.exec(a)) ? (m = r, e(b[1], u)) : null != (b =
                /^Index: ([^\n]*)/.exec(a)) || null != (b = /^\*{3} ([^\n]*)/.exec(a)) || null != (b =
                /^\-{3} ([^\n]*)/.exec(a)) ? (D() || (A(p, f), q = p = ""), "" != p && q != a.charAt(0) ||
                "" == b[1] || "/dev/null" == b[1] || (p = b[1], q = a.charAt(0)), m = 100) : null != (b =
                /^  ([^\n]*)/.exec(a)) || null != (b = /^ ($)/.exec(a)) ? e(b[1], y) : null != (b =
                /^\*{15} ([^\n]*)/.exec(a)) ? e(b[1], w) : m = 100
        }
        A(p, f)
    }

    function G(t, f) {
        function e(a, d) {
            if (p != a) {
                if (p == r) {
                    var e = a == m;
                    if (-1 != b) {
                        for (var g = b; g < d; g++) v(l, q[g].substr(1), e ? x : C);
                        b = -1
                    }
                } else h == n && a == r && (b = c);
                p = a
            }
        }
        for (var n = 200, r = 240, m = 250, h = 100, p = 0, q = t.split("\n"), d = "", a = "", b = -1, c =
                0; c < q.length; c++) {
            var k = q[c],
                g;
            null != (g = /^Index: ([^\n]*)/.exec(k)) || null != (g = /^diff --git .*? b\/([^\n]*)/.exec(k)) ||
                100 == h && (null != (g = /^\-{3} ([^\n]*)/.exec(k)) || null != (g = /^\+{3} ([^\n]*)/.exec(
                    k))) ? (e(0, c), D() || (A(d, f), a = d = ""), "" != d && a != k.charAt(0) || "" == g[1] ||
                    "/dev/null" == g[1] || (d = g[1], a = k.charAt(0)), h = 100) : null != (g = /^-([^\n]*)/
                    .exec(k)) && h == n ? e(r, c) : null != (g = /^\+([^\n]*)/.exec(k)) && h == n ? (k = p ==
                    r || p == m, e(k ? m : 230, c), v(s, g[1], k ? x : B)) : null != (g =
                    /^@@ \-([0-9]+)[0-9,]* \+([0-9]+)[0-9,]* @@ *([^\n]*)/.exec(k)) ? (e(0, c), h = n, "" != g[
                    3] && v(l, g[3], w), v(l, g[1], u), v(s, g[2], u)) : null != (g = /^ ([^\n]*)/.exec(k)) &&
                h == n ? (e(220, c), v(l, g[1], y), v(s, g[1], y)) : (e(0, c), h = 100)
        }
        A(d, f)
    }
    var y = 0,
        B = 1,
        C = 2,
        x = 3,
        u = 4,
        w = 5,
        l = [],
        s = [];
    z = z.replace(/\r\n?/g, "\n");
    t.innerHTML = ""; - 1 != z.search(/(^|\n)@@ \-[0-9,]+ \+[0-9,]+ @@/) ? G(z, t) : F(z, t);
    (function (l, f, e) {
        function n(b, a, d) {
            var e = document.createElement("a");
            e.setAttribute("href", b);
            e.innerHTML = a;
            e.setAttribute("class", "nav_link");
            null != d && e.setAttribute("name", d);
            return e
        }
        e = l.getElementsByClassName("nav_filename");
        if (!(1 >= e.length)) {
            var r = document.createElement("option");
            r.setAttribute("value", "#" + f + "TOP");
            r.setAttribute("selected", "selected");
            r.appendChild(document.createTextNode("< Jump to ... >"));
            var m = document.createElement("span");
            m.innerHTML = "<a name=" + f + "TOP></a><b>File List:&nbsp;</b>";
            var h = document.createElement("select");
            h.setAttribute("onchange", "location.href = this.options[this.selectedIndex].value;");
            h.setAttribute("class", "nav_filelist");
            h.appendChild(r);
            var p = document.createElement("div");
            p.setAttribute("class", "nav_filelist_bar");
            p.appendChild(h);
            p.insertBefore(m, h);
            for (m = e.length - 1; 0 <= m; m--) {
                var q = e[m],
                    d = m + 1,
                    a = document.createElement("option");
                a.setAttribute("value", "#" + f + d);
                a.appendChild(document.createTextNode(q.textContent));
                h.insertBefore(a, h.firstChild);
                a = document.createElement("span");
                a.setAttribute("class", "nav_link_bar");
                a.appendChild(n("#" + f + (d - 1), "&laquo;", null));
                a.appendChild(n("#" + f + (d + 1), "&raquo;", null));
                a.appendChild(n("#" + f + "TOP", "&uArr;", f + d));
                q.parentNode.insertBefore(a, q);
                q.insertBefore(document.createTextNode(" "), q.firstChild)
            }
            h.removeChild(r);
            h.insertBefore(r, h.firstChild);
            l.insertBefore(p, l.firstChild)
        }
    })(t, "navFile")
}

function loadDiff(z) {
    if (window.FileReader) {
        var t = document.getElementById("diff_file").files;
        if (0 == t.length) alert("Please select a valid patch file.");
        else {
            var t = t[0],
                A = new FileReader;
            A.readAsText(t);
            A.onload = function (t) {
                diffRender(this.result, z)
            }
        }
    } else alert(
        "This feature is not supported in this browser. \nRun in Chrome/Firefox/Opera is highly recommended."
    )
}; /*]]>*/