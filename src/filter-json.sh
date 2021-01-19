set -e

input="$1"

# Delete all content types exeptt application/json:
cat "$input" | \
jq 'del(.. | .content?."application/json-patch+json"?)' | \
jq 'del(.. | .content?."application/*+json"?)' | \
jq 'del(.. | .content?."text/html"?)' | \
jq 'del(.. | .content?."text/json"?)' | \
jq 'del(.. | .content?."text/plain"?)'





