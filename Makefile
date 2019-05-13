CFLAGS = -g -O3 -Wall
MIX = mix

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS += -I"$(ERLANG_PATH)"
CFLAGS += -Ic_src

EBIN_DIR=ebin
PRIV_PATH ?= priv
TARGET=$(PRIV_PATH)/blake256.so

ifneq ($(CROSSCOMPILE),)
    # crosscompiling
    CFLAGS += -fPIC
else
    # not crosscompiling
    ifneq ($(OS),Windows_NT)
        CFLAGS += -fPIC

        ifeq ($(shell uname),Darwin)
            LDFLAGS += -dynamiclib -undefined dynamic_lookup
        endif
    endif
endif

BLAKE256_SRC = lib/c_src/blake256.c

.PHONY: all clean

all: nif

blake:
	$(MIX) compile

nif:$(TARGET)

$(TARGET): $(BLAKE256_SRC)
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ $(BLAKE256_SRC)

clean:
	rm -rf $(PRIV_PATH)/*.so
