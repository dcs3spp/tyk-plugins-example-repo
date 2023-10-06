# Learning How TO Build Tyk plugins

## What I have done so far?

1. Used the docker pro demo and figured out how to use the httpbin API. _my_custom_key_ needs to be specified in the _Authorization_ header. This key needs to be documented!
2. Figured out how to bundle a plugin. I generated a manifest.json file and bundled the plugin files and the manifest into a bundle zip file. This took a long time! There is a docker utlity that Tyk provides to build a plugin as seen in the Makefile of this repo. The plugin has to built using the same version of Go that Tyk was compiled with. Also, the README for the Tyk repository does not state that Tyk 1.19 is used to build Tyk.
3. Added a nginx docker-compose service that will serve the bundle files from the plugins folder. I just want this to be a simple nginx http server for now. This is only a getting started, tutorial. It is not intended to be complex. Keep it simple and for development environment use initially.
4. Configured the Dashboard API to read the generated bundle for the plugin from the http server
5. Ran plugins for Go, Python and JVM and generated log ouput.

## What I want to do next?

- Use signed bundles (public key is GW configured), can it be per plugin, e.g. in manifest?
- JVM events?

## What problems did I encounter?

When I use the API debugger to debug a HTTP request I received this error:

```
2023-09-24 17:38:29 time="Sep 24 14:38:29" level=warning msg="plugin file middleware/bundles/1aab623a2842fad206d29c6f0e5906ab/logger-plugin_v5.1.2_linux_amd64_5.1.2_linux_arm64.so doesn't exist"
```

The Dashboard API debugger and log browser did not give a meaningful error, only Internal Server and Middleware Error. I had to inspect the docker-compose logs to find the above error. JVM errors were not available.

How do I solve this?

Do I need to do the go get TykTechnologies/tyk@<commit-hash> for tyk 5.1.2 plugin go.mod

Is there a working workflow defined anywhere?

This process worked but what made the difference? Was it it the docker platform added to the tyk-gateway service in the docker-compose?

1. Enabled bundle downloader in Tyk Gateway config
2. Initialised go module. Used `go get` to get commit hash for Tyk so that it matches matches tyk from gateway docker service
3. Used docker utility to compile the plugin and generate .so library file for the plugin. The docker plugin compiler has to be same version as GW and the same platform. Now, Tyk Gateway has the architecture amd64 so added platform amd64 to tyk-gateway service.
4. Used Tyk bundle build to produce the zip
5. Configured bundle plugin ID within the advanced config section for the API in the dashboard

## What next?

- Determine if it was platform that made the difference. Remove platform from the docker-compose stack in GW service
- Determine if it was go.mod dependencies from go get for GW. Backup the go.mod and then remove the deps and try with platform included

The plugin compiler only builds on amd64??? How to build on arm64

## GOLang

docker-compose services run in linux arm64 on macOS

The bundle build should be targeted for Tyk GW docker-compose architecture type. I suspect that, that is linux/arm64 5.1.2. This was the case.
The plugins docs should give an example of GOARCH and GOOS.

So:

1. Build the module as a plugin using the docker helper cli
2. Use the bundler to create the bundle
3. Update the API httpbin to ref bundle
4. Try and send a request and see if the plugin logs

If I moved the so file into a build folder and reference it, it failed. How do I specify a relative path in a manifest.json file?

The gateway downloads and extracts the bundle in the middleware folder by default. Each hook in the manifest file needs to have a name and path specfified. Tyk GW automatically expands filename in the path to be filename*<version>*<arch>.so. This needs to be made clear. Devx experience for new users.

## Python

There is no Python module available to install from Pip. The Python modules are integrated with Tyk Gateway source code
This degrades the DevX experience for autocomplete when using editors like PyCharm, VSCode, nvim, vim etc.

Could not get auth_check logging displayed?

## JVM

There is one plugin per filename. The filename has to be the same name as the middleware variable.

Pre and post middleware were logged, but response middleware not logged. Receive a 500 internal server error with no further
message as to why the error occurred in API debugger or log browser. Only get Middleware error or internal server error.

Which container do you inspect to troubleshoot JVM middleware errors? It is not logged in GW or Dashboard container.
I have used the API debugger and log browser dashboard but that only gives Internal Server or Middleware error.

After further reading of the docs I suspect that pre and post hooks are only available for JVM middleware?
There is also mention made of a system API to access session data etc. Where can I find the docs or source for this API?

Mention is also made of using JVM middleware for webhook/event handlers. Is there an example of this documented anywhere?

### Questions

- Typescript supported?
- System API for JVM documented?
- Example usage of JVM event handlers?

## Bundle Problems I Encountered

- Could only get RSA keys to work with bundler, not ECDSA. The key type and process for generating needs documenting.

