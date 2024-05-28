import os
import shutil


print("Adding secrets.yml to configuration...")
print("[and removing in-app options at the same time...]")

filepath="./Habitica.xcodeproj/project.pbxproj"

shutil.copy2(filepath, filepath+".bak")

search="""inputPaths = (
);
name = "Run SwiftGen";"""

replace="""inputPaths = (
 "$(SRCROOT)/secrets.yml",
);
name = "Run SwiftGen";"""



with open(filepath, "r") as file:
	lines=file.readlines()
	lines=list(map(lambda x: x.strip() if 'StoreKit.framework' not in x else "", lines))
	single_text="\n".join(lines)

with open(filepath, "w") as file:
	file.write(single_text.replace(search, replace))

print("Removing most features reserved to paid developer accounts...")


filepath="./Habitica.entitlements"
shutil.copy(filepath, filepath+".bak")

entitlements="""<key>aps-environment</key>
<string>development</string>
<key>com.apple.developer.applesignin</key>
<array>
<string>Default</string>
</array>
<key>com.apple.developer.siri</key>
<true/>
"""

with open(filepath, "r") as file:
	lines=file.readlines()
	lines=list(map(lambda x: x.strip(), lines))
	single_text="\n".join(lines)

with open(filepath, "w") as file:
	file.write(single_text.replace(entitlements, ""))
