# Go s2i Image builder
based on https://github.com/openshift-s2i/s2i-go

## Create a buidler image in OpenShift
```
$ oc new-project golang-s2i
$ oc new-build https://github.com/dsevost/golang-s2i
```

## Using image in OpenShift
### Using simple build

```
$ oc new-project go-test1
$ oc new-app golang-s2i~https://github.com/dsevost/golang-s2i --context-dir=test/test-app --name=go-test

```
### Using for building of global projects
```
$ oc new-project go-global1
$ export GO_GLOBAL_PROJECT_NAME=github.com/dsevost/ovirt-openshift-extensions
$ oc new-build \
    --name=ovirt-flex-volume \
    -e DEBUG=1 \
    -e GO_GLOBAL_PROJECT_NAME=$GO_GLOBAL_PROJECT_NAME \
    -e TARGETS="cmd/ovirt-flexdriver cmd/ovirt-provisioner" \
    \
    golang-s2i~https://$GO_GLOBAL_PROJECT_NAME
```
