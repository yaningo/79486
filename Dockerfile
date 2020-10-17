# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.8
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
#SHELL ["cmd", "/S", "/C"]


# Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
ENV ChocolateyUseWindowsCompression true
RUN Start-Process powershell -Verb runAs
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN choco install -y visualstudio2017buildtools --includeRecommended --passive
ENV ROSLYN_COMPILER_LOCATION C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn

# Define the entry point for the Docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
#ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat"]
#CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
