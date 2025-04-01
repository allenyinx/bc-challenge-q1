# Block chain challenge Q1

## potential security improvement
- Define network policy to allow only the necessary ports and protocols
- Define kyverno policies to enforce pod security context and network policies
- Enable docker signing and verification
- Enable Load balancer for the service and enable ACLs to allow only the necessary IPs
- Record all the network traffic and analyze it for any suspicious activity
- Periodically scan the container images for any vulnerabilities
- Periodically backup the efs data by setup backup plan

## design choices
- Used kubernetes cluster as the deployment environment to declaratively manage the resources and scale the application
- Used kustomize for managing the kubernetes manifests, to separate the environment specific configurations and reuse the common configurations

# Deliverables location
- deployment resources: stored in the `deploy` folder
- server log: stored in the root folder, `server.log`