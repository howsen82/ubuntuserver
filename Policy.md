##Useful group policies

1. **Policy Name:** Loopback Processing
   
   **Policy Location: `Computer Configuration | Policies | Administrative Templates | System | Group Policy | Configure user Group Policy loopback processing mode`**
   
   * Click on the **Enabled** option
   * Then, select `Merge` or `Replace` mode

2. **Policy Name:** Password Policy
   
   **Policy Location: `Computer Configuration | Policies | Windows Settings | Security Settings | Account Policies | Password Policy`**

   **Description**: This is one of the most commonly used group policies in an Active Directory environment. Passwords are no longer the best method for securing an account, but passwords are still widely used as the primary authentication method. When a system asks to set a password, as humans, we tend to use the easiest password we can remember. These passwords can also be easy for intruders to break. Using password policy, we can enforce complexity and other different standards on the user passwords. Under this policy, we have seven settings.

   **`Enforce Password History`**: This setting defines the number of unique passwords that need to be used before an old password can be reused. The value for this setting can be between 0 and 24.

   **`Maximum Password Age`**: This setting will define the validity period of a password before the system forces the user to change it. We can define any value between 0 and 999 here, but the default value is 42 days. It is recommended to use a value between 30 and 90.

   **`Minimum Password Age`**: This policy setting defines the number of days that must go by before a user can change their computer password. The default value for this is 1 day. If you are enabling the enforce password history setting, this value must be more than 0. Also, the value should be below the maximum password age value.

   **`Minimum Password Length`**: This setting defines the minimum number of characters a password should have. This can be any number between 0 and 14. It is recommended to use at least 8 characters for improved security.

   **`Minimum Password Length Audit`**: This setting can have a value between 1 and 128. When the value of this setting is greater than the Minimum Password Length value and the new user account password length is less than the value of this setting, an audit event will be issued. This is normally used when engineers want to evaluate the impact of using minimum password length settings.

   **`Minimum Password Length Audit`**: This setting can have a value between 1 and 128. When the value of this setting is greater than the Minimum Password Length value and the new user account password length is less than the value of this setting, an audit event will be issued. This is normally used when engineers want to evaluate the impact of using minimum password length settings.
   * The password cannot contain the username or part of the user's full name that exceeds two consecutive characters.
   * The password must be at least six characters (this will change if the minimum password length policy setting is specified).
   * The password must have at least three of the following
   * English uppercase characters
   * English lowercase characters
   * Base 10 digits (0-9)
   * Non-alphanumeric characters
   
   **`Store passwords using reversible encryption`**: This policy determines whether passwords need to be stored with reversible encryption. Some applications need to know the user's password for authentication. This policy should not be enabled unless it is an application requirement to encrypt the password.

   In the following table, I have listed a sample policy that we can use
   | **Setting**  | **Value**   |
   | ------------ | ------- |
   | Enforce Password History  | 24    |
   | Maximum Password Age | 30     |
   | Minimum Password Age    | 1    |
   | Minimum Password Length    | 8    |
   | Password must meet complexity requirements    | Enabled    |

3. **Policy Name**: Removable Storage Access
   
   **Policy Location: `Computer Configuration | Policies | Administrative Templates | System | Removable Storage Access`**

   **Description**: USB devices can be a source of malware and viruses. On corporate networks, they can also be used to steal sensitive data. Therefore, it is common security practice to disable USB access on corporate computers. There are a few different methods we can use to do this. We can use the registry entry to block it or we can use third-party software to block USB access.

   **`All Removable Storage classes: Deny all access`**: When you enable the policy setting, the system will block USB access to the device. If we disable the policy or set it to the Not configured value, USB access will be allowed and the system will have read/write permissions to the USB device.

