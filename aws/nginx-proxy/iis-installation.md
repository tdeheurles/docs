## IIS scripted installation

Install documentation can be found [here](https://technet.microsoft.com/fr-fr/library/hh831475.aspx).

### For now, just copy this into an admin cmd

##### Install .NET 3.5
```bash
dism /online /enable-feature /featurename:netfx3 /all
```

##### Install IIS and ASP>NET modules

Note that this script is incomplete, ASP.NET 4.5 won't be installed. You should use the manual way for now.

```bash
Start /w pkgmgr /iu:IIS-WebServerRole;IIS-WebServer;IIS-CommonHttpFeatures;IIS-StaticContent;IIS-DefaultDocument;IIS-DirectoryBrowsing;IIS-HttpErrors;IIS-ApplicationDevelopment;IIS-ASPNET;IIS-NetFxExtensibility;IIS-ISAPIExtensions;IIS-ISAPIFilter;IIS-HealthAndDiagnostics;IIS-HttpLogging;IIS-LoggingLibraries;IIS-RequestMonitor;IIS-Security;IIS-RequestFiltering;IIS-HttpCompressionStatic;IIS-WebServerManagementTools;IIS-ManagementConsole;WAS-WindowsActivationService;WAS-ProcessModel;WAS-NetFxEnvironment;WAS-ConfigurationAPI
```
