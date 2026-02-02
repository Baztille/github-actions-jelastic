# GitHub action for Jelastic CLI
Performs some actions via Jelastic CLI via API

## About This Fork

This is a fork of the original [DovnarAlexander/github-actions-jelastic](https://github.com/DovnarAlexander/github-actions-jelastic) repository. The fork was necessary for the following reasons:

- **Original repository no longer maintained**: The upstream repository is no longer actively supported
- **Broken Docker image**: The original Dockerfile used a `FROM` image that no longer exists, causing build failures
- **Updated base image**: Migrated to `eclipse-temurin:17-jdk-alpine` for a modern, maintained Java runtime
- **Fixed Jelastic CLI installation**: The CLI installer was failing silently. Added proper error handling, moved installation files to correct locations, and fixed broken symlinks
- **Enhanced error handling**: Improved error messages and debugging capabilities in the entrypoint scripts

## GitHub actions
### Inputs
#### `jelastic_url`
**Required**Jelastic API URL
#### `jelastic_username`
**Required**Jelastic Username
#### `jelastic_password`
**Required**Jelastic Password or API Token
#### `task`
**Required**Task to execute. More info [here](https://docs.jelastic.com/cli/).
### Outputs
#### `output`
Result JSON document returned from Jelastic.
### Example usage
```yaml
  - name: Run GetEnv command
    uses: DovnarAlexander/github-actions-jelastic@master
    with:
      jelastic_url: app.mycloud.by
      jelastic_username: ${{ secrets.JELASTIC_USERNAME }}
      jelastic_password: ${{ secrets.JELASTIC_TOKEN }}
      task: environment/control/getenvs
```
## Local usage
### Information
Docker's entrypoint expects 3+ arguments specified.
```bash
docker run --rm --env JELASTIC_URL --env JELASTIC_USERNAME --env JELASTIC_PASSWORD aliaksandrdounar/jelastic-cli:latest true true environment/control/getenvs
```
Where:
- `true` - login to Jelastic Cloud
- `true` - print json output (instead of raw from the API)
- `environment/control/getenvs` - command
### Preparation
```bash
export JELASTIC_URL=<jelastic_api_fqnd>
export JELASTIC_USERNAME=<your_username>
export JELASTIC_PASSWORD=<your_password>
```
### Use from DockerHub
```bash
docker run --rm --env JELASTIC_URL --env JELASTIC_USERNAME --env JELASTIC_PASSWORD aliaksandrdounar/jelastic-cli:latest true true environment/control/getenvs
```
### Use from GitHub
```bash
echo TOKEN | docker login https://docker.pkg.github.com -u USERNAME --password-stdin
docker run --rm --env JELASTIC_URL --env JELASTIC_USERNAME --env JELASTIC_PASSWORD docker.pkg.github.com/dovnaralexander/jelastic-docker-image/jelastic-cli:latest true true environment/control/getenvs
```
