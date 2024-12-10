#!/bin/sh

handle_auth_providers() {

  oc_login

  API_SERVER_URL=$(oc whoami --show-server)
  ENCODED_API_SERVER_URL=$(echo "${API_SERVER_URL}" | base64)
  ENCODED_CLUSTER_NAME=$(echo "my-cluster" | base64)
  export AUTH_PROVIDERS_RELEASE="rhdh-auth-providers"
  export AUTH_PROVIDERS_NAMESPACE="showcase-auth-providers"

  export K8S_CLUSTER_ROUTER_BASE=$(oc get route console -n openshift-console -o=jsonpath='{.spec.host}' | sed 's/^[^.]*\.//')

  add_helm_repos
  run_tests "${AUTH_PROVIDERS_RELEASE}" "${AUTH_PROVIDERS_NAMESPACE}"

}
