# aerphanas.github.io

[![Author](https://img.shields.io/badge/author-aerphanas-red.svg)](https://github.com/aerphanas)
[![License](https://img.shields.io/badge/License-BSD--3--Clause-important)](https://github.com/aerphanas/aerphanas.github.io/blob/master/LICENSE)
[![pages-build-deployment](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/pages/pages-build-deployment)
[![Generate Pages](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/hakyll.yml/badge.svg)](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/hakyll.yml)

Static Site Powered by Hakyll

<details>
<summary>Translation :</summary>

- [en](https://github.com/aerphanas/aerphanas.github.io/blob/master/README.md)
- [id](https://github.com/aerphanas/aerphanas.github.io/blob/master/BACA-AKU.md)

</details>

## Table of contents
- [Description](#description)
- [Prerequisites](#prerequisites)
  - [Container](#container)
  - [How to use](#how-to-use-kompor)
- [Contribution](#contribution)

## Description

The purpose of this blog is to promote OpenSource and teach some tricks and tips on OpenSource in depth, ranging from history, type, configuration, etc..

## Prerequisites
Terms of the tools that must be installed before developing:

- cabal  >= 1.10
- GHC base == 4.*
- hakyll == 4.15.*

To install GHC and Cabal is recommended to use [GHCup](https://www.haskell.org/ghcup/) And Hakyll can be installed with a command

```sh
cabal update
cabal new-install hakyll
```

After installing the tools needed we only need clone github repo, by:

```sh
git clone https://github.com/aerphanas/aerphanas.github.io.git
```

then after that go to the directory ```aerphanas.github.io``` and do :

```sh
cabal new-install
```

after that a command will be made ```kompor```.

### Container

Here I will use Podman, to be able to produce static sites we need hakyll, we can get it with command:

```sh
podman build -t hakyll:latest -f Container.file
```

After we succeeded in making the Hakyll image we can only create a kompor image by:

```sh
podman build -t kompor:latest -f Containerfile.Kompor
```

After we succeeded in making the kompor image we can start with the command:

```sh
podman run --rm -v $PWD:/kompor localhost/kompor:latest build
```

or

```sh
podman run --rm -v $PWD:/kompor localhost/kompor:latest clean
```

#### How to use kompor
> note : must run in the folder ```aerphanas.github.io```

```sh
kompor build # builded site in ./doc folder
```

```sh
kompor clean # remove all file and folder in ./doc folder
```

```sh
kompor watch # Run the website interactively
             # Interactive here is that the web will automatically
             # change if there are files that change
```

```sh
kompor watch --host 10.11.53.122 --port 8080
             # Just like the above but rather than using IP 127.0.0.1 and Port 8000
             # We use IP 10.11.53.122 and Port 8080
```

## Contribution

1. Fork my github project to your github account
2. Make a new branch on forked repo with an informative name
3. Write something
4. Make a pull request
