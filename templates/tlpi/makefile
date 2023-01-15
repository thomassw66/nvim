
CXX=g++-11

LINUX_LIBRT = -lrt
LINUX_LIBDL = -ldl
LINUX_LIBACL = -lacl
LINUX_LIBCRYPT = -lcrypt
LINUX_LIBCAP = -lcap

IMPL_THREAD_FLAGS = -pthread

LIBS = ${LINUX_LIBRT} ${LINUX_LIBDL} ${LINUX_LIBCRYPT} ${LINUX_LIBACL} ${LINUX_LIBCAP} ${IMPL_THREAD_FLAGS}

IMPL_CXXFLAGS = -std=c++17 -D_XOPEN_SOURCE=600 \
	        -D_DEFAULT_SOURCE \
		-pthread \
		-g \
		-pedantic \
		-Wall \
		-Werror \
		-Wno-sign-compare \
		-Wimplicit-fallthrough \
		-Wno-unused-parameter \
		-Wall -Werror -Wformat=2 -Wfloat-equal \
		 -Wshadow -Wno-unused-parameter -Wsign-conversion -Wno-sign-compare \
		 -fsanitize=address,undefined \

CXXFLAGS = ${IMPL_CXXFLAGS} ${IMPL_THREAD_FLAGS} ${LIBS}

LDLIBS =

RM = rm -f

all: clean
all: tmpl

unix_helpers.o: unix_helpers.cc unix_helpers.h
	$(CXX) $(CXXFLAGS) $< -c $@

tmpl: tmpl.cc unix_helpers.o
	$(CXX) $(CXXFLAGS) unix_helpers.o $< -o $@ 


clean:
	$(RM) tmpl unix_helpers.o

.PHONY: clean all
