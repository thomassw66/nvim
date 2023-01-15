local luasnip = require("luasnip")

local ls = luasnip
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets(nil, {
  all = {},
  cpp = {
    snip(
      "funcdef",
      text([[
        void foo() {
        }
      ]])
    ),
    snip({
      trig = "max_fenwick_tree",
      name = "max_fenwick_tree",
      dscr = "efficient point update - prefix maximum queries - you can only add to the set",
    }, {
      text({
        "struct max_fenwick_tree {",
        "  const int neg_inf = numeric_limits<int>::min();",
        "  vi ft;",
        "",
        "	// indices are 1-based | 1 .. m  inclusive ",
        "	// index 0 is unused.",
        "  max_fenwick_tree(int m) : ft(m + 1, neg_inf) {}",
        "",
        "  void set(int index, int val) {",
        "    ft[index] = val;",
        "    while (index < (int)ft.size()) {",
        "      ft[index] = max(ft[index], val);",
        "      index += (index & (-index));",
        "    }",
        "  }",
        "",
        "  // queries the maximum value in the range [1...m]",
        "  int query(int from) {",
        "    int ans = ft[from];",
        "    while (from > 0) {",
        "      ans = max(ans, ft[from]);",
        "      from -= (from & (-from)); // lsb",
        "    }",
        "    return ans;",
        "  }",
        "};",
      }),
    }),
    snip({
      trig = "big_int",
      name = "big_int",
      dscr = "arbitrary precision integer arithmetic",
    }, {
      text({ "todo" }),
    }),
    snip({
      trig = "maximum_flow",
      name = "maximum_flow",
      dscr = "",
    }, {
      text({ "todo" }),
    }),
    snip({
      trig = "pair_hash",
      name = "pair_hash",
      dscr = "a good hash function for pairs",
    }, {
      text({
        "/// good hash fn for pairs.",
        "template<typename U, typename V>",
        "struct pair_hash {",
        "\tstatic uint64_t splitmix64(uint64_t x) {",
        "\t\t// http://xorshift.di.unimi.it/splitmix64.c",
        "\t\tx += 0x9e3779b97f4a7c15;",
        "\t\tx = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;",
        "\t\tx = (x ^ (x >> 27)) * 0x94d049bb133111eb;",
        "\t\treturn x ^ (x >> 31);",
        "\t}",
        "",
        "\tuint64_t operator()(pair<U, V> const& x) const {",
        "\t\tstatic const uint64_t FIX_RND = chrono::steady_clock::now().time_since_epoch().count();",
        "\t\tuint64_t result = 0;",
        "\t\tresult ^= splitmix64((uint64_t)x.first + FIX_RND);",
        "\t\tresult ^= splitmix64((uint64_t)x.second + FIX_RND);",
        "\t\treturn result;",
        "\t}",
        "};",
      }),
    }),
    snip({
      trig = "mod_int",
      name = "mod_int",
      dscr = "integer type that respect mathematical mod.",
    }, {
      text({
        "template <ll mod> struct mint {",
        "\tmint() : v(0) {}",
        "\tmint(int tv) : v(((tv % mod) + mod) % mod) {}",
        "\texplicit operator ll() const { return v; }",
        "\tmint &operator*=(mint const& o) {",
        "\t\tv = (v * o.v) % mod;",
        "\t\treturn *this;",
        "\t}",
        "\tmint &operator+=(mint const& o) {",
        "\t\tv = (v + o.v) % mod;",
        "\t\treturn *this;",
        "\t}",
        "\tmint &operator/=(mint const& o) {",
        "\t\tv = (v * inv(o.v)) % mod;",
        "\t\treturn *this;",
        "\t}",
        "\tmint &operator-=(mint const& o) {",
        "\t\tv = (((v - o.v) % mod) + mod) % mod;",
        "\t\treturn *this;",
        "\t}",

        "\tmint pow(mint const& b) {",
        "\t\tmint res{ pow(v, b.v) };",
        "\t\treturn res;",
        "\t}",

        "\tmint operator-() const { return mint(-v); }",

        "\tmint &operator++() { return *this += 1; }",
        "\tmint &operator--() { return *this -= 1; }",
        "\tfriend mint operator+(mint a, mint const& b) { return a += b; }",
        "\tfriend mint operator-(mint a, mint const& b) { return a -= b; }",
        "\tfriend mint operator*(mint a, mint const& b) { return a *= b; }",
        "\tfriend bool operator==(mint const& a, mint const& b) { return a.v == b.v; }",
        "\tfriend bool operator!=(mint const& a, mint const& b) { return a.v != b.v; }",
        "\tfriend bool operator<(mint const& a, mint const& b) { return a.v < b.v; }",
        "",
        "private:",
        "\tll pow(ll a, ll x) {",
        "\t\tif (x == 0) return 1;",
        "\t\tif (x == 1) return a;",
        "\t\tll y = pow(a * a % mod, x / 2);",
        "\t\tif ((x & 1) == 1) y = (y * a) % mod;",
        "\t\treturn y;",
        "\t}",
        "",
        "\t// solves ax + by = gcd(a,b)",
        "\t// return gcd(a,b)",
        "\t// returns coeffecients x and y",
        "\tll ext_gcd(ll a, ll b, ll &x, ll &y) {",
        "\t\tif (b == 0) {",
        "\t\t\tx = 1;",
        "\t\t\ty = 0;",
        "\t\t\treturn a;",
        "\t\t}",
        "\t\tll x1, y1;",
        "\t\tll g = ext_gcd(b, a % b, x1, y1);",
        "\t\t// b x1 + [a - ((a/b) * b] y1",
        "\t\t// b x1 + a y1 - ((a/b) y1 * b",
        "\t\tx = y1;",
        "\t\ty = x1 - (a / b) * y1;",
        "\t\treturn g;",
        "\t}",
        "",
        "\t// computes the modular inverse of a % mod | x * a % mod = 1",
        "\tll inv(ll a) {",
        "\t\tll x, y;",
        "\t\tll g = ext_gcd(a, mod, x, y);",
        "\t\t// assert g == 1 - always true if mod is prime.",
        "\t\tx = ((x % mod) + mod) % mod;",
        "\t\treturn x;",
        "\t}",
        "",
        "\tll v;",
        "};",
      }),
    }),
  },
})
