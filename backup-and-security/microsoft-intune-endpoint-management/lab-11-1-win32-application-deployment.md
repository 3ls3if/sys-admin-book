# Lab 11.1 - Win32 Application Deployment

## Objective and prerequisites

Package and deploy a silent Win32 application. You need an enrolled Windows test device, Intune app permissions, a Windows packaging workstation, legitimate MSI/EXE installer with documented silent switches, and Microsoft's Win32 Content Prep Tool: https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool.

## Package

Create C:\IntuneAppLab\Source, Output, and Tools. Place the installer and required supporting files in Source. Run IntuneWinAppUtil.exe with -c pointing to Source, -s ContosoApp.msi, and -o pointing to Output. The expected output is ContosoApp.intunewin.

## Create the app

1. In Intune, open Apps → All apps → Create → Windows app (Win32).
2. Upload the .intunewin package and name it APP-11-WIN-ContosoApp.
3. Configure publisher and description.
4. Use the vendor-documented silent install command, such as msiexec /i ContosoApp.msi /qn /norestart for an MSI.
5. Configure a real uninstall command and choose System install behavior only when machine-wide installation is intended.
6. Configure accurate OS/architecture requirements and MSI product-code or file/registry detection.
7. Assign as Required only to the test device group.

## Validation

Check the Intune device install status. On Windows, check the IntuneManagementExtension service and logs under C:\ProgramData\Microsoft\IntuneManagementExtension\Logs. Confirm the app is actually installed and detection is correct.

## Troubleshooting

Review IME logs, installer exit codes, requirements, execution context, network access, and detection. An installer can exit successfully while detection still fails.

## Security and rollback

Verify publisher signature and source. Test uninstall first. Removing a Required assignment does not uninstall an installed app; use a validated Uninstall assignment or vendor removal command.

## Exercise

Deploy a test MSI as Required, prove detection, then remove it using an Uninstall assignment.
