#!/usr/bin/env bash

echo $(pwd)

echo "*.bak" >> .gitignore
echo "*.bak1" >> .gitignore
echo "*.bak2" >> .gitignore
echo "*.bak3" >> .gitignore
echo "*.bak4" >> .gitignore

find . -name "*.bak*" -delete

source ../.env

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


#####
echo "Editing path to host ..."
#####

sed -i.bak "s/${host_official}/${host}/" "./Habitica Models/Habitica Models/Constants.swift"
