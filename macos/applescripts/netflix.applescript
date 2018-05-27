tell application "Safari"
  open location "https://www.netflix.com"
  activate
  
  -- wait until the logo element is loaded,
  -- assuming the rest of the elements are being loaded with the logo
  repeat until (do JavaScript "document.querySelector('.logo').attributes['aria-label'].value" in current tab of window 1) as text is "Netflix"
    delay 1
  end repeat
  
  -- click on my profile if profiles screen was opened
  do JavaScript "document.querySelectorAll('.profile-name').forEach(name => {
    if (name.textContent === 'Yoav') {
      name.parentElement.click();
    }
  });" in current tab of window 1
end tell
