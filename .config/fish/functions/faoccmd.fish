function faoccmd --description 'fzf to sending aoc cmd'
  set commands "tpu_flow x
3z_tpu_flow x
cca_manager x
sys banner
sys stats
dbg tree
dbg controllers
dbg filters
dbg pipes
dbg pools
dbg rings
dbg ipcs
dbg fsm
dbg tasks
dbg mcps
dbg pmu
dbg power status
dbg timer
dbg int
dbg log
dbg log reset
dbg heap
dbg heap trace
ipc spaces
ipc channels
mem set
mem dump
mem power
watchdog trigger"
  adb shell "echo '$(echo $commands | fzf)' > /dev/acd-debug"
end 
