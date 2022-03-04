# Turn display off by calling WindowsAPI.
# PostMessage(HWND_BROADCAST,WM_SYSCOMMAND, SC_MONITORPOWER, POWER_OFF)
# HWND_BROADCAST	0xffff
# WM_SYSCOMMAND	0x0112
# SC_MONITORPOWER	0xf170
# POWER_OFF	      0x0002

if (-not ($env:POWEROFF_SCREEN_DEFINED)) {
  Write-Host Defining Power Off
  Add-Type -TypeDefinition '
  using System;
  using System.Threading;
  using System.Runtime.InteropServices;

  namespace Utilities {
    public static class Display
    {
      [DllImport("user32.dll", CharSet = CharSet.Auto)]
      private static extern IntPtr PostMessage(
        IntPtr hWnd,
        UInt32 Msg,
        IntPtr wParam,
        IntPtr lParam
      );

          public static void PowerOff ()
          {
              // Thread.Sleep(200);Thread.Sleep(200);Thread.Sleep(200); //let events finish. small sleeps to avoid thread hanging.
              PostMessage(
                  (IntPtr)0xffff, // HWND_BROADCAST
                  0x0112, 	      // WM_SYSCOMMAND
                  (IntPtr)0xf170, // SC_MONITORPOWER
                  (IntPtr)0x0002  // POWER_OFF
              );

              // Thread.Sleep(200);          //smooth-out event-calls.
      
              // Environment.ExitCode = 0;   //program always ends with success, regardless of the PostMessage result.
              // Environment.Exit(0);        //explicit exit the program (unload).
          }
    }
  }
  '
  $env:POWEROFF_SCREEN_DEFINED = $true
}
[Utilities.Display]::PowerOff()