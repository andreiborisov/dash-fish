# dash-fish

dash-fish is a toolchain for the generation of a [Dash](https://kapeli.com/dash) docset for the [fish shell](http://fishshell.com). It uses [Sphinx](https://www.sphinx-doc.org) to build HTML documentation from the source and [Dashing](https://github.com/technosophos/dashing) to generate the docset from it.

## Installation

Clone the repo with git:

```shell
git clone git@github.com:andreiborisov/dash-fish.git
```

### System requirements

Install the dependencies with [Homebrew](https://brew.sh) (recommended):

```shell
brew bundle
```

<details>
<summary>Not using Homebrew?</summary>

- - -

dash-fish requires:

* git 2.24+
* [git filter-repo](https://github.com/newren/git-filter-repo) 2.26+
* [Sphinx](https://www.sphinx-doc.org) 3+
* [Dashing](https://github.com/technosophos/dashing) 0.4+

</details>

## Usage

To generate the docset, run:

```shell
make build
```

This produces both the `fish.docset` itself and its archived version for submitting it to [Dash user contributions](https://github.com/Kapeli/Dash-User-Contributions).

- - -

dash-fish integrates docs source from [fish shell repo](https://github.com/fish-shell/fish-shell) in order to customise the Sphinx build by stripping out unnecessary elements.

To grab fresh commits from the upstream run:

```shell
make fetch_subtree
```

This will clone fish shell repo into a temporary folder, filter out unrelated commits and add related ones via git subtree. You can merge or rebase main branch after that and rebuild the docset:

```shell
git rebase fish-shell main
make build
```

To clean the working directory from build artifacts, run:

```shell
make clean
```

## License

dash-fish is licensed under the [MIT License](LICENSE).

fish shell docs and icon are licensed under the [GNU General Public License, version 2](https://fishshell.com/docs/current/license.html).
