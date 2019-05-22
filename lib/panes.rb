

require 'CFPropertyList'
require 'FileUtils'

module Panes
  #======================================================================
	# Variables

	PATHTOPLIST="/System/Library/PreferencePanes"
	PreferencePanes=Dir.entries("#{PATHTOPLIST}")

	# Print .prePanes in /System/Library/PreferencePanes folder
	def self.List
		list_of_panes=[]
		PreferencePanes.each do |prePane|
			if !prePane.start_with?(".")
				list_of_panes << prePane
			end
		end
		puts list_of_panes
	end

	#print CFBundleIdentifier for each item in /System/Library/PreferencePanes folder
	def self.CFBundleIdentifier
		list_of_panes=[]
		PreferencePanes.each do |prePane|
			if !prePane.start_with?(".")
				list_of_panes << prePane
			end
		end

		final_list=[]
		list_of_panes.each do |prePane|
			plist = CFPropertyList::List.new(:file => "#{PATHTOPLIST}/#{prePane}/Contents/Info.plist")
			results=CFPropertyList.native_types(plist.value)
			final_list << results["CFBundleIdentifier"]
		end
		return final_list
	end

	#print CFBundleIdentifier for items installed by the user, typical installs would be flash or java
	def self.OptionalCFBundleIdentifier
		optionalpanes=Dir.entries("/Library/PreferencePanes")

		list_of_panes=[]
		optionalpanes.each do |prePane|
			if !prePane.start_with?(".")
				list_of_panes << prePane
			end
		end

		final_list=[]
		list_of_panes.each do |prePane|
			plist = CFPropertyList::List.new(:file => "/Library/PreferencePanes/#{prePane}/Contents/Info.plist")
			results=CFPropertyList.native_types(plist.value)
			final_list << results["CFBundleIdentifier"]
		end
		return final_list
	end


	#creates an empty com.apple.systempreferences in tmp folder
	def self.CreateProfile
		profile = "/Library/preferences/com.apple.systempreferences.plist"
		new_profile = File.open(profile, "w")
		new_profile.puts '<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>DisabledPreferencePanes</key>
			<array>
			</array>
		</dict>
		</plist>
		'
		new_profile.close
		FileUtils.chmod(0644,"#{profile}")
	    FileUtils.chown 'root', 'wheel', "#{profile}"
	end

	#to restrict access to a preference pane, put the CFBundleIdentifier as the argument
	# example is Panes.Disable("com.apple.preference.network")
	def self.Disable(*prefs)

		if File.file?("/Library/preferences/com.apple.systempreferences.plist")
			preference_panes_to_disable =[]

			prefs.each do |x|
				preference_panes_to_disable << x
			end

			plist = CFPropertyList::List.new(:file => "/Library/preferences/com.apple.systempreferences.plist")
			results=CFPropertyList.native_types(plist.value)

			results["DisabledPreferencePanes"].each do |x|
				preference_panes_to_disable << x
			end

			preference_panes_to_disable.each do |x|
				indexnumber = preference_panes_to_disable.index(x)
				results["DisabledPreferencePanes"][indexnumber] = "#{x}"
			end

			plist.value = CFPropertyList.guess(results)
			plist.save("/Library/preferences/com.apple.systempreferences.plist", CFPropertyList::List::FORMAT_BINARY)
		else
			Panes.CreateProfile
			preference_panes_to_disable =[]

			prefs.each do |x|
				preference_panes_to_disable << x
			end

			plist = CFPropertyList::List.new(:file => "/Library/preferences/com.apple.systempreferences.plist")
			results=CFPropertyList.native_types(plist.value)

			results["DisabledPreferencePanes"].each do |x|
				preference_panes_to_disable << x
			end

			preference_panes_to_disable.each do |x|
				indexnumber = preference_panes_to_disable.index(x)
				results["DisabledPreferencePanes"][indexnumber] = "#{x}"
			end

			plist.value = CFPropertyList.guess(results)
			plist.save("/Library/preferences/com.apple.systempreferences.plist", CFPropertyList::List::FORMAT_BINARY)

		end
		command="sudo killall cfprefsd"
		system(command)
	end

	#to remove a restriction, put the CFBundleIdentifier as the argument
	def self.Enable(*prefs)
		if File.file?("/Library/preferences/com.apple.systempreferences.plist")
			plist = CFPropertyList::List.new(:file => "/Library/preferences/com.apple.systempreferences.plist")
			results=CFPropertyList.native_types(plist.value)
			prefs.each do |check_a|
				results["DisabledPreferencePanes"].each do |check_b|
					if check_a == check_b 
						results["DisabledPreferencePanes"].delete(check_a)
					end
				end
			end
			plist.value = CFPropertyList.guess(results)
			plist.save("/Library/preferences/com.apple.systempreferences.plist", CFPropertyList::List::FORMAT_BINARY)
			command="sudo killall cfprefsd"
			system(command)
		else
			puts "Error: no plist. Try running 'sudo killall cfprefsd' from the terminal"
		end
	end

	
	#reset all disable panes
	def self.Reset
		command="sudo rm -rf /Library/Preferences/com.apple.systempreferences.plist"
		system(command)
		cfprefsd="sudo killall cfprefsd"
		system(cfprefsd)
	end

	#to print all the availbe options to use with the Panes command
	def self.Options
		puts (Panes.methods - Object.methods).sort
	end
end
Panes.Disable("com.apple.preference.network")

