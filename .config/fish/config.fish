if status --is-interactive
  #set the stty settings so we can run gcert automatically. More info:
  #https://g3doc.corp.google.com/company/tools/fish/index.md#enable-proper-stty-settings-at-startup
  stty icrnl icanon iexten echo

  prodcertstatus --quiet --check_remaining_hours 1 >/dev/null 2>&1
  or prodaccess -s

# ENV Variables
set -Ux GGG /google/src/cloud/markwell/tuscany
set -Ux GG ~/google3
set -Ux LOCAL_GOOGLE3_WORKSPACE ~/google3
set -Ux X20 /google/data/rw/users/ma/markwell
set -Ux X20_RO /google/data/ro/users/
set -Ux EXP ~/google3/experimental/users/markwell
set -Ux AND /usr/local/google/home/markwell/android
set -Ux AOC /usr/local/google/home/markwell/aoc
set -Ux KERNEL /usr/local/google/home/markwell/kernel
set -Ux HYPX /usr/local/google/home/markwell/hypx
set -Ux POLYGON ~/polygon
set -Ux FIRMWARE $POLYGON/trustzone_images/external/florence/airbrush/fw
set -Ux FLORAL $AND/vendor/google/airbrush/floral
set -Ux FACE $FLORAL/faceauth
set -Ux BLUE $AND/vendor/google_paintbox/blue
set -Ux TUSCANY ~/google3/intelligence/auth/face/tuscany
set -Ux COMMON ~/google3/intelligence/auth/face/common
set -Ux FACEAUTHPROD $TUSCANY/core_libraries/production
set -Ux FACEENGINE $FACEAUTHPROD/face_engine
set -Ux THUMBNAILER $FACEENGINE/components/thumbnailer
set -Ux SOONG_GEN_CMAKEFILES 1
set -Ux SOONG_GEN_CMAKEFILES_DEBUG 1
set -Ux HEXAGON_TOOLS /usr/local/google/home/markwell/Qualcomm/Hexagon_SDK/3.5.1/tools/HEXAGON_Tools/8.3.07/Tools/bin
set -Ux TRUSTY /usr/local/google/home/markwell/trusty/trusty-internal
set -Ux TRUSTY_ROOT $TRUSTY
set -Ux TRUSTY_TOOLS ~/google3/third_party/unsupported_toolchains/trusty/trusty_sdk/toolchain/clang/real-bin
set -Ux TSRC $TUSCANY/ondevice/trusty/trusty_sources
set -Ux CHRE $AND/vendor/google_contexthub/chre
set -Ux NANOAPPS $AND/vendor/google_contexthub/nanoapps
set -Ux GNANOAPPS ~/google3/location/lbs/contexthub/nanoapps
set -Ux CHREP $AND/vendor/google_devices/common/chre/platform
set -Ux CONTEXTHUB $AND/vendor/google_contexthub
set -Ux AMBIENT ~/google3/hardware/gchips/ambient

# Required for AOC dev.
set -Ux AOC_TOP_DIR $AOC

# Use remote build execution to speed up android builds.
# This slows things down!
#export USE_RBE=true

# Raven Proto
#export ANDROID_SERIAL="localhost:39051"
# Raven EVT
#export ANDROID_SERIAL="localhost:40625"

#Temporary env variables
set -Ux RDEPTH $TUSCANY/core_libraries/research/face_engine/components/dual_pd_gas/
set -Ux PDEPTH $TUSCANY/core_libraries/production/face_engine/components/face_pad_depth/

# Aliases

#power commands

# Example Usage - find and replace in cpp files
#       Make sure you're replacing only stuff you want to replace
#   $ grepc SearchTerm
#       Replace stuff
#   $ findc | xargs sed -i 's/SearchTerm/ReplaceTerm/g'
#       Or
#   $ sedc -i 's/SearchTerm/ReplaceTerm/g'
abbr -a rg "rg --no-heading" # ripgrep is _way_ faster than grep.
abbr -a rgg "rg --no-heading -uuL" # ripgrep is _way_ faster than grep.
abbr -a fd "fdfind" # fd is _way_ faster than find.
abbr -a findc "fd -e cc -e cpp -e c -e h"
abbr -a grepc "findc | xargs rg"
abbr -a sedc "findc | xargs sed"
abbr -a formatcpp "fdfind -ecc -eh | xargs clang-format -i"

