DICTIONARY=$1
echo "Validating $DICTIONARY"
# ensure file exists
if [ ! -f $DICTIONARY ]; then
		echo "$DICTIONARY does not exist"
		exit 1
fi
# ensure first line of file is '# Gboard Dictionary version:1'
if [ "$(head -n 1 $DICTIONARY)" != "# Gboard Dictionary version:1" ]; then
		echo "$DICTIONARY must start with '# Gboard Dictionary version:1'"
		exit 1
fi
# ensure remaining lines are valid
INVALID_LINES=$(tail -n +2 $DICTIONARY | grep -v -n -P -e '^(\S*?\t.*?\t)$')
if [ "$INVALID_LINES" != "" ]; then
		echo "ERROR: Invalid lines in dictionary.txt"
		echo "$INVALID_LINES"
		exit 1
fi
echo "Dictionary is valid"
