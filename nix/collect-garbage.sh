#!/usr/bin/env bash

KEEP_GENS=3

GEN="$(just nix list | tail -n $KEEP_GENS | head -n 1 | xargs | tr -s ' ')"
GEN_DATE="$(echo $GEN | cut -d ' ' -f 2)"

echo "Last gen to keep: $GEN"

DAYS=$(
python << END
from datetime import date
gen_date = [int(x) for x in "$GEN_DATE".split("-")]
print((date.today() - date(*gen_date)).days)
END
)

echo "Days of older gen to keep: $DAYS"

sudo nix-collect-garbage --delete-older-than "${DAYS}d"
