#!/bin/bash
server=""
miato="mnt/$server/miato"
while sleep 2; do
cli() {
       echo $(tac "$miato" | tail  -1 | cut -d',' -f3 | grep '^~M')
}
if $(tac "$miato" | tail  -1 | cut -d',' -f3 | grep -q '~M'); then
	case $(echo $(cli) | sed 's/ .*//g' | cut -d'M' -f2) in
		color)
			hex=$(echo $(cli) | cut -d' ' -f2)
			if echo $(cli) | grep -q '@'; then
				id=$( echo $(cli) | sed -e 's/.*<@!//g' -e 's/>//g')
			else
				id=$(tac "$miato" | tail -1 | cut -d',' -f1)
			fi
			echo "~role $id $hex" >> "$miato"
			sleep 2
			if [ $(tac "$miato" | tail -1 | cut -d' ' -f3) = "not" ]; then
				echo "~role create $hex $hex" >> "$miato"
			sleep 2
			echo "~role $id $hex" >> "$miato"
			fi
			sleep 2
			echo "~purge all" >> "$miato"
			;;
		clean)
			echo "~purge all" >> "$miato"
			echo "Please do not chat here, the code breaks if there are 15 msgs/lines of msgs" >> "$miato"
			;;
		quote)
			fortune /usr/share/fortunes/$(echo $(cli) | sed -e 's/.*<@!//g' -e 's/>//g') >> "$miato"
			;;
		mkq)
			id=$(tac "$miato" | tail -1 | cut -d',' -f1)
			echo $(echo $(cli) | sed 's/~Mmkq //g') >> "/usr/share/fortunes/$id"
			echo '%' >> "/usr/share/fortunes/$id"
			strfile "/usr/share/fortunes/$id"
			echo "Quote made under <@!$id>" >> "$miato"
			;;
		help)
			echo "~purge all" >> "$miato"
			cat << 'EOF' >> "$miato"
```text
Miato: A regular user, with a scripted client, running on Mia's laptop
Usage: ~M<FUNC> [EX] - I.E: ~Mcolor <HEX>
	Syntax: 
		<>: Required
		[]: Extra
***
color: Create/Add/Remove a color role of HEX (~Mcolor <HEX> [@PING])
clean: Purge the miato channel
quote: Grab a quote from fortune or find a quote from @PING (~Mquote [@PING])
mkq: Create a quote under your PING (~Mmkq <quote>)
help: That prints this swilly uwu (~Mhelp)
***
	Notes: Miato violates TOS
	       Miato uses Carl-Bot as a text interface to role managment
***
```
EOF
			;;
	esac
fi
if [ $(cat "$miato" | grep ',*:' -c) -gt 15 ]; then
	echo "~purge all" >> "$miato"
	echo "Please do not chat here, the code breaks if there are 15 msgs/lines of msgs" >> "$miato"
fi
done
