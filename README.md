# Miato
Miato is a bot'ed regular old account, using [dcfs](github.com/diamondburned/dcfs)  
The 'private' code info has been removed, for my safety `:^)`
# Custom color roles
Miato's custom color roles is it's main feature.  
Miato interacts with Carl-bot in a #miato channel, using `~M<func> [ex]` syntax, and wiping the channel after 15 msgs.  
The code is horrid and bad, but works:tm:  
# Daemonize
The dcfs client will have to be daemonized using a permanent text token in `main.go`  
From there start `miato.sh`, it checks `#miato` for the correct syntax and cases it if it finds it.

---
Most of this code is dcfs
