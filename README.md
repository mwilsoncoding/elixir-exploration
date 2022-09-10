# elixir-exploration

This repository aims to be a competent template for starting a new Elixir project.

Because this repo is Public, it has access to free tier GitHub services.

## GitHub Actions

This repo leverages Workflows in GitHub Actions to support building Elixir across the usual `dev`, `test`, and `prod` values of `MIX_ENV`

### CI

PRs are required to pass builds in all environments as well as the following tests:
- format checking
- unit tests
- dialyzer
- credo
- sobelow

### CD

PRs and updates thereto submit a `builder` image to this repository's `gcr.io` registry. This image is not considered production-ready as it contains much more than is needed at runtime.

Merges to `main` build and publish a production-ready image.

### Caching

Caching is accomplished through GitHub's cache action.

A cache is made per `MIX_ENV` per `ELIXIR_VERSION` in the `pr.yml` matrix.

A cache is also made on pushes to `main`.

## Dev Container

This repo includes a `devcontainer` definition for use with VSCode or GitHub Codespaces
