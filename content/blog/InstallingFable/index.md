+++
title="F# and Fable Installfest!"
date=2019-01-30
draft=false
+++

Starting from scratch lets set up a development environment for F#.  Following this will get you completely set up for command line tools, servers and web UI development.  I will not be covering desktop or mobile development but you should know that F# is excels in those domains.

<!-- more -->

# What is F#?

F# is a functional programming language that makes it easy to write correct and maintainable code.

# Install F# with .net core

* Install .net core
* Install ionide  *and C#*
* Install "visual studio build tools" -> f# compiler

# Mac
   * cd ~/Downloads
     curl -O https://download.mono-project.com/archive/5.18.0/macos-10-universal/MonoFramework-MDK-5.18.0.240.macos10.xamarin.universal.pkg
     sudo installer -pkg ~/Downloads/MonoFramework-MDK-5.18.0.240.macos10.xamarin.universal.pkg -target /
     cd -
   * https://www.mono-project.com/download/stable/#download-mac


## Build a new project (with tests)
* dotnet new console -lang f#
* dotnet build
* dotnet run
* dotnet new mstest -lang f#
* dotnet test
* dotnet watch *

==

# Fable

* Install node
    - https://nodejs.org/en/
    - scoop install nodejs
    - choco install nodejs
* Install yarn (Lets just prefer yarn)
    - scoop / choco
    - https://yarnpkg.com/en/docs/install#windows-stable
* Install fake 5
    - dotnet tool install -g fake-cli
    - (to update: dotnet tool update -g fake-cli)
* Templates
    - dotnet new -i safe.template
    - dotnet new safe -h
* 