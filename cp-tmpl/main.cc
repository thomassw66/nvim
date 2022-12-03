#include <algorithm>
#include <bitset>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <limits>
#include <map>
#include <numeric>
#include <queue>
#include <random>
#include <set>
#include <sstream>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

using namespace std;

using ll = long long;
using vi = vector<int>;
using vl = vector<ll>;
using vvi = vector<vi>;
using pii = pair<int, int>;
using vii = vector<pii>;
using pll = pair<ll, ll>;

#define bit(x, k) (1ll & ((x) >> (k)))
#define off(x, k) ((x) & ~(1ll << (k)))
#define on(x, k) ((x) | (1ll << (k)))

mt19937_64 rng((unsigned long long)chrono::steady_clock::now().time_since_epoch().count());

int32_t main(int32_t argc, char **argv) {
  ios_base::sync_with_stdio(0);
  cin.tie(0);

#ifdef TWLOCAL
  freopen("sin.txt", "r", stdin);
#endif 

  return 0;
}
