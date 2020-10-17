# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.7.2.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2-windowsservercore-ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download the Build Tools bootstrapper.
RUN curl -L https://aka.ms/vs/15/release/vs_buildtools.exe --output C:\TEMP\vs_buildtools.exe

# Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath C:\BuildTools --add Microsoft.VisualStudio.Workload.AzureBuildTools --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 --remove Microsoft.VisualStudio.Component.Windows81SDK  || IF "%ERRORLEVEL%"=="3010" EXIT 0
#ENV ROSLYN_COMPILER_LOCATION C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\Roslyn

# Define the entry point for the Docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat"]
