# dreamobjects-bb

A Babashka-native DreamHost DreamObjects client providing S3-compatible storage operations.

## Features

- S3-compatible API
- Babashka pod interface
- CLI tool
- AWS CLI configuration compatibility

## Installation

```bash
# Clone repository
git clone https://github.com/jwalsh/dreamobjects-bb.git
cd dreamobjects-bb

# Set up development environment
cp .envrc.sample .envrc
# Edit .envrc with your credentials
```

## Configuration

Configure AWS CLI for DreamObjects:

```ini
# ~/.aws/config
[profile dreamobjects]
region = us-east-1
endpoint_url = https://objects-us-east-1.dream.io
s3 =
  endpoint_url = https://objects-us-east-1.dream.io
  addressing_style = path
```

## Usage

```clojure
;; As a pod
(require '[babashka.pods :as pods])
(pods/load-pod 'jwalsh/dreamobjects-bb "0.1.0")

;; List buckets
(require '[pod.jwalsh.dreamobjects-bb.core :as do])
(do/list-buckets)
```

## Development

```bash
# Run tests
bb test

# Run linter
bb lint

# Create release
bb release
```

## License

Copyright © 2024 jwalsh

Distributed under the Eclipse Public License version 1.0.