4. **Policy Name**: Prohibit access to Control Panel and PC settings.
   
   **Policy Location: `User Configuration | Policies | Administrative Templates | Control Panel`**

   **Description**: We use a control panel on the PC to manage the hardware and OS settings. In a corporate environment, if users change the settings of the PC as they wish, it is hard to maintain standards, especially if the device is used by multiple users. As an example, if users are connecting to a WVD (Windows Virtual Desktop) or Citrix solution, we need to maintain configuration standards for every user. To do so, it's best to disable access to the control panel settings.

   We can control access to control panel and PC settings by using the following policy setting:

   **`Prohibit access to Control Panel and PC settings`**: To block access to control panel and PC settings, we need to enable this policy setting.

   Once this policy setting is enabled, control panel settings will be removed from the **Start screen and File Explorer**. Also, PC settings will be removed from **Start screen, Settings charm, Account picture**, and **Search result**.

5. **Policy Name**: Folder Redirection
   
   **Policy Location: `User Configuration | Policies | Windows Settings | Folder Redirection`**

   **Description**: In a PC, user settings and user files are, by default, saved inside the Users folder on the C:\ drive. This works well with standalone computers, but if users are logging in to different systems, it will be a nightmare to maintain settings and access to user files. Also, if a solution such as WVD or Citrix is in place, large numbers of users will appear on each session host server. If every user is saving files in their profile, it will be difficult to manage the storage requirements of session host servers. To address these sorts of issues, we have two options. We can use roaming profiles for users and redirect user profile data to a network location or else we can use **Folder Redirection** to redirect the path of known folder to a network location or specific folder on a local computer. We can also use both of these solutions together. By using both settings together, we can reduce the size of the roaming profile. To enable folder redirection, we have to use policy settings located under **`User Configuration | Policies | Windows Settings | Folder Redirection`**.

   We can enable folder redirection for the following list of folders.

   • AppData/Roaming
   • Contacts
   • Desktop
   • Documents
   • Downloads
   • Favorites
   • Links
   • Music
   • Pictures
   • Saved Games
   • Searches
   • Start Menu
   • Videos

   Each folder in the preceding list has the following settings when it comes to the target configuration.

   **`Basic—Redirect everyone's folder to the same location`**: By using this policy setting, we can force all redirected folders to save in the same location. These folders can be saved in a network location or a specific path in the hard drive.

   **`Advanced—Specify locations for various user groups`**: This policy setting helps to redirect folders to different locations based on security group memberships. As an example, we can say that Sales Group users should use the \\fileserver\salesfolders network share as the target, and Tech Group should use \\fileserver\techfolders as the target.

   **`Create a folder for each user under the root path`**: When choosing this setting for the target folder location, each user will have their own folder under the root folder.

   **`Redirect to the following location`**: By using this policy setting, we can force the system to use an explicit path for folder redirection. This way, users will share the same path for the redirection.

   **`Redirect to the local user profile location`**: This policy setting can be used to force the system to save data under the C:\Users folder.

   It is best to redirect folders to the network share and use `Create a folder for each user under the root path` to create a unique folder for each user. This way, it will be easy to manage as well as easy to troubleshoot if something goes wrong.

6. **Policy Name**: Turn off Windows Installer
   
   **Policy Location: `Computer Configuration | Policies | Administrative Templates | Windows Components | Windows Installer`**

   **Description**: On a PC, Windows Installer is responsible for installing, updating, and uninstalling applications. Users do not always need admin rights to install software; some applications can be installed in the current user context. In a corporate environment, if users have the ability to install applications on a PC as they wish, it will be difficult for engineers to maintain. Also, this can create security risks. Therefore, it is recommended to turn off the windows installer and this will prevent users from installing .msi packages. However, this will not prevent the installation of applications using other methods.

   To turn off the windows installer, we can use the following setting

   **`Turn off Windows Installer`**: To enable this policy setting, click on **Enable** in the settings window and then select `Always` under `Disable windows installer option`.

