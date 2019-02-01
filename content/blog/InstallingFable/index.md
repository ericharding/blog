+++
title="F# and Fable Installfest 2019"
date=2019-02-01
draft=true
+++

Starting from scratch lets set up a development environment for F#.  Following this will get you completely set up for command line tools, servers and web UI development.  I will not be covering desktop or mobile development but you should know that F# also excels in those domains.

I will go thorugh setting up Visual Studio Code because that's what I use.  You could also use [Visual Studio](https://visualstudio.microsoft.com/) or [Jetbrains Rider](https://www.jetbrains.com/rider/).  

<!-- more -->

# MacOS?
If you're on MacOS {{icon(name="fas fa-apple-alt")}} (or Linux {{icon(name="fab fa-linux")}}) the steps will be very similar. I will try to point out where you need to do something different if you're not using Windows but there may be errors since I don't have a mac to test it on.  If you follow the instructions on a mac and they don't work please email or tweet me and let me know.

# Install F# with .net core

## Step 1 - Install .NET Core SDK
The first thing you need to do is install the .NET Core SDK.  This gives you a set of command line tools for creating projects managing depdendencies and building.

Go to [http://dot.net](http://dot.net) and click download then choose "Download .NET Core SDK".  It should automatically select the right version for the OS you're running.  When you install it should automatically add the `dotnet` command to your path.  

If you already have a version of .NET Core installed this will update to the latest and add it to your path.  It will leave the old version available in case something still needs it.

[![download .net](./dotnet.png)](http://dot.net)

If you're feeling impatient you can go ahead and start on step 2 while the download finishes.

## Step 2 - Install Visual Studio Code and Ionide

* Install Visual Studio Code from [http://code.visualstudio.com](https://code.visualstudio.com/)
* Inside VSCode click the puzzle piece on the left to open the extensions panel ![puzzle piece?](puzzle_piece.png)
  Then install the Ionide:
  ![ionide](ionide.png)
  and C# extensions:
  ![csharp](csharp.png)
  When both extensions are installed click 'reload'

The C# extension is needed because it includes debugger support for .net core.  Ionide has all the language support for F# syntax coloring and code completion.

At this point you have a working F# compiler and IDE.  The only thing missing is the [F# interactive](https://docs.microsoft.com/en-us/dotnet/fsharp/tutorials/fsharp-interactive/) REPL (read-eval-print loop) which is not available in .NET Core **yet** (work is underway).

## Step 3 - F# Interactive 

To enable F# interactive you need either the [Visual Studio Build Tools](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15) {{icon(name="fab fa-windows")}} or [Mono](https://www.mono-project.com/download/stable/#download-mac) {{icon(name="fas fa-apple-alt")}}{{icon(name="fab fa-linux")}}.

### Visual Studio Build Tools  (Windows)
* Download and launch [vs_buildtools.exe](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15)
* Select the 'Individual components' tab along the top of the top of the installer.
* Scroll down and select 'F# compiler' and click install
![F# compiler](vs_build_tools.png)
* Restart or Reload Visual Studio Code

### Mono (Mac/Linux)
* Graphical way
    - Download and install [Mono](https://www.mono-project.com/download/stable/#download-mac).  Either channel is fine.
    [![](mono.png)](https://www.mono-project.com/download/stable/#download-mac)
* Command line way
    ```bash
    cd ~/Downloads
    curl -O https://download.mono-project.com/archive/5.18.0/macos-10-universal/MonoFramework-MDK-5.18.0.240.macos10.xamarin.universal.pkg
    sudo installer -pkg ~/Downloads/MonoFramework-MDK-5.18.0.240.macos10.xamarin.universal.pkg -target /
    ```
* Restart or Reload Visual Studio Code

# Interlude
Now we have a complete F# development environment.  Lets take it for a spin before we install Fable.

If you have any command prompts open from before install you should close and re-open them to update the path environment variable.

Lets create a new project using the dotnet command line tool.

```cmd
c:\Users\F# User> cd Documents
c:\Users\F# User> mkdir TestProject
c:\Users\F# User> cd TestProject
c:\Users\F# User> dotnet new console -lang f# -n MyApp
The template "Console Application" was created successfully.

Processing post-creation actions...
Running 'dotnet restore' on MyApp\MyApp.fsproj...
  Restoring packages for C:\Users\F# User\Documents\TestProject\MyApp\MyApp.fsproj...
  Generating MSBuild file C:\Users\F# User\Documents\TestProject\MyApp\obj\MyApp.fsproj.nuget.g.props.
  Generating MSBuild file C:\Users\F# User\Documents\TestProject\MyApp\obj\MyApp.fsproj.nuget.g.targets.
  Restore completed in 141.46 ms for C:\Users\F# User\Documents\TestProject\MyApp\MyApp.fsproj.

Restore succeeded.

c:\Users\F# User> cd MyApp
c:\Users\F# User\MyApp> 
```
To build the app just use `dotnet build`.  To run it use `dotnet run`.  Run will automatically build the app if it is out of date.
```cmd
C:\Users\F# User\Documents\TestProject\MyApp>dotnet build
Microsoft (R) Build Engine version 15.9.20+g88f5fadfbe for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Restore completed in 22.74 ms for C:\Users\F# User\Documents\TestProject\MyApp\MyApp.fsproj.
  MyApp -> C:\Users\F# User\Documents\TestProject\MyApp\bin\Debug\netcoreapp2.1\MyApp.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:02.12

C:\Users\F# User\Documents\TestProject\MyApp>dotnet run
Hello World from F#!
```
The dotnet command line tool includes feature to add packages, run tests, and a lot of other stuff that is out of scope for this blog post. You can see a complete list of the options [here on the Microsoft documentation site](https://docs.microsoft.com/en-us/dotnet/core/tools/?tabs=netcore2x).

You should be able to open this project in Visual Studio Code and edit, compile and debug.  If you opted to add visual studio code to your path during install you can open it from the command line using `code .`
![](hello_world.png)
*Personally*, the first thing I do when starting a command line project is delete all the noise that comes with the default console template.  If you don't define a `main` function F# will start execution at the start of the last file in the project.
```fsharp
printfn "Hello world from F#"
```

=======

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