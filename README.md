# Lua-Sqlite3 is a sqlite3 wrapper for Lua

[![Build Status](https://travis-ci.org/moteus/lua-sqlite3.svg?branch=master)](https://travis-ci.org/moteus/lua-sqlite3)
<img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/sodomon2/lua-sqlite3?label=last%20release">
![LuaRocks](https://img.shields.io/luarocks/v/sodomon2/lua-sqlite3)

### Changes since 0.4.2
 * Support for lua 5.4
 * Added `Makefile build` support
 * Removed `Autoconf` support
 * Removed `lake` support
 * Removed `LuaCov` file
 * `libluasqlite3` renamed to `sqlite3`

### Changes since 0.4.1.1
 * Support LuaRocks
 * Support Lua 5.2 and 5.3
 * Use sqlite3_open_v2
 * `open` method support flags
 * Add open_uri method
 * Use sqlite3_prepare_v2
 * Improve error message strings

To learn more about lua-sqlite3 take a look in documentation.html.

Please note that this release is still alpha software. This mean that 
there exists a chance that function signatures and behavour will change
in the future.

If you have suggestions, questions or feature request please
feel free to contact me.


Michael Roth <mroth@nessie.de>

