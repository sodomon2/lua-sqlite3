LUA = lua
LUA_CFLAGS = $(shell pkg-config --cflags $(LUA))
LUA_LIBS = $(shell pkg-config --libs $(LUA))

FILES   = lua-sqlite3.lua lua-sqlite3-loader.lua
SRCS    = libluasqlite3.c
LIB     = core
 
LUAVER  = $(shell $(LUA) -v 2>&1 | cut -c 5-7)
CFLAGS  = -O3 -Wall -fPIC $(LUA_CFLAGS)
LIBS    = -lsqlite3 $(LUA_LIBS)

LIBDIR  = /usr/lib/lua/$(LUAVER)
DATADIR = /usr/share/lua/$(LUAVER)

$(LIB).so: ${SRCS:.c=.o}
	cc -shared -o $(LIB).so ${CFLAGS} ${SRCS:.c=.o} $(LIBS)
	m4 -DSHARED_LIB_PATH=$(LIBDIR) < lua-sqlite3-loader.lua.in > lua-sqlite3-loader.lua

clean:
	rm -f *.o *.so
	rm -f lua-sqlite3-loader.lua

check:
	$(LUA) test/tests.lua

install:
	install -d $(DESTDIR)$(LIBDIR)/lua-sqlite3/ $(DESTDIR)$(DATADIR)/lua-sqlite3/
	install -m 755 luasql-sqlite3.lua $(DESTDIR)$(DATADIR)/lua-sqlite3/luasql.lua
	install -m 755 $(LIB).so $(DESTDIR)$(LIBDIR)/lua-sqlite3/
	install -m 755 $(FILES) $(DESTDIR)$(DATADIR)/

uninstall:
	rm -f $(DESTDIR)$(LIBDIR)/$(LIB).so
	rm -f $(DESTDIR)$(DATADIR)/lua-sqlite3.lua
	rm -f $(DESTDIR)$(DATADIR)/lua-sqlite3/luasql.lua
	rm -f $(DESTDIR)$(DATADIR)/lua-sqlite3-loader.lua

.PHONY: $(LIB).so