7. **Policy Name**: Do not store the LAN Manager hash value at the next password change
   
   **Policy Location: `Computer Configuration | Policies | Windows Settings | Security Settings | Local Policies | Security Options`**

   **Description**: Windows doesn't keep user passwords in cleartext format. It uses hash values instead. When the user changes their password, and provided it is less than 15 characters, the system generates an LM hash as well as an NT hash. Then, this hash value will be saved in the local SAM database or Active Directory.

   Note: If the password is longer than 15 characters, the LM hash will be set to a fixed value and it is equivalent to a null password. Therefore, any attempts to break the hash will be in vain.

   An LM hash is weak compared to an NT hash. As a security best practice, it is recommended to not save the LM hash in the local SAM database. We can do this using GPO. For that, we need to use the following policy setting:

   **`Network security: Do not store the LAN Manager hash value at the next password change`**: To enable this policy setting, click on Enable in the policy settings window.

8. **Policy Name**: Rename administrator account
   
   **Policy Location: `Computer Configuration | Policies | Windows Settings | Security Settings | Local Policies | Security Options`**

   **Description**: In the Active Directory environment, we should not only consider protecting Active Directory accounts, but we also need to consider the protection of local administrator accounts. A compromised local administrator account will allow attackers to later move within the network and gain access to more privileged Active Directory accounts. In computers, we have a default administrator account called Administrator. If we can change the name of this account, it will be slightly difficult for attackers to guess the user name of the local account. We can change the default name of the account by using Group Policy.

   **`Accounts: Rename administrator account`**: By using this policy setting, we can rename the administrator account. To enable this policy setting, click on `Define this policy setting` and then specify the new name for the administrator account. As a best practice, do not use a name that can be easily guessed, such as *Admin* or *LocalAdmin*.

9. **Policy Name**: Adding Trusted Sites
    
   **Policy Location: `Computer Configuration | Policies | Administrative Templates | Windows Components | Internet Explorer | Internet Control Panel | Security Page`**

   **`Site to Zone Assignment List`**: Set it to **Enabled**

10. **Policy Name**: Preset Wallpaper
    
    **Policy Location: `User Configuration | Policies | Administrative Templates | Desktop | Desktop`**

    **`Desktop Wallpaper`**: Set it to **Enabled**, select wallpaper path bring used.

11. **Policy Name**: Prevent shut down of system
    
    **Policy Location: `Computer Configuration (or User Configuration) | Policies | Administrative Templates | Start Menu and Taskbar`**

    **`Remove and prevent access to the Shut Down, Restart, Sleep, and Hibernate commands`**: Set it to **Enabled**

12. **Policy Name**: Interactive Logon
    
    **Policy Location: `Computer Configuration | Policies | Windows Settings | Security Settings | Local Policies | Security Options`**

    **`Interactive logon: Machine inactivity limit`**: Set it to **Enabled** and specified to **900** seconds (15 minutes)

13. **Policy Name**: Enable Screen Saver
    
    **Policy Location: `User Configuration | Policies | Administrative Templates | Control Panel | Personalization`**

    **`Enable screen saver`**: Set it to **Enabled**
    **`Force specific screen saver`**: Set it to **Use this to define which screen saver you want to run**
    **`Screen saver timeout`**: Set it to **Enabled** and specified to **900** seconds (15 minutes)
    **`Password protect the screen saver`**: Set it to **Enabled**

14. **Policy Name**: Powershell Policy
    
    **Policy Location: `Computer Configuration | Policies | Administrative Templates | Windows Components | Windows PowerShell | Turn on script execution`**

    **`Turn on script execution`**: Set it to **Enabled** and specified `Execution Policy` to **Allow local scripts and remote signed scripts**

15. **Policy Name**: Powershell Remoting
    
    **Policy Location: `Computer Configuration | Policies | Administrative Templates | Windows Components | Windows Remote Management (WinRM) | WinRM Service`**

    **`Allow remote server management through WinRM`**: Set it to **Enabled**

16. **Policy Name**: Server Firewall Rules
    
    **Policy Location: `Computer Configuration | Policies | Windows Settings | Security Settings | Windows Defender Firewall with Advanced Security | Windows Defender Firewall with Advanced Security`**