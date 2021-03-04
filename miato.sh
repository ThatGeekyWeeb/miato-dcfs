#!/bin/bash
miato="/home/mia/git/dcfs/mnt/$server/miato"
while sleep 2; do
cli() {
       echo $(cat "$miato" | tail  -1 | cut -d',' -f3 | grep '^~M')
}
if $(cat "$miato" | tail  -1 | cut -d',' -f3 | grep -q '~M'); then
	case $(echo $(cli) | sed 's/ .*//g' | cut -d'M' -f2) in
		color)
			hex=$(echo $(cli) | cut -d' ' -f2)
			if echo $(cli) | grep -q '@'; then
				id=$(echo $(cli) | sed -e 's/.*<@!//g' -e 's/>//g')
			else
				id=$(cat "$miato" | tail -1 | cut -d',' -f1)
			fi
			echo "~role $id $hex" >> "$miato"
			sleep 2
			if [ $(cat "$miato" | tail -1 | cut -d' ' -f3) = "not" ]; then
				echo "~role create $hex $hex" >> "$miato"
			sleep 2
			echo "~role $id $hex" >> "$miato"
			fi
			;;
		clean)
			echo "~purge all" >> "$miato"
			echo "Please do not chat here" >> "$miato"
			;;
		quote)
			[ -f "/usr/share/fortunes/$(echo $(cli) | sed -e 's/.*<@!//g' -e 's/>//g')" ] && {
				fortune "/usr/share/fortunes/$(echo $(cli) | sed -e 's/.*<@!//g' -e 's/>//g')" >> "$miato"
				echo "~$(echo $(cli) | sed -e 's/.*<@!//g -e s/>//g')" >> "$miato"
			} || {
				fortune >> "$miato"
			}
			;;
		mkq)
			echo $(cli) | grep -q "<" && {
				id=$(echo $(cli) | sed -e 's/.*<@!//g -e s/>//g')
			} || {
				id=$(cat "$miato" | tail -1 | grep '~Mmkq' |cut -d',' -f1)
			}
			echo $(echo $(cli) | sed 's/~Mmkq //g') >> "/usr/share/fortunes/$id"
			echo '%' >> "/usr/share/fortunes/$id"
			strfile "/usr/share/fortunes/$id"
			echo "Quote made under <@!$id>" >> "$miato"
			;;
		help)
			#echo "~purge all" >> "$miato"
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
mkq: Create a quote under your PING (~Mmkq <quote>) # CURRENTLY BROKEN
help: That prints this swilly uwu (~Mhelp)
***

---
Miato's scripting service is open source!
Find it here!	> https://github.com/ThatGeekyWeeb/miato-dcfs/
---

***
```
EOF
			;;
	esac
fi
done
