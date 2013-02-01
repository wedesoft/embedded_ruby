CC = gcc
RUBY = ruby
RUBYCFLAGS = $(shell $(RUBY) -e "puts RbConfig::CONFIG['CFLAGS']")
RUBYHDRDIR = $(shell $(RUBY) -e "puts RbConfig::CONFIG['rubyhdrdir']")
RUBYARCH = $(shell $(RUBY) -e "puts RbConfig::CONFIG['arch']")
RUBYLIBDIR = $(shell $(RUBY) -e "puts RbConfig::CONFIG['libdir']")
RUBYLIBRUBYARG = $(shell $(RUBY) -e "puts RbConfig::CONFIG['LIBRUBYARG']")
RUBYLDFLAGS = $(shell $(RUBY) -e "puts RbConfig::CONFIG['LDFLAGS']")
RUBYSOLIBS = $(shell $(RUBY) -e "puts RbConfig::CONFIG['SOLIBS']")
RUBYDLDLIBS = $(shell $(RUBY) -e "puts RbConfig::CONFIG['DLDLIBS']")
CFLAGS = $(RUBYCFLAGS) -I$(RUBYHDRDIR) -I$(RUBYHDRDIR)/$(RUBYARCH)
LFLAGS = -L$(RUBYLIBDIR) $(RUBYLIBRUBYARG) $(RUBYLDFLAGS) $(RUBYSOLIBS) $(RUBYDLDLIBS)

all: embedded_ruby

embedded_ruby: embedded_ruby.o
	$(CC) -o $@ embedded_ruby.o $(LFLAGS)

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f embedded_ruby *.o
