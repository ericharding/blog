+++
title="Paket cheat sheet"
date=2019-11-13
draft=true
[taxonomies]
tags=[".NET", "F#"]
+++

A self-reference for common [paket](https://fsprojects.github.io/Paket/index.html) commands.

## Install
```
dotnet new tool-manifest
dotnet tool install paket
dotnet tool restore
```

Convert from nuget
```
dotnet paket convert-from-nuget
```
This adds an import for the paket target to the fsproj
```xml  
<Import Project=".paket\Paket.Restore.targets" />
```

## Restore

Install newly added packages.
```dotnet paket install```

Restore all packages from paket.lock
```
dotnet paket restore
```


## Update installed packages
dotnet paket outdated
dotnet paket update


## Add a group

```
echo "group [NAME]" >> paket.dependencies
dotnet paket install
```

## Add package to a group
```
dotnet paket add [NAME] -g [GROUP]
```