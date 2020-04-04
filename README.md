# wrt.helpers

| branch      | status                                                                                         |
| ----------- | ---------------------------------------------------------------------------------------------- |
| master      | ![](https://github.com/wortell/wortell-helpers/workflows/Build-Module/badge.svg?branch=master) |


PowerShell is a task-based command-line shell and scripting language built on .NET. PowerShell helps system administrators and power-users rapidly automate tasks that manage operating systems (Linux, macOS, and Windows) and processes.  
PowerShell commands let you manage computers from the command line.  
PowerShell providers let you access data stores, such as the registry and certificate store, as easily as you access the file system.  
PowerShell includes a rich expression parser and a fully developed scripting language.

## Why this PowerShell Module
Consistency is the main goal of the module.  This module will greatly reduce redundant code for deployment and configuration projects or even day to day administration tasks.  Several different projects pick up knowledge about techniques that are randomly used by anyone.  
In some way we need to adopt and share that knowledge and take with us to the next project. 

We would like the code to be Windows Powershell 4.0 compatible. As because of the goal of this project, it is to be usable at least on current supported OS that come with PowerShell pre-installed. [MSdocs information on versions](https://docs.microsoft.com/en-us/powershell/scripting/install/windows-powershell-system-requirements)

Anyone who sees something is missing out or like to share bits or piece of code is welcome to create a PR. 

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.
If you want to start and learn about Powershell you really should visit the following site [Getting started with Windows PowerShell] (https://docs.microsoft.com/powershell/scripting/getting-started/getting-started-with-windows-powershell)

### Prerequisites
If you are using Windows® 8.1 and Windows Server® 2012 R2 or newer your system include all required programs.  
If you are using Windows 7 SP1 [OS support warning](https://www.microsoft.com/windows/windows-7-end-of-life-support-information) or Server 2008 R2 [OS support warning](https://www.microsoft.com/cloud-platform/windows-server-2008) you could install PowerShell Core. [Visit installing PowerShell Core](https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7)  

### Installing

You can install the latest version of Wortell Helpers module from [PowerShell Gallery](https://www.powershellgallery.com/packages/wrt-helpers)

```PowerShell
Install-Module wrt.helpers -Scope CurrentUser -Force
```
## Find us

* [Wortell](https://security.wortell.nl/)
* [GitHub](https://github.com/wortell/wortell-helpers)
* [PowerShell Gallery](https://www.powershellgallery.com/packages/wrt-helpers)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Contributors

* A big thank you goes out to [@bgelens](https://github.com/bgelens) and [@pkhabazi](https://github.com/pkhabazi) for their contributions!

## Authors

* **Maurice de Jong** - *Developer and Maintainer* - [GitHub](https://github.com/MauRiEEZZZ) / [Blog](https://mcpforlife.com)

See also the list of [contributors](https://github.com/wortell/wortel-helpers/contributors) who participated in this project.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/wortell/wrtell-helpers/tags).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Hat tip to anyone whose code was used!

