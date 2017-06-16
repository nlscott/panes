# A ruby gem to disable or enable system preference panes for macOS

This is tested on macOS 10.12 - 10.12.5. It may or may not work on other OS versions.

#### To install:
```bash
sudo gem install panes
```

#### To verify:
```bash
gem list
```

---
#### Usage:
You must require 'panes' in your ruby file. Then you can run the command below to see all your options.
```ruby
puts Panes.Options
```
This will return:
> - CFBundleIdentifier
> - CreateProfile
> - Disable
> - Enable
> - List
> - OptionalCFBundleIdentifier
> - Options
> - Reset

#### Examples ...
See [this blog post](https://redlinetech.wordpress.com/2017/05/17/organizing-commands-in-apple-remote-desktop-with-the-help-of-ruby/) or the below examples:

####List CFBundleIdentifiers:

```ruby
puts Panes.CFBundleIdentifier
```
CFBundleIdentifier is a string usually in reverse DNS format, that specifies the specific app type of the bundle. Used in macOS to specify Applications.

---
####Create a new "com.apple.systempreferences.plist":
```ruby
puts Panes.CreateProfile
```
If the file "/Library/Preferences/com.apple.systempreferences.plist" doesn't exist, it will be created.

There's no real reason to run this independently, it's used internally when the file isn't found.

---
####Disable a Preference Pane:

``` ruby
puts Panes.Disable(CFBundleIdentifier)
```
The heart of this gem is the Disable method. It takes a specific CFBundleIdentifier or multiple CFBundleIdentifiers.
#####examples:
```ruby
#to disable one Pane
Panes.Disable("com.apple.preference.network")
```
```ruby
#to disable multiple Panes, use comma separated list
Panes.Disable(
 "com.apple.preference.network",
 "com.apple.preferences.Bluetooth")
```
---
####Enable a Preference Pane:
```ruby
puts Panes.Enable("com.apple.preference.network")
```
If you decide to enable a pane after it's been disable.

---
####List all Preference Panes:
```ruby
puts Panes.List
```
you'll get a list of available preference panes:
> - Accounts.prefPane
> - Appearance.prefPane
> - AppStore.prefPane
> - Bluetooth.prefPane
> - and so forth ....

---
####List Optional Preference Panes:
```ruby
puts Panes.OptionalCFBundleIdentifier
```
These are usually Panes that have been installed by a user like Adobe Flash or Oracle Java

  #####example:
> - com.adobe.flashplayerpreferences
> - com.oracle.java.JavaControlPanel

---
####List options:
```ruby
puts Panes.Options
```
Prints available methods

---
####Reset all changes:
```ruby
puts Panes.Reset
```
This enables all panes and deletes the "/Library/Preferences/com.apple.systempreferences.plist" file
