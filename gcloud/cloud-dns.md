# Cloud DNS
Official getting started => [here](https://cloud.google.com/dns/getting-started)

---
## gcloud dns
Here is a quick summary of the CLI (july 1st, 2015), the official is [here](https://cloud.google.com/sdk/gcloud/reference/dns/)
```
managed-zones          Manage your Cloud DNS managed-zones.
  - create
  - delete
  - describe
  - list

project-info           View Cloud DNS related information for a project.
  - describe

record-sets            Manage the record-sets within your managed-zones.
  - changes            View details about changes to your Cloud DNS record-sets.
      - describe
      - list
  - transaction        Make scriptable and transactional changes to your record-sets.
      - abort
      - add
      - describe
      - execute
      - remove
      - start
  - export
  - import
  - list

```

---
## Go in
0. **Prerequisites** (most of the prerequisites can be followed [here](http://github.com/tdeheurles/coreos-vagrant))
  - Create the corresponding project
  - Have a Google Cloud Account authorized for the project
  - Enable the DNS addon on the cluster (automatic for gke)
  - Install the [google cloud sdk](https://cloud.google.com/sdk/)
  - login to your account with CLI
  - Update executing
  ```bash
  gcloud components update dns
  ```
0. **Enable coud DNS API**
  - Go to [Gcloud console -> API](https://console.developers.google.com/project/epsilon-cloud-rnd/apiui/apiview/dns/overview?authuser=1), and activate the Cloud DNS API
0. **Create a zone**
  ```bash
  gcloud dns managed-zones create \
    --dns-name="example.com."     \
    --description="A test zone"   \
    examplezonename
  ```
0.
