+++
title=".NET Core Single Executable"
date=2019-05-17
draft=true
[taxonomies]
tags=[".NET", "F#"]
+++

With the release of .NET core 3.0.0 Preview 5 you can now publish your .net core applications as a single executable for Windows/Linux/Mac.  

This is a feature I've excited about so I thought I'd write a quick post exploring it a bit.  

<!-- more -->

https://devblogs.microsoft.com/dotnet/announcing-net-core-3-0-preview-5/

- building and running

- Caution: subject to change:
    - working directory
    - loading local files/resources
        - copy to output directory
    - Loading native assemblies
