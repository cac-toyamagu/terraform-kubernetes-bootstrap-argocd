# argocd_application

## NOTE

DO NOT USE this helm chart.  
It is much more straightforward to:

- `helm_version` < `5.0.0` : write an argocd application in your `values.yaml` [^1].
- `helm_version` > `5.0.0` : use helm chart for argo-apps[^2].

This helm chart is a only practice.

[^1]: https://github.com/argoproj/argo-helm/blob/798c8107c3d0015b8cb93d565cf714c16848b3e8/charts/argo-cd/values.yaml#L1302
[^2]: https://github.com/argoproj/argo-helm/tree/main/charts/argocd-apps
