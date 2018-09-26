FROM golang:1.10.3 AS build-env

COPY . /go/src/github.com/openshift/openshift-network-operator
WORKDIR /go/src/github.com/openshift/openshift-network-operator
RUN ./hack/build-go.sh

FROM scratch
COPY --from=build-env /go/src/github.com/openshift/openshift-network-operator/_output/linux/amd64/openshift-network-operator /bin/openshift-network-operator
COPY --from=build-env /go/src/github.com/openshift/openshift-network-operator/_output/linux/amd64/openshift-network-renderer /bin/openshift-network-renderer
COPY manifests /manifests

ENV OPERATOR_NAME=openshift-network-operator
CMD ["/bin/openshift-network-operator"]