# Interactive blaze test finder and runner
abbr -a btest "blaze query 'tests(...)' | fzf --height 10 | xargs blaze test"

# Misc useful shortcuts
abbr -a textpbfmt '/google/bin/releases/text-proto-format/public/fmt'

alias -s back 'prevd' > /dev/null
alias -s next 'nextd' > /dev/null

#shell aliases > /dev/null

#android dev
abbr -a flashall '$AND/vendor/google/tools/flashall'
# Nested abbreviations aren't possible, so use a function.
alias -s lunchc 'cd $AND && bass "source $AND/build/envsetup.sh && lunch panther-userdebug" && back' > /dev/null
# go/vscode/android#generating-the-compile-commandsjson-file
alias -s rebuild_android_completion_database 'lunchc && cd $AND && bass "source $AND/build/envsetup.sh && m -j66 nothing && m -j66 SOONG_GEN_COMPDB=1 SOONG_LINK_COMPDB_TO=$ANDROID_BUILD_TOP nothing" && back' > /dev/null
abbr -a logcatc 'adb logcat -c'
abbr -a logcatclear 'adb logcat -c'
abbr -a buildsyncandroid 'repo sync -j66 && lunchc && m -j66'
abbr -a syncandroid 'repo sync -j66 && lunchc'
abbr -a rootremount 'adb wait-for-device root; adb wait-for-device remount -R; adb wait-for-device root; adb wait-for-device remount -R'
abbr -a tmux 'tmx2'

#fast navigation
abbr -a cdx 'cd /google/data/rw/users/ma/markwell/'

#clion shortcut
abbr -a clion '/opt/clion-stable/bin/clion.sh'
abbr -a studio '/opt/android-studio-with-blaze-stable/bin/studio.sh'

#android shortcuts
abbr -a cda "cd $AND"
abbr -a cdaf "cd $FLORAL"
abbr -a cdaff "cd $FACE"
abbr -a cdab "cd $BLUE"
abbr -a cdat "cd $AND/vendor/google/biometrics/face/tuscany_new/"
abbr -a cdasm "cd $AND/vendor/google/airbrush/floral/state_manager"
abbr -a cdaamt "cd $AND/vendor/google/airbrush/floral/client"
abbr -a cdaam "cd $AND/vendor/google/airbrush/floral/service"
abbr -a cdack "cd $AND/device/google/coral-kernel/sm8150/original-kernel-headers/linux"
abbr -a cdacp "cd $AND/vendor/google_devices/coral/prebuilts"
abbr -a cdafw "cd $AND/vendor/google_devices/coral/prebuilts/firmware/faceauth"
abbr -a cdabf "cd $AND/vendor/google/biometrics/face"
abbr -a cdass "cd $AND/system/hardware/interfaces/suspend/1.0/default"
abbr -a cdafd "cd $AND/vendor/google/biometrics/face"
abbr -a cdase "cd $AND/device/google/coral-sepolicy/vendor/google"
abbr -a cdh "cd $HYPX"
abbr -a cdout "cd $AND/out/target/product/coral"

abbr -a cdtrusty "cd $TRUSTY"
abbr -a cdtt "cd $TRUSTY/trusty/user/app/sample/tuscany/"

#ambient shortcuts
abbr -a cdchrep "cd $CHREP"
abbr -a cdchre "cd $CHRE"
abbr -a cdaoc "cd $AOC/AOC"
abbr -a cdnano "cd $NANOAPPS"
abbr -a cdgnano "cd $GNANOAPPS"
abbr -a cdambient "cd $AMBIENT"
abbr -a cdtpu "cd ~/aoc/AOC/drivers/tpu"

#new g3 aliases (since switching to fig)
abbr -a cdg "cd ~/google3"
abbr -a cdgt "cd $TUSCANY/ondevice/trusty"
abbr -a cdconfig "cd $TUSCANY/config/products"
abbr -a cdmodels "cd $TUSCANY/models"

#git aliases
abbr -a gitbranchcleanup "git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"

#kernel shortcuts
abbr -a cdk "cd $KERNEL"

