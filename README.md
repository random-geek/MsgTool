# MsgTool
Easy and fast private-messaging CSM for Minetest

## Tutorial
### Send a message:
`.p Bobby Hello, how are you?`
Send a private message to one player. This is esentially the same as `/msg Bobby Hello, how are you?`
### Send a message to the previous recipient:
`.p * This cave is huge!`
Send a private message to the player (or players) you messaged last.
### Send a message to multiple players:
`.p Bobby,Emily4 Do you have any wood left?`
Send a private message to multiple people at once. Note there are no spaces after the commas.
### Using wildcards
`.p Jane_* Yellow is my favourite colour.`
You can use an asterisk (`*`) in the place of missing letters in a player name. This will automatically find a player whose name fits the pattern. For example, `Jane_*` finds a player whose name begins with `Jane_`.
### Setting players only
`.p Bobby,Emily4`
Set players for later use. This will not send a message.
### Combining player strings
`.p *,Bobby,Jane_* Good morning!`
You can also combine one or more of the previous parameters. The example will send `Good morning!` to the previous recipients, plus `Bobby` and a player whose name begins with `Jane_`.
