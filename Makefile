# Makefile (Nix-friendly)
PROG_NAME ?= interception-vimproved
BUILD_DIR ?= build
TARGET    ?= $(BUILD_DIR)/$(PROG_NAME)

PREFIX    ?= /usr/local         # ignored by Nix; Nix will pass PREFIX = $(out)
BIN_DIR   ?= $(PREFIX)/bin
ETC_DIR   ?= $(PREFIX)/etc/interception-vimproved
CONFIG    ?= config.yaml

.PHONY: all build install clean uninstall

all: build

build:
	meson setup $(BUILD_DIR)
	ninja -C $(BUILD_DIR)

install: build
	install -D --strip -T $(TARGET) $(BIN_DIR)/$(PROG_NAME)
	install -D $(CONFIG) $(ETC_DIR)/config.yaml

clean:
	rm -rf $(BUILD_DIR)

# 'uninstall' is not used in Nix builds; leave it or drop it.
