FILES   = sqlite3.lua luasql-sqlite3.lua libluasqlite3-loader.lua
SRCS    = libluasqlite3.c
LIB     = sqlite3
 
LUAVER  = $(shell lua -v 2>&1 | cut -c 5-7)
LUA     = -llua$(LUAVER)
CFLAGS  = -O3 -Wall -fPIC -I/usr/include -I/usr/include/$(LUAVER)
LIBS    = -lsqlite3 $(LUA) -lm

LIBDIR  = /usr/lib/lua/$(LUAVER)
DATADIR = /usr/share/lua/$(LUAVER)

$(LIB).so: ${SRCS:.c=.o}
	cc -shared -o $(LIB).so ${CFLAGS} ${SRCS:.c=.o} $(LIBS)
	m4 -DSHARED_LIB_PATH=$(LUADIR) < libluasqlite3-loader.lua.in > libluasqlite3-loader.lua

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