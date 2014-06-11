RCT2 Game Objects
=================

The following instructions show how to install these game objects.

1. Open PowerShell as administrator. You can do so by searching for "PowerShell" in the Start Menu, then right-clicking and selecting "Run as administrator".

1. Run the following command. This allows us to run local scripts.

    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```

1. Close PowerShell.

1. Open the Windows Command Prompt. You can start this by searching for "Command Prompt" in the Start Menu.

1. Visit the [Chocolatey web site][choco] and run the command listed there. Make sure not to copy the prompt `C:\>`. Chocolatey is a package manager for Windows that we will use to install several packages.

1. Close the Windows Command Prompt.

1. Open PowerShell, this time without administrator privileges.

1. Use Chocolatey to install Git, or install [GitHub for Windows][gh-win].

    ```powershell
    chocolatey install git
    ```

    Set up Git using [GitHub's setup guide][gh-setup] if you installed the command-line version.

1. Use Chocolatey to install the PowerShell Community Extensions.

    ```powershell
    chocolatey install pscx
    ```

1. For PSCX to be detected, you must log in and log back out. Do so now.

1. Install RCT2 with GoG installer. Click *Options* when the installer opens. Disable Foxit from being installed. Also change the installation directory to `C:\Users\Me\Applications\RCT2`, replacing `Me` with the name of your user. Changing the installation directory is not mandatory.

1. Clone the game objects repo using Git.

    ```
    git clone git@github.com:seanfisk/rct2-game-objects.git
    ```

1. Install the RCT2 User-Created Expansion Set (UCES) to the directory where you installed RCT2. The UCES installer is bundled with the game objects repository.

1. Install more scenarios and tracks by running the linking script.

    ```powershell
    .\LinkObjects.ps1 ~\Applications\RCT2
    ```

1. Clone the saved games repo using Git.

    ```
    git clone git@github.com:seanfisk/rct2-saved-games.git
    ```

1. Run the linking script to install our saved games.

    ```powershell
    .\LinkDirectory.ps1 ~\Applications\RCT2
    ```

1. Start RCT2 and enjoy!

[choco]: http://chocolatey.org/
[gh-win]: https://windows.github.com/
[gh-setup]: https://help.github.com/articles/set-up-git

Issues
------

This setup has seen a couple issues, but nothing serious that can't be worked around.

* **RCT2.exe has stopped working**

    Sometimes, using Git or links with RCT2 (we think) causes it to crash when switching applications or upon exit. To mitigate the risk of losing your changes, **always save your game before you exit or switch out of RCT2.** When following this advice, we have not really had problems.

* **Saved games with custom objects fail to load.**

    This can happen with some UCES-created scenarios. To get these to work, just start a new game of the same park to load the objects. Exit that immediately, then load the saved game.