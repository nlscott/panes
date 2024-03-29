# A ruby gem to disable or enable system preference panes for macOS

> **Note:** This has not been fully tested since macOS 10.14. Some features will not work on macOS Ventura 13 or later due to changes in System Settings

For more usage see this [blog post](https://redlinetech.wordpress.com/2017/06/21/disable-system-preference-panes-in-macos/)

<img src="https://redlinetech.files.wordpress.com/2017/06/disabled.png?w=625">

##### To install:
```bash
sudo gem install panes
```

##### To verify:
```bash
gem list
```

---
## Usage:

Panes requires **sudo** access to read and write to the main plist file. You can run commands in two ways. From a ruby interactive shell, or running a ruby script directly from the command line.

##### Example 1: IRB

```ruby
sudo irb
require 'panes'
Panes.Disable("com.apple.preference.network")
```



##### Eaxmple 2: Run a ruby script from terminal

Put your commands in a ruby file and run it via the terminal. For example, create a file named "test-command.rb"

test-command.rb:

```ruby
#!//usr/bin/ruby

require 'panes'
Panes.Disable("com.apple.preference.network")
```
Run the command from terminal:
```bash
sudo ruby test-command.rb
```



You must require 'panes' in your ruby file. Then you can run the command below to see all your options.

```ruby
Panes.Options
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

---

# Examples ...

#### List CFBundleIdentifiers:

```ruby
puts Panes.CFBundleIdentifier
```
CFBundleIdentifier is a string usually in reverse DNS format, that specifies the specific app type of the bundle. Used in macOS to specify Applications.

---
#### Create a new "com.apple.systempreferences.plist":
```ruby
Panes.CreateProfile
```
If the file "/Library/Preferences/com.apple.systempreferences.plist" doesn't exist, it will be created.

There's no real reason to run this independently, it's used internally when the file isn't found.

---
#### Disable a Preference Pane:

The heart of this gem is the Disable method. It takes a specific CFBundleIdentifier or multiple CFBundleIdentifiers.

##### examples:
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
#### Enable a Preference Pane:
```ruby
Panes.Enable("com.apple.preference.network")
```
If you decide to enable a pane after it's been disable.

---
#### List all Preference Panes:
```ruby
Panes.List
```
you'll get a list of available preference panes:
> - Accounts.prefPane
> - Appearance.prefPane
> - AppStore.prefPane
> - Bluetooth.prefPane
> - and so forth ....

---
#### List Optional Preference Panes:
```ruby
puts Panes.OptionalCFBundleIdentifier
```
These are usually Panes that have been installed by a user like Adobe Flash or Oracle Java

  ##### example:
> - com.adobe.flashplayerpreferences
> - com.oracle.java.JavaControlPanel

---
#### List options:
```ruby
Panes.Options
```
Prints available methods

---
#### Reset all changes:
```ruby
Panes.Reset
```
This enables all panes and deletes the "/Library/Preferences/com.apple.systempreferences.plist" file
