LUA = lua
LUA_CFLAGS = $(shell pkg-config --cflags $(LUA))
LUA_LIBS = $(shell pkg-config --libs $(LUA))

FILES   = sqlite3.lua luasql-sqlite3.lua libluasqlite3-loader.lua
SRCS    = libluasqlite3.c
LIB     = sqlite3
 
LUAVER  = $(shell $(LUA) -v 2>&1 | cut -c 5-7)
CFLAGS  = -O3 -Wall -fPIC $(LUA_CFLAGS)
LIBS    = -lsqlite3 $(LUA_LIBS)

LIBDIR  = /usr/lib/lua/$(LUAVER)
DATADIR = /usr/share/lua/$(LUAVER)

$(LIB).so: ${SRCS:.c=.o}
	cc -shared -o $(LIB).so ${CFLAGS} ${SRCS:.c=.o} $(LIBS)
	m4 -DSHARED_LIB_PATH=$(LIBDIR) < libluasqlite3-loader.lua.in > libluasqlite3-loader.lua

clean:
	rm -f *.o *.so
	rm -f libluasqlite3-loader.lua
    
install:
	install -m 755 $(LIB).so $(DESTDIR)$(LIBDIR)/
	install -m 755 $(FILES) $(DESTDIR)$(DATADIR)/

uninstall:
	rm -f $(DESTDIR)$(LIBDIR)/$(LIB).so
	rm -f $(DESTDIR)$(DATADIR)/sqlite3.lua
	rm -f $(DESTDIR)$(DATADIR)/luasql-sqlite3.lua
	rm -f $(DESTDIR)$(DATADIR)/libluasqlite3-loader.lua