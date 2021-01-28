# mathfp

Mathematics in Haskell, like, e.g., symbolic differentiation.

## Create

This project has simply been set up using the [The Haskell Tool Stack](https://docs.haskellstack.org) (see below) by

~~~shell
stack new --param author-email:50044800+popelde@users.noreply.github.com --param author-name:popelde --param category:Teaching --param year:2020 --param github-username:popelde mathfp new-template
~~~

There is absolutely no need to issue that command again.

## Install

Rather, install the [The Haskell Tool Stack](https://docs.haskellstack.org).
Then checkout the project and build it by issuing

~~~shell
stack build
~~~

If necessary, this installs appropriate versions of [The Glasgow Haskell Compiler](https://www.haskell.org/ghc/) and all neeeed packages.

For code highlighting, type insertion, display of compilation errors and warnings etc. from within [Visual Studio Code](https://code.visualstudio.com/) the extension [Haskell for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=haskell.haskell) is recommended. Furthermore, after

~~~shell
stack build hlint
stack build apply-refact
~~~

it will be possible to lint Haskell code with [HLint in Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=lunaryorn.hlint).

## Debug

The [Haskell GHCi Debug Adapter Phoityne](https://hackage.haskell.org/package/phoityne-vscode) is available as an [extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode) and is installed by

~~~shell
stack install phoityne-vscode haskell-dap
~~~

There are a few [sample debug configurations](https://github.com/phoityne/hdx4vsc/tree/master/configs), one of which you probably might want to [set up globally](https://code.visualstudio.com/docs/editor/debugging#_global-launch-configuration).

Since these configure Phoityne to store its log in ```.vscode/phoityne.log``` you might want to create an according folder withing your project:

~~~shell
mkdir .vscode
~~~~
