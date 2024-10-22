(ns jwalsh.dreamobjects-bb.core
  "Core DreamObjects operations"
  (:require [org.httpkit.client :as http]
            [clojure.string :as str]))

(def ^:private base-url "https://objects-us-east-1.dream.io")

(defprotocol StorageClient
  (list-buckets [this]
    "List all buckets for the authenticated user")
  (get-bucket [this bucket-name]
    "Get bucket details and contents")
  (put-object [this bucket key content]
    "Upload an object to a bucket")
  (get-object [this bucket key]
    "Retrieve an object from a bucket"))

(defrecord DreamObjectsClient [credentials]
  StorageClient
  (list-buckets [this]
    ;; TODO: Implement
    )
  (get-bucket [this bucket-name]
    ;; TODO: Implement
    )
  (put-object [this bucket key content]
    ;; TODO: Implement
    )
  (get-object [this bucket key]
    ;; TODO: Implement
    ))

(defn create-client
  "Create a new DreamObjects client"
  [{:keys [access-key secret-key] :as opts}]
  (->DreamObjectsClient opts))
