function Show-Window {
    Param([string]$Name)

    Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        public class WinApp {
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool SetForegroundWindow(IntPtr hWnd);
            
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
            
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool IsIconic(IntPtr hWnd);    // Is the window minimized?
        }
"@

    $p = Get-Process | Where-Object { $_.mainWindowTitle } | Where-Object { $_.Name -like $Name }
    if ($null -eq $p) {
        Start-Process $Name
        return
    }
    $h = $p.MainWindowHandle
    $num = 8 # 8 for Maximize
    [void] [WinApp]::SetForegroundWindow($h)
    if ([WinApp]::IsIconic($h)) {
        $num = 9 # 9 for Minimize 
    }
    [void] [WinApp]::ShowWindow($h, $num)
}

