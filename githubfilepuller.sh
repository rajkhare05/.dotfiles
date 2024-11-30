#!/bin/bash

read -p "github url: " github_url;

has_https=$(awk -F '://' '{print $1}' <<< $github_url);

if [[ -n has_https ]]; then
    github_url=$(echo $github_url | sed -e 's/http\(s\)\?:\/\///g');
fi

account=$(awk -F '/' '{print $2}' <<< $github_url);
repo=$(awk -F '/' '{print $3}' <<< $github_url);
file=$(awk -F '/' '{print $NF}' <<< $github_url);
branch=$(awk -F '/' '{print $(NF-1)}' <<< $github_url);

url="https://raw.githubusercontent.com/$account/$repo/refs/heads/$branch/$file";

echo "Downloading from $url";

curl -s $url > $file;

echo "Done";

