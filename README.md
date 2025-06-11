# Zookeeper Four-Letter Command Utility (`zcheck`)

This utility lets you easily send Zookeeper four-letter commands from any PowerShell terminal using a simple `zcheck` command.

---

## Setup Instructions

### 1. Place the Script

Copy `zcheck.ps1` to a location accessible from your system. This guide assumes it is at `C:\zcheck.ps1` (as in this repo). If you use a different path, update the profile function accordingly.

### 2. Add the `zcheck` Function to Your PowerShell Profile

The `zcheck` function makes the script callable from any PowerShell window. To add it:

#### Option A: Manually Edit Your Profile

1. Open PowerShell.
2. Run:
   ```powershell
   notepad $PROFILE
   ```
3. Copy the contents of `Microsoft.Powershell_profile(zcheck-cmd).ps1` from this repo and paste it at the end of your profile file.
4. Save and close Notepad.

#### Option B: Append Automatically (Recommended)

From the repo directory, run:
```powershell
 Get-Content '.\Microsoft.Powershell_profile(zcheck-cmd).ps1' | Add-Content $PROFILE
```

### 3. Reload Your Profile

After editing, reload your profile in the current PowerShell session:
```powershell
. $PROFILE
```

---

## Usage

The basic syntax is:
```powershell
zcheck <zookeeper_host> <port> <command>
```

- `<zookeeper_host>`: Hostname or IP of the Zookeeper server
- `<port>`: Zookeeper port (usually 2181)
- `<command>`: One of the supported four-letter commands (see below)

### Examples

Check if Zookeeper is running:
```powershell
zcheck localhost 2181 ruok
```

Get server stats:
```powershell
zcheck 192.168.1.10 2181 stat
```

Show environment info:
```powershell
zcheck my-zk-host 2181 envi
```

---

## Supported Commands

| Command | Description |
|---------|-------------|
| conf    | Print details about serving configuration. |
| cons    | List full connection/session details for all clients. |
| dump    | List outstanding sessions and ephemeral nodes (leader only). |
| envi    | Print details about serving environment. |
| ruok    | Test if server is running in a non-error state. |
| srvr    | List full details for the server. |
| stat    | List brief details for the server and connected clients. |
| wchs    | Brief info on watches for the server. |
| wchc    | Detailed info on watches by session. |
| wchp    | Detailed info on watches by path. |
| mntr    | Outputs variables for monitoring cluster health. |

If you enter an unsupported command, `zcheck` will show usage info and a list of valid commands.

---

## Error Handling & Troubleshooting

- **Unknown host**: If the hostname cannot be resolved, you'll see `Unknown host: <host>`.
- **Connection refused**: If the port is wrong or Zookeeper is not running, you'll see `Unknown connection or port: <host>:<port>`.
- **Timeouts**: If the server does not respond within 30 seconds, you'll see a timeout message.
- **Invalid arguments**: If you omit required arguments or use an invalid command, usage info and help will be shown.

---

## Customization

- If you move `zcheck.ps1` to a different location, update the path in the `zcheck` function in your profile.
- You can add aliases or further wrap the function as needed for your workflow.

---

## Uninstalling

To remove the utility, simply delete the `zcheck` function from your PowerShell profile and remove the `zcheck.ps1` script.

---

## Reference
- [Zookeeper Four Letter Words](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_zkCommands)

---

**Enjoy quick Zookeeper checks from any PowerShell terminal!**
