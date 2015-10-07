# cloudstack-docker-sandbox

Apache CloudStack Sandbox

## Usage

1. `git clone https://github.com/atsaki/cloudstack-docker-sandbox.git`
2. `cd cloudstack-docker-sandbox`
3. `./bin/start_simulator`
4. Wait about 10-15 minutes
5. Open `http://localhost:8080/client`

## Pre-configured images

You can specify pre-configured image with tag.

`./bin/start_simulator TAG`

Currenty following tags are supported.
If tag is not specified, `4.5.2-advanced` is used by default.

* 4.5.2
    * No zone is configured
* 4.5.2-advanced
    * An advanced zone is configured with marvin
    * https://github.com/apache/cloudstack/blob/master/setup/dev/advanced.cfg
* 4.5.2-basic
    * A basic zone is configured with marvin
    * https://github.com/apache/cloudstack/blob/master/setup/dev/basic.cfg

## Tools

You can use following tools to manage and configure sandbox environment.

* jq
* cloudmonkey
* terraform

The tools work on simulator container specified by environmental variable
`CLOUDSTACK_SIMULATER_NAME`. If `CLOUDSTACK_SIMULATER_NAME` is empty, the tools
work on the container named `cloudstack`.

```sh
$ ./bin/start_simulator --name env01
$ export CLOUDSTACK_SIMULATER_NAME=env01
$ ./bin/cloudmonkey
```

### Terraform

You have to set API key and secret key to use CloudStack API.
`./bin/generate_terraform_tfvars` creates `terraform.tfvars`.

There are Some examples in `./terraform`.

```sh
$ cd ./terraform/advanced_simple
$ ../../bin/generate_terraform_tfvars
$ ../../terraform plan
$ ../../terraform apply
```

## Contributing

1. Fork tihs repository
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License

MIT
