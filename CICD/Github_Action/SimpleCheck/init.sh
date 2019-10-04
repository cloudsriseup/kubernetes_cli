#!/bin/sh

set -eu

SRC=${1-""}
TARGET=${2-""}

if [ "$SRC" = "" ]; then
  echo "Are you sure there is content to be examined?"
  exit 1
fi

if [ "$TARGET" = "" ]; then
  echo "Is the bucket filled?"
  exit 1
fi

echo "Source Directory: $SRC"
echo "Target Directory: $TARGET"

/kube-psp-advisor compare --sourceDir "$SRC" --targetDir "$TARGET"

report="$(/kube-psp-advisor compare --sourceDir "$SRC" --targetDir "$TARGET")"

echo "::set-output name=escalation_report::${report}"
