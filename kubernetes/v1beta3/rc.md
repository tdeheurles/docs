```
v1beta3.ReplicationController {
  kind (string, optional): kind of object, in CamelCase; cannot be updated,
  apiVersion (string, optional): version of the schema the object should have,
  metadata (v1beta3.ObjectMeta, optional): standard object metadata; see  http://docs.k8s.io/api-conventions.md#metadata,
  spec (v1beta3.ReplicationControllerSpec, optional): specification of the desired behavior of  the replication controller; http://docs.k8s.io/api-conventions.md#spec-and-status,
  status (v1beta3.ReplicationControllerStatus, optional): most recently observed status of the replication controller; populated by the system, read-only; http://docs.k8s.io/api-conventions.md#spec-and-status
}
v1beta3.ObjectMeta {
name (string, optional): string that identifies an object. Must be unique within a namespace; cannot be updated,
generateName (string, optional): an optional prefix to use to generate a unique name; has the same validation rules as name; optional, and is applied only name if is not specified,
namespace (string, optional): namespace of the object; must be a DNS_LABEL; cannot be updated,
selfLink (string, optional): URL for the object; populated by the system, read-only,
uid (string, optional): unique UUID across space and time; populated by the system; read-only,
resourceVersion (string, optional): string that identifies the internal version of this object that can be used by clients to determine when objects have changed; populated by the system, read-only; value must be treated as opaque by clients and passed unmodified back to the server: http://docs.k8s.io/api-conventions.md#concurrency-control-and-consistency,
creationTimestamp (string, optional): RFC 3339 date and time at which the object was created; populated by the system, read-only; null for lists,
deletionTimestamp (string, optional): RFC 3339 date and time at which the object will be deleted; populated by the system when a graceful deletion is requested, read-only; if not set, graceful deletion of the object has not been requested,
labels (any, optional): map of string keys and values that can be used to organize and categorize objects; may match selectors of replication controllers and services,
annotations (any, optional): map of string keys and values that can be used by external tooling to store and retrieve arbitrary metadata about objects
}
v1beta3.ReplicationControllerSpec {
replicas (integer, optional): number of replicas desired,
selector (any, optional): label keys and values that must match in order to be controlled by this replication controller, if empty defaulted to labels on Pod template,
template (v1beta3.PodTemplateSpec, optional): object that describes the pod that will be created if insufficient replicas are detected; takes precendence over templateRef
}
v1beta3.PodTemplateSpec {
metadata (v1beta3.ObjectMeta, optional): standard object metadata; see http://docs.k8s.io/api-conventions.md#metadata,
spec (v1beta3.PodSpec, optional): specification of the desired behavior of the pod; http://docs.k8s.io/api-conventions.md#spec-and-status
}
v1beta3.PodSpec {
volumes (array[v1beta3.Volume], optional): list of volumes that can be mounted by containers belonging to the pod,
containers (array[v1beta3.Container]): list of containers belonging to the pod; cannot be updated; containers cannot currently be added or removed; there must be at least one container in a Pod,
restartPolicy (string, optional): restart policy for all containers within the pod; one of Always, OnFailure, Never; defaults to Always,
terminationGracePeriodSeconds (integer, optional): optional duration in seconds the pod needs to terminate gracefully; may be decreased in delete request; value must be non-negative integer; the value zero indicates delete immediately; if this value is not set, the default grace period will be used instead; the grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal; set this value longer than the expected cleanup time for your process,
activeDeadlineSeconds (integer, optional),
dnsPolicy (string, optional): DNS policy for containers within the pod; one of 'ClusterFirst' or 'Default',
nodeSelector (any, optional): selector which must match a node's labels for the pod to be scheduled on that node,
serviceAccount (string, optional): name of the ServiceAccount to use to run this pod,
host (string, optional): host requested for this pod,
hostNetwork (boolean, optional): host networking requested for this pod,
imagePullSecrets (array[v1beta3.LocalObjectReference], optional): list of references to secrets in the same namespace available for pulling the container images
}
v1beta3.Volume {
name (string): volume name; must be a DNS_LABEL and unique within the pod,
hostPath (v1beta3.HostPathVolumeSource, optional): pre-existing host file or directory; generally for privileged system daemons or other agents tied to the host,
emptyDir (v1beta3.EmptyDirVolumeSource, optional): temporary directory that shares a pod's lifetime,
gcePersistentDisk (v1beta3.GCEPersistentDiskVolumeSource, optional): GCE disk resource attached to the host machine on demand,
awsElasticBlockStore (v1beta3.AWSElasticBlockStoreVolumeSource, optional): AWS disk resource attached to the host machine on demand,
gitRepo (v1beta3.GitRepoVolumeSource, optional): git repository at a particular revision,
secret (v1beta3.SecretVolumeSource, optional): secret to populate volume,
nfs (v1beta3.NFSVolumeSource, optional): NFS volume that will be mounted in the host machine,
iscsi (v1beta3.ISCSIVolumeSource, optional): iSCSI disk attached to host machine on demand,
glusterfs (v1beta3.GlusterfsVolumeSource, optional): Glusterfs volume that will be mounted on the host machine ,
persistentVolumeClaim (v1beta3.PersistentVolumeClaimVolumeSource, optional): a reference to a PersistentVolumeClaim in the same namespace,
rbd (v1beta3.RBDVolumeSource, optional): rados block volume that will be mounted on the host machine
}
v1beta3.HostPathVolumeSource {
path (string): path of the directory on the host
}
v1beta3.EmptyDirVolumeSource {
medium (string, optional): type of storage used to back the volume; must be an empty string (default) or Memory
}
v1beta3.GCEPersistentDiskVolumeSource {
pdName (string): unique name of the PD resource in GCE,
fsType (string): file system type to mount, such as ext4, xfs, ntfs,
partition (integer, optional): partition on the disk to mount (e.g., '1' for /dev/sda1); if omitted the plain device name (e.g., /dev/sda) will be mounted,
readOnly (boolean, optional): read-only if true, read-write otherwise (false or unspecified)
}
v1beta3.AWSElasticBlockStoreVolumeSource {
volumeID (string): unique id of the PD resource in AWS,
fsType (string): file system type to mount, such as ext4, xfs, ntfs,
partition (integer, optional): partition on the disk to mount (e.g., '1' for /dev/sda1); if omitted the plain device name (e.g., /dev/sda) will be mounted,
readOnly (boolean, optional): read-only if true, read-write otherwise (false or unspecified)
}
v1beta3.GitRepoVolumeSource {
repository (string): repository URL,
revision (string, optional): commit hash for the specified revision
}
v1beta3.SecretVolumeSource {
secretName (string): secretName is the name of a secret in the pod's namespace
}
v1beta3.NFSVolumeSource {
server (string): the hostname or IP address of the NFS server,
path (string): the path that is exported by the NFS server,
readOnly (boolean, optional): forces the NFS export to be mounted with read-only permissions
}
v1beta3.ISCSIVolumeSource {
targetPortal (string): iSCSI target portal,
iqn (string): iSCSI Qualified Name,
lun (integer): iscsi target lun number,
fsType (string): file system type to mount, such as ext4, xfs, ntfs,
readOnly (boolean, optional): read-only if true, read-write otherwise (false or unspecified)
}
v1beta3.GlusterfsVolumeSource {
endpoints (string): gluster hosts endpoints name,
path (string): path to gluster volume,
readOnly (boolean, optional): glusterfs volume to be mounted with read-only permissions
}
v1beta3.PersistentVolumeClaimVolumeSource {
claimName (string, optional): the name of the claim in the same namespace to be mounted as a volume,
readOnly (boolean, optional): mount volume as read-only when true; default false
}
v1beta3.RBDVolumeSource {
monitors (array[string]): a collection of Ceph monitors,
image (string): rados image name,
fsType (string, optional): file system type to mount, such as ext4, xfs, ntfs,
pool (string): rados pool name; default is rbd; optional,
user (string): rados user name; default is admin; optional,
keyring (string): keyring is the path to key ring for rados user; default is /etc/ceph/keyring; optional,
secretRef (v1beta3.LocalObjectReference): name of a secret to authenticate the RBD user; if provided overrides keyring; optional,
readOnly (boolean, optional): rbd volume to be mounted with read-only permissions
}
v1beta3.LocalObjectReference {
name (string, optional): name of the referent
}
v1beta3.Container {
name (string): name of the container; must be a DNS_LABEL and unique within the pod; cannot be updated,
image (string): Docker image name,
command (array[string], optional): entrypoint array; not executed within a shell; the docker image's entrypoint is used if this is not provided; cannot be updated; variable references $(VAR_NAME) are expanded using the container's environment variables; if a variable cannot be resolved, the reference in the input string will be unchanged; the $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME) ; escaped references will never be expanded, regardless of whether the variable exists or not,
args (array[string], optional): command array; the docker image's cmd is used if this is not provided; arguments to the entrypoint; cannot be updated; variable references $(VAR_NAME) are expanded using the container's environment variables; if a variable cannot be resolved, the reference in the input string will be unchanged; the $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME) ; escaped references will never be expanded, regardless of whether the variable exists or not,
workingDir (string, optional): container's working directory; defaults to image's default; cannot be updated,
ports (array[v1beta3.ContainerPort], optional): list of ports to expose from the container; cannot be updated,
env (array[v1beta3.EnvVar], optional): list of environment variables to set in the container; cannot be updated,
resources (v1beta3.ResourceRequirements, optional): Compute Resources required by this container; cannot be updated,
volumeMounts (array[v1beta3.VolumeMount], optional): pod volumes to mount into the container's filesyste; cannot be updated,
livenessProbe (v1beta3.Probe, optional): periodic probe of container liveness; container will be restarted if the probe fails; cannot be updated,
readinessProbe (v1beta3.Probe, optional): periodic probe of container service readiness; container will be removed from service endpoints if the probe fails; cannot be updated,
lifecycle (v1beta3.Lifecycle, optional): actions that the management system should take in response to container lifecycle events; cannot be updated,
terminationMessagePath (string, optional): path at which the file to which the container's termination message will be written is mounted into the container's filesystem; message written is intended to be brief final status, such as an assertion failure message; defaults to /dev/termination-log; cannot be updated,
privileged (boolean, optional): whether or not the container is granted privileged status; defaults to false; cannot be updated; deprecated; See SecurityContext.,
imagePullPolicy (string, optional): image pull policy; one of Always, Never, IfNotPresent; defaults to Always if :latest tag is specified, or IfNotPresent otherwise; cannot be updated,
capabilities (v1beta3.Capabilities, optional): capabilities for container; cannot be updated; deprecated; See SecurityContext.,
securityContext (v1beta3.SecurityContext, optional): security options the pod should run with
}
v1beta3.ContainerPort {
name (string, optional): name for the port that can be referred to by services; must be a DNS_LABEL and unique without the pod,
hostPort (integer, optional): number of port to expose on the host; most containers do not need this,
containerPort (integer): number of port to expose on the pod's IP address,
protocol (string, optional): protocol for port; must be UDP or TCP; TCP if unspecified,
hostIP (string, optional): host IP to bind the port to
}
v1beta3.EnvVar {
name (string): name of the environment variable; must be a C_IDENTIFIER,
value (string, optional): value of the environment variable; defaults to empty string; variable references $(VAR_NAME) are expanded using the previously defined environment varibles in the container and any service environment variables; if a variable cannot be resolved, the reference in the input string will be unchanged; the $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME) ; escaped references will never be expanded, regardless of whether the variable exists or not,
valueFrom (v1beta3.EnvVarSource, optional): source for the environment variable's value; cannot be used if value is not empty
}
v1beta3.EnvVarSource {
fieldRef (v1beta3.ObjectFieldSelector): selects a field of the pod; only name and namespace are supported
}
v1beta3.ObjectFieldSelector {
apiVersion (string, optional): version of the schema that fieldPath is written in terms of; defaults to v1beta3,
fieldPath (string): path of the field to select in the specified API version
}
v1beta3.ResourceRequirements {
limits (any, optional): Maximum amount of compute resources allowed,
requests (any, optional): Minimum amount of resources requested; requests are honored only for persistent volumes as of now
}
v1beta3.VolumeMount {
name (string): name of the volume to mount,
readOnly (boolean, optional): mounted read-only if true, read-write otherwise (false or unspecified),
mountPath (string): path within the container at which the volume should be mounted
}
v1beta3.Probe {
exec (v1beta3.ExecAction, optional): exec-based handler,
httpGet (v1beta3.HTTPGetAction, optional): HTTP-based handler,
tcpSocket (v1beta3.TCPSocketAction, optional): TCP-based handler; TCP hooks not yet supported,
initialDelaySeconds (integer, optional): number of seconds after the container has started before liveness probes are initiated,
timeoutSeconds (integer, optional): number of seconds after which liveness probes timeout; defaults to 1 second
}
v1beta3.ExecAction {
command (array[string], optional): command line to execute inside the container; working directory for the command is root ('/') in the container's file system; the command is exec'd, not run inside a shell; exit status of 0 is treated as live/healthy and non-zero is unhealthy
}
v1beta3.HTTPGetAction {
path (string, optional): path to access on the HTTP server,
port (string): number or name of the port to access on the container,
host (string, optional): hostname to connect to; defaults to pod IP
}
v1beta3.TCPSocketAction {
port (string): number of name of the port to access on the container
}
v1beta3.Lifecycle {
postStart (v1beta3.Handler, optional): called immediately after a container is started; if the handler fails, the container is terminated and restarted according to its restart policy; other management of the container blocks until the hook completes,
preStop (v1beta3.Handler, optional): called before a container is terminated; the container is terminated after the handler completes; other management of the container blocks until the hook completes
}
v1beta3.Handler {
exec (v1beta3.ExecAction, optional): exec-based handler,
httpGet (v1beta3.HTTPGetAction, optional): HTTP-based handler,
tcpSocket (v1beta3.TCPSocketAction, optional): TCP-based handler; TCP hooks not yet supported
}
v1beta3.Capabilities {
add (array[v1beta3.Capability], optional): added capabilities,
drop (array[v1beta3.Capability], optional): droped capabilities
}
v1beta3.Capability {
}
v1beta3.SecurityContext {
capabilities (v1beta3.Capabilities, optional): the linux capabilites that should be added or removed,
privileged (boolean, optional): run the container in privileged mode,
seLinuxOptions (v1beta3.SELinuxOptions, optional): options that control the SELinux labels applied,
runAsUser (integer, optional): the user id that runs the first process in the container
}
v1beta3.SELinuxOptions {
user (string, optional): the user label to apply to the container,
role (string, optional): the role label to apply to the container,
type (string, optional): the type label to apply to the container,
level (string, optional): the level label to apply to the container
}
v1beta3.ReplicationControllerStatus {
replicas (integer): most recently oberved number of replicas
}
```
