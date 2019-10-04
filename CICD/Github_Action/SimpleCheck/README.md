# Kubernetes Security Config Watch

This simple git action runs sysdig's security linter against any proposed kubernete configuration fires.  Assuming one has a default Github Actions configuration, a pull request will be generated to take corrective action(s.)


# Inputs

## `src`

## `trgt`


## Example CI job
 
```
# checkout master branch
- uses: actions/checkout@v2
    with:
      ref: master
      path: master
# checkout the pull request branch to inspect
- uses: actions/checkout@v2
    with:
      path: candidate
      ref: ${{ github.event.pull_request.head.sha }}
# configure the source for the configuration files to inspect
- name: Kubes operational security linting
  uses: sysdiglabs/k8s-security-lint@latest
  with:
    src: '/truth/yamls'
    trgt: '/fakenews/yamls'
# generate the report.  put your notification method in here as appropriate including slack or mattermost notification webhooks
- name: Kubernetes privileges spot check 
  run: |
    echo ${{ toJSON(steps.k8s_privilege_check.outputs.escalation_report) }}
```


## Outputs

### `escalation_report`
```
{
  "total_source_workloads": 4,
  "total_target_workloads": 4,
  "total_source_images": 3,
  "total_target_images": 3,
  "escalation_count": 1,
  "reduction_count": 1,
  "escalations": [
    {
      "name": "apache",
      "kind": "Pod",
      "namespace": "default",
      "file": "httpd.yaml"
    },
    {
      "name": "mysql",
      "kind": "Pod",
      "namespace": "default",
      "file": "mysql.yaml"
    },
    {
      "name": "vulnerable-container",
      "kind": "Pod",
      "namespace": "hackme",
      "file": "dontdeploymeprod.yaml"
    }
  ],
  "reductions": [
    {
      "name": "vulnerable-container",
      "kind": "Pod",
      "namespace": "hackme",
      "file": "dontdeploymeprod.yaml"
    }
  ],
  "new_privileged": {
    "status": "Escalated",
    "previous": "false",
    "current": "true",
    "workloads": [
      {
        "name": "apache",
        "kind": "Pod",
        "namespace": "default",
        "file": "httpd.yaml",
        "image": "projectnexus/httpd"
      }
    ],
    "workloads_count": 1
  },...
}
```

