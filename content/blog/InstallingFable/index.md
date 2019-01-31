+++
title="F# and Fable Installfest!"
date=2019-01-30
draft=false
+++


<!-- read more -->

# Install F# with .net core

* Install .net core
* Install ionide  *and C#*
* Install "visual studio build tools" -> f# compiler

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