# aerphanas.github.io

[![Author](https://img.shields.io/badge/author-aerphanas-red.svg)](https://github.com/aerphanas)
[![Generate Pages](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/hakyll.yml/badge.svg)](https://github.com/aerphanas/aerphanas.github.io/actions/workflows/hakyll.yml)

Static Site Powered by Hakyll

## Table of contents
- [Description](#description)
- [How to Generate site](#how-to-generate-site)
- [Contribution](#contribution)

## Description

The purpose of this blog is to promote OpenSource and teach some tricks and tips on OpenSource in depth, ranging from history, type, configuration, etc..

## How to Generate site
Terms of the tools that must be installed before developing:

- cabal  >= 1.10
- base   == 4.*
- hakyll == 4.15.*

After installing the tools needed we only need clone github repo, by:

```sh
git clone https://github.com/aerphanas/aerphanas.github.io.git
```

then after that go to the directory ```aerphanas.github.io``` and do :

```sh
cabal run -- kompor watch
```

## Contribution

1. Fork my github project to your github account
2. Make a new branch on forked repo with an informative name
3. Write something
4. Make a pull request
