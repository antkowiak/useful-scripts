#!/bin/bash
#
# Checks the "Have I Been Pwned" website for
# hash matches on a given password.
#

function haveibeenpwned()
{
    echo -n "Enter password to check: "
    stty -echo
    read line
    stty echo
    echo
    local sha1="$(echo -n "$line" | sha1sum - | cut -f1 -d' ')"
    echo sha1 is "$sha1"
    local prefix="$(echo "$sha1" | sed 's/\(.....\)\(.*\)/\1/')"
    local suffix="$(echo "$sha1" | sed 's/\(.....\)\(.*\)/\2/')"
    echo "Searching for prefix: $prefix and suffix: $suffix"
    tput rev
    curl "https://api.pwnedpasswords.com/range/$prefix" 2>/dev/null | grep -i "$suffix" | sed -E 's/^/Pwnd: /g'
    tput sgr0
}

haveibeenpwned
