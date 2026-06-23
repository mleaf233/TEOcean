# kingdomhearts upstream localization changed

Repo: https://github.com/cloudzXIII/FinalMix.git
Ref: HEAD
Baseline: 8199a19ccd7fbcf821b2fbe05d6e4092efc61051
Latest: c70f8e4bfc4667aca225190611a4ea955c7abc3e

Changed localization files:

~~~text
M	localization/en-us.lua
~~~

Suggested flow:

1. Compare the upstream source files under impl/upstream/kingdomhearts/ with the upstream diff.
2. Update impl/mods/kingdomhearts/localization/zh_CN.lua or its split files.
3. Run tools/upstream-localization.ps1 accept kingdomhearts after the translation catches up.
