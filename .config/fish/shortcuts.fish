# Aliases in here are meant to be quick shortcuts, not permanent things.
# Use 'addalias' to add them.
# They intentionally don't call alias -s so they don't get saved as fish functions.
alias example_alias="echo this is an example"
alias testalias='echo foo'
abbr -a foo echo foo
abbr -a itestact blaze test --config=android_x86_64 --android_ndk_min_sdk_version=33 //hardware/gchips/ambient/javatests/com/google/act:all
abbr -a testact blaze test --config=android_arm64 --android_ndk_min_sdk_version=33 //hardware/gchips/ambient/java/com/google/act:all
abbr -a installact blaze mobile-install -c opt --config=android_arm64 --android_ndk_min_sdk_version=33 //hardware/gchips/ambient/java/com/google/act
abbr -a buildact blaze build -c opt --config=android_arm64 --android_ndk_min_sdk_version=33 //hardware/gchips/ambient/java/com/google/act