#firmware shortcuts
abbr -a cdf "cd $FIRMWARE"
abbr -a cdpoly "cd $POLYGON"

#g4 shortcuts
abbr -a shelldiff "P4DIFF=vimdiff G4MULTIDIFF 0 g4 diff"

#blaze aliases
abbr -a buildfix "/google/data/ro/teams/ads-integrity/buildfix" # runs build_cleaner and iwyu on all targets

#other aliases
abbr -a pastebin "/google/src/head/depot/eng/tools/pastebin"
abbr -a bisect "/google/data/ro/teams/tetralight/bin/bisect"
abbr -a showaliases "cat ~/.bash_aliases ~/.shortcut_aliases | grep '^alias'"

#other shortcuts
abbr -a cdt 'cd ~/trusty'

abbr -a sb 'source ~/.config/fish/config.fish'
abbr -a eb 'nvim ~/.config/fish/config.fish'

abbr -a copykernelc 'rsync -v $KERN/out/android-msm-floral-4.14/dist/* \ > /dev/null device/google/coral-kernel'


abbr -a aliashelp 'less ~/.config/fish/config.fish | grep alias'
abbr -a shortcuts 'less ~/.config/fish/shortcuts.fish'
abbr -a tmuxhelp 'less ~/.tmux.conf'
abbr -a nvimhelp 'less ~/.nvimhelp'

# Prodaccess is now gcert.
abbr -a pa 'gcert'
abbr -a prodaccess 'gcert'

# Functions

# Google3 fast navigation
abbr -a cdexp 'cd $EXP'
abbr -a cdtuscany 'cd $TUSCANY'
abbr -a cdfe 'cd $FACEENGINE'
abbr -a cdthumbnailer 'cd $THUMBNAILER'
abbr -a cdcommon 'cd $COMMON'

abbr -a cdnvim 'cd ~/shellconfig/.config/nvim'

abbr -a source_android 'pushd $AND && bass "source build/envsetup.sh > /dev/null" && lunchc && popd'

abbr -a bear_aoc 'pushd ~/aoc/AOC && make clean && bear -- make PLATFORM="whi_pro_a32" -j66 aoc-tpu && popd'

# AOC stuff
abbr -a safe_push_pro_aoc 'adb root;adb remount;adb pull /vendor/firmware/aoc.bin /tmp/AoC/aoc-tmp.bin;adb push /tmp/AoC/bundles/whi_pro/aoc/aoc.bin /vendor/firmware/aoc.bin && adb shell sync && adb shell aocutil reset; sleep 2; adb push /tmp/AoC/aoc-tmp.bin /vendor/firmware/aoc.bin'
abbr -a push_pro_aoc 'adb pull /vendor/firmware/aoc.bin /tmp/last-aoc.bin && adb push /tmp/AoC/bundles/whi_pro/aoc/aoc-dev.bin /vendor/firmware/aoc.bin && adb shell sync && adb shell aocutil reset'
abbr -a restore_pro_aoc 'adb push /tmp/last-aoc.bin /vendor/firmware/aoc.bin && adb shell sync && adb shell aocutil reset'

# Use nvim
abbr -a vim nvim

# Use exa
abbr -a ls exa
abbr -a l "exa -l --icons --git -a"
abbr -a lt "exa --tree --level=2 --long --icons --git"

# Use dust
abbr -a du dust

abbr -a bat batcat

# Profile startup time of nvim (~140ms as fo this commit
abbr -a neovimspeed 'hyperfine "nvim --headless +qa" --warmup 5'

# Just for fun (cool cows from https://github.com/paulkaefer/cowsay-files)
alias -s randomcowsay 'cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)' > /dev/null
alias -s wisdom 'fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)' > /dev/null

set -Ux ADB_VENDOR_KEYS /usr/local/google/home/markwell/android/vendor/google/security/adb

# Some fig prompt magic settings
set -U tide_fig_prompt_color $tide_git_color_location
set -U tide_fig_prompt_bg_color $tide_git_bg_color
set -U tide_fig_prompt_icon ''
set -U tide_fig_prompt_description_max 15

# Fish prompt
fish_add_path ~/.cargo/bin

source ~/.config/fish/shortcuts.fish

# Begin the day with wisdom.
wisdom
end

