# Python Plugin

The following _Makefile_ rules are provided:

- _setup_: Create a Python 3 virtual environment and install _protobuf_ and
  _grpcio_ dependencies.
- _bundle_: Build a bundle for the plugin using RSA key. The RSA key pair can be
  generated by issuing `make gen-keys` from within the root of this repository.
