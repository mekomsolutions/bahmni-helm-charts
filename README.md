## Bahmni Helm Charts

<p align="left">
  <img src="./readme/bahmni-logo-square.png" alt="Bahmni Logo" height="155">
  <img src="./readme/plus.png" alt="plus sign" height="50">
  <img src="./readme/kubernetes-stacked-color.svg" alt="Docker Logo" height="150">
  </p>

Helm Charts to run the Ozone hybrid version of Bahmni, meant to be deployed on the Mekom Portable.

### Getting the Helm Chart

```
helm repo add mekom https://nexus.mekomsolutions.net/repository/helm/
```

```
helm pull mekom/bahmni-helm
```

Note: Refer to [Appliance Deployments](https://github.com/mekomsolutions/appliance-deployment) for instructions of how to generate the executable to deploy the project.
