(ns jwalsh.dreamobjects-bb.core-test
  (:require [clojure.test :refer :all]
            [jwalsh.dreamobjects-bb.core :as core]))

(deftest create-client-test
  (testing "Client creation"
    (let [client (core/create-client {:access-key "test" :secret-key "test"})]
      (is (instance? jwalsh.dreamobjects_bb.core.DreamObjectsClient client)))))

(deftest storage-operations-test
  (testing "Storage operations"
    ;; TODO: Add integration tests
    ))
