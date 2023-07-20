
This information is based on [this documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/building_running_and_managing_containers/assembly_adding-software-to-a-ubi-container_building-running-and-managing-containers#proc_using-the-ubi-micro-images_assembly_adding-software-to-a-ubi-container)

Steps:

```shell
cat << 'EOF' >buildahimage.sh
#!/bin/bashpodman 
echo "get image"
microcontainer=$(buildah from registry.access.redhat.com/ubi9/ubi-micro)
echo "Mount image"
micromount=$(buildah mount $microcontainer)
echo "install software"
dnf install \
--installroot $micromount \
--releasever=/ \
--setopt install_weak_deps=false \
--setopt=reposdir=/etc/yum.repos.d/ \
--nodocs -y \
jq curl
dnf clean all \
--installroot $micromount
echo "unmount image"
buildah umount $microcontainer
echo "commit image"
buildah commit $microcontainer ubi-micro-jq
EOF
chmod +x buildahimage.sh
buildah unshare ./buildahimage.sh
```

`podman tag ubi-micro-jq example-registry-quay-openshift-operators.bi-ocp-162e406f043e20da9b0ef0731954a894-0000.eu-gb.containers.appdomain.cloud/brian/ubi-micro-jq:latestpodman tag ubi-micro-jq example-registry-quay-openshift-operators.bi-ocp-162e406f043e20da9b0ef0731954a894-0000.eu-gb.containers.appdomain.cloud/brian/ubi-micro-jq:latest`

`podman push example-registry-quay-openshift-operators.bi-ocp-162e406f043e20da9b0ef0731954a894-0000.eu-gb.containers.appdomain.cloud/brian/ubi-micro-jq:latest`