# Twirp + Prototool Example

This repository provides a simple example of Twirp code generation for Go/Ruby/JS using prototool.

## Installing it

Clone it:

```shell
$ git clone https://github.com/bruce/twirp_prototool_example
```

Make sure you have a recent version of [Go](https://golang.org/) (see [`.tool-versions`](.tool_versions)).

Run the bootstrap task to install dependencies:

```shell
$ make bootstrap
```

## Running it

Lint protobuf files in `proto/`:

```shell
$ make lint
```

Format protobuf files in `proto/`:

```shell
$ make format
```

Generate Go/Ruby/JS code in `gen/` from protobuf files in `proto/`

```shell
$ make generate
```

Clean out generated files from `gen/`:

```shell
$ make clean
```

Remove project dependencies:

```shell
$ make sanitize
```
