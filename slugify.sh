#!/usr/bin/env bash

echo "Slugify value: $VALUE"

SLUG=${VALUE}

if [ ${#VALUE} -ge $MAXLENGTH ]; then
	HASH=$(echo $VALUE | md5sum)
	SLUG=${VALUE:0:($MAXLENGTH - 7)}-${HASH:0:6}
fi

echo "Slugified value: $SLUG"

echo "::set-output name=slug::${SLUG,,}"
