# docker-cqlsh
Cqlsh in a container

Some reasons why you might be interested:

* Run `cql` files to load data to `cassandra` when it starts
* Execute remote commands without `exec` directly to `cassandra`

The default `CMD` command in the image will try to connect to `cassandra` using default `env vars`
and execute each `.cql` file found in the container `/scripts` path.

## Examples

<details>
  <summary>Standalone instance</summary>

Run a `cassandra` container and connect to it

```sh
$ docker run -d -p 9042:9042 cassandra
$ docker run --rm -it -e CQLSH_HOST=localhost --net=host nuvo/docker-cqlsh bash
bash-4.4$ cqlsh -e "show host;"
Connected to Test Cluster at localhost:9042.
```
</details>

<details>
  <summary>Kubernetes job</summary>

```yaml
apiVersion: batch/v1
king: Job
metadata:
  name: load-cql-files
spec:
  backoffLimit: 5
  activeDeadlineSeconds: 100
  template:
    spec:
      containers:
      - name: cqlsh
        image: nuvo/docker-cqlsh
        env:
        - name: CQLSH_HOST
          value: cassandra-svc
        volumeMounts:
        - mountPath: /scripts
          name: scripts
      volumes:
      - name: scripts
        configMap:
          name: cql-files
```
</details>

## About cqlsh

cqlsh is a Python-based command-line tool, and the most direct way to run simple CQL commands on a Cassandra cluster. 
This is a simple re-bundling of the open source tool that comes bundled with Cassandra to allow for cqlsh to be installed and run inside of virtual environments.
[source](https://pypi.org/project/cqlsh/)