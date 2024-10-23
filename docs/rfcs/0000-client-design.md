# RFC 0000: DreamObjects Babashka Client Design
Status: Proposal  
Type: Design  
Created: 2024-10-22  
Author: jwalsh

## Abstract

A Babashka-native client for DreamHost's DreamObjects service, providing S3-compatible storage operations through both programmatic and CLI interfaces. This client aims to be a foundational building block for various storage use cases in the Clojure/Babashka ecosystem.

## Background

Storage needs in modern applications require flexible, cost-effective solutions. This client provides a Clojure-native interface to DreamObjects while maintaining AWS S3 compatibility.

### Storage Interface Options

1. **Object Storage APIs**
   - S3 Protocol
   - DreamObjects API
   - Generic Object Storage

2. **Alternative Protocols**
   - SFTP/FTP
   - WebDAV
   - rsync

3. **Implementation Languages**
   - Clojure/Babashka (chosen)
   - Python
   - Node.js

## Core Design

### API Structure
```clojure
(defprotocol StorageClient
  (list-buckets [this])
  (get-bucket [this bucket-name])
  (put-object [this bucket key content])
  (get-object [this bucket key]))
```
