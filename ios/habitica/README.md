
# Habitica-iOS scripts

Scripts under this folder are used to convert the **amazing** (Habitica-iOS' XCode project)[https://github.com/HabitRPG/habitica-ios] to allow for
self-hosted deployment *without* an paid *Apple Developer* membership.

# Known limitations

- Requires python to remove multi-line information (entitlements, etc.)
- Preserves GoogleService as is, instead of forcing personal Firebase account:
  - Reason: setting `isBeingTested=true` in `Habitica/AppDelegate.swift` caused errors in my humble hands.
- Does not disable analytics correctly
- First build fails in XCode. You need to build it twice...

# How to use

## install.sh

All-in-one file:
- clones the project
- installs pods
- replaces bundle names and developer ids (see `xc-host-config.sh`)
- removes extra entitlements (Siri,IAP,Apple Sign-In...) to allow free developers to sign the app (see `xc-rm-entitlements.py`)

## xc-host-config.sh

### Requirements

copy `.env.example` to `.env` and adapt with your own data.

### Info

- Replaces the `PRODUCT_BUNDLE_NAME` (aka namespace here) in multiple regions of the project, except in the *Firebase config*
```
namespace_official_1="com.habitica.ios"
namespace_official_2="com.habitrpg.ios"
host_official="habitica.com"
dev_team_official="9Q9SMRMCNN";
group_name_official="group.habitrpg"


#######
echo "Editing Signing config ..."
#######

no1=${namespace_official_1/"."/"\."}
no2=${namespace_official_2/"."/"\."}
dt=${dev_team_official/"."/"\."}
gn=${group_name_official/"."/"\."}

grep -rli --exclude="Google*" $no1 | xargs -I {} sed -i.bak1 s/${namespace_official_1}/$namespace/ "{}"
grep -rli --exclude="Google*" $no2 | xargs -I {} sed -i.bak2 s/${namespace_official_2}/$namespace/ "{}"
grep -rli $dt | xargs -I {} sed -i.bak3 s/${dev_team_official}/${dev_team}/ "{}"
grep -rli $gn | xargs -I {} sed -i.bak4 s/${group_name_official}/${group_name}/ "{}"
```

- Instead of using the `debug.xcconfig` of the official repo, we just replace the only place where the host really matters: the API's url

```
sed -i.bak "s/${host_official}/${host}/" "./Habitica Models/Habitica Models/Constants.swift"
```

## xc-rm-entitlements.py

### Requirements

- python
- `shutil` package

### Info

- Inserts `$(SRCROOT)/secrets.yml` in the input file list of ** SwiftGen ** in the project's `Build Phase` 
- At the same time, removes all lines mentioning  `StoreKit.framework` to disable *In-App Purchases**
- Finally removes the other entitlements from `Habitica.entitlements` : Siri, Apple Sign-In etc.
    - Seems like the removal of `aps-environment` prevents analytics to work correctly, which is a good thing, imho. For now.

