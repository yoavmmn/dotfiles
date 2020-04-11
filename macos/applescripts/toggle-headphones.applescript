activate application "SystemUIServer"
tell application "System Events"
  tell process "SystemUIServer"
    -- Working CONNECT Script.  Goes through the following:
    -- Clicks on Bluetooth Menu (OSX Top Menu Bar)
    --    => Clicks on WH-1000XM3 Item
    --      => Clicks on Connect Item
    set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
    tell btMenu
      click
      tell (menu item "WH-1000XM3" of menu 1)
        click
        if exists menu item "Connect" of menu 1 then
          click menu item "Connect" of menu 1
          return "Connecting..."
        else
          if exists menu item "Disconnect" of menu 1 then
            click menu item "Disconnect" of menu 1
            return "Disconnecting..."
          else
            click btMenu -- Close main BT drop down if Connect/Disconnect wasn't present
            display dialog "Please check bluetooth devices."
          end if
        end if
      end tell
    end tell
  end tell
end tell