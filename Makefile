##
# Shell normalization

SHELL:=/bin/bash
export SHELL

##
# Configuration

PROTO_DIR:=$(CURDIR)/proto
GEN_DIR:=$(CURDIR)/gen

##
# Go setup

TOOLS:=$(CURDIR)/_tools
export GOBIN:=$(TOOLS)/bin
export PATH:=$(GOBIN):${PATH}
export GO111MODULE=on

##
# Bootstrapping

.PHONY: bootstrap
bootstrap: $(TOOLS)

$(TOOLS):
	mkdir -p $(TOOLS)
	@[ ! -f $(TOOLS)/go.mod ] && cd $(TOOLS) && go mod init tools || true
	cd $(TOOLS) && go get github.com/uber/prototool/cmd/prototool@v1.9.0
	cd $(TOOLS) && go mod edit -replace=github.com/thechriswalker/protoc-gen-twirp_js=github.com/gorzell/protoc-gen-twirp_js@v0.1.0
	cd $(TOOLS) && go get github.com/twitchtv/twirp-ruby/protoc-gen-twirp_ruby@v1.4.0
	cd $(TOOLS) && go get github.com/golang/protobuf/protoc-gen-go@v1.3.1
	cd $(TOOLS) && go get github.com/twitchtv/twirp/protoc-gen-twirp@v5.8.0
	cd $(TOOLS) && go get github.com/thechriswalker/protoc-gen-twirp_js

##
# Project cleanup

.PHONY: clean
clean:
	@[ -d $(GEN_DIR) ] && rm -rf $(GEN_DIR) || true

.PHONY: sanitize
sanitize:
	@[ -d $(TOOLS) ] && rm -rf $(TOOLS) || true

##
# Generation

.PHONY: generate
generate: $(GEN_DIR)

$(GEN_DIR): $(PROTO_DIR)
	cd $(PROTO_DIR) && prototool generate

##
# Linting

.PHONY: lint
lint: $(PROTO_DIR)
	cd $(PROTO_DIR) && prototool lint

##
# Formatting

SOURCES:=$(shell find $(PROTO_DIR) -type f -name '*.proto')

.PHONY: format
format:
	$(foreach proto,$(SOURCES),(prototool format -w $(proto));)