# Block chain challenge

# Q1
## potential security improvement
- Define network policy to allow only the necessary ports and protocols
- Define kyverno policies to enforce pod security context and network policies
- Enable docker signing and verification
- Enable Load balancer for the service and enable ACLs to allow only the necessary IPs
- Record all the network traffic and analyze it for any suspicious activity
- Periodically scan the container images for any vulnerabilities
- Periodically backup the efs data to s3 bucket

## design choices
- Used EKS for kubernetes cluster as it is managed and easy to scale
- Used kustomize for managing the kubernetes manifests, to make it easy to manage the resources
