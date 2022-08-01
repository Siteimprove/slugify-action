#!/usr/bin/env bash

echo "Slugify value: $VALUE"

slug() {
  # 1st : Remove refs prefix
  # 2d : Replace unwanted characters
  # 3d : Remove leading hypens
  output=$(sed -E 's#refs/[^\/]*/##;s/[^a-zA-Z0-9._-]+/-/g;s/^-*//' <<<"$1")
  reduce "$output"
}

slug_url() {
  # 1st : Remove refs prefix
  # 2d : Replace unwanted characters
  # 3d : Remove leading hypens
  output=$(sed -E 's#refs/[^\/]*/##;s/[^a-zA-Z0-9-]+/-/g;s/^-*//' <<<"$1")
  reduce "$output"
}

reduce() {
  reduced_value="$1"
  if [ "${MAXLENGTH}" != "nolimit" ]; then
    reduced_value=$(cut -c1-"${MAXLENGTH}" <<<"$reduced_value")
  fi
  # 1st : Remove trailing hypens
  sed -E 's/-*$//' <<<"$reduced_value"
}

SLUG=$(slug "${VALUE,,}")
SLUG_CS=$(slug "$VALUE")
SLUG_URL=$(slug_url "${VALUE,,}")
SLUG_URL_CS=$(slug_url "$CS_VALUE")

echo "::set-output name=value::${SLUG}"
echo "::set-output name=slug::${SLUG}"
echo "::set-output name=slug-cs::${SLUG_CS}"
echo "::set-output name=slug-url::${SLUG_URL}"
echo "::set-output name=slug-url-cs::${SLUG_URL_CS}"
