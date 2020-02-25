+++
title="Paket cheat sheet"
date=2019-11-13
[taxonomies]
tags=[".NET", "F#"]
+++

A self-reference for common [Paket](https://fsprojects.github.io/Paket/index.html) commands.

<!-- more -->

There are some advantages to Paket over Nuget.  Right now I still prefer Nuget when starting projects but I can see how Paket would be advantageous for larger ones where the advanced dependency resolution would have a chance to shine.  There are a also lot of open source F# projects and templates that use Paket so it's useful to have a working knowledge of it.

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


## Update Installed Packages

List packages that have an update available.

```
dotnet paket outdated
```

Update all installed packages.
```
dotnet paket update
```


## Add a Group

[Groups documentation](https://fsprojects.github.io/Paket/groups.html)

```
echo "group [NAME]" >> paket.dependencies
dotnet paket install
```

To list the groups the application uses
```
dotnet paket show-groups
```

## Add Package To a Group
```
dotnet paket add [NAME] -g [GROUP]
```
