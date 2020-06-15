# Github Action for Kubernetes CLI

-  image based on Alpine/k8s.

## Usage

`.github/workflows/eks.yml`

```hcl
on: push
name: deploy
jobs:
  deploy:
    name: Deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: deploy to cluster
      uses: qazz92/kubectl@1.0.3
      env:
        kube_confg_data: ${{ secrets.KUBE_CONFIG_DATA }}
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_DEFAULT_REGION }}
      with:
        args: set image --record deployment/my-app container=${{ github.repository
          }}:${{ github.sha }}
    - name: verify deployment
      uses: qazz92/kubectl@1.0.3
      env:
        kube_confg_data: ${{ secrets.KUBE_CONFIG_DATA }}
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_DEFAULT_REGION }}
      with:
        args: '"rollout status deployment/my-app"'
```

## Secrets

`KUBE_CONFIG_DATA` – **required**: A base64-encoded kubeconfig file with credentials for Kubernetes to access the cluster. You can get it by running the following command:

```bash
cat $HOME/.kube/config | base64
```

**Note**: Do not use kubectl config view as this will hide the certificate-authority-data.