# $1 -> file
# $2 -> method
function processAliasesFile () {
    while read line; do
        # ignore empty lines and comments
        if [[  -z $line  ]] || [[  $line == \#*  ]]; then
            continue
        fi

        # item after ' ' and before '='
        aliasName=$(echo "$line" | cut -d' ' -f2 | cut -d'=' -f1)
        # all items after '='
        aliasContent=$(echo "$line" | cut -d'=' -f2-)

        if [[ $aliasContent == *\; ]]; then
          aliasContent=${aliasContent/\;/}
        fi

        # aliased commands might be strings
        if [[ $aliasContent == \"* ]]; then
          aliasContent=${aliasContent//\"/}
        elif [[ $aliasContent == \'* ]]; then
          aliasContent=${aliasContent//\'/}
        fi


        "$2" "$aliasName" "$aliasContent"
    done < "$1"
}

# $1 -> alias name
# $2 -> alias content
function destroyAlias () {
    alias "$1" 2> /dev/null > /dev/null && unalias "$1"
}

# $1 -> alias name
# $2 -> alias content
function createAlias () {
    alias "$1"="$2"
}

# $1 -> directory
# $2 -> method
function applyMethodToAliasesFiles () {
    if [[ -z $1 ]]; then
        return 0
    fi

    if [ -f "$1/.aliasfile" ]; then
        processAliasesFile "$1/.aliasfile" "$2"
    fi

    if [ "$1" != "/" ]; then
        applyMethodToAliasesFiles "$(dirname "$1")" "$2"
    fi
}

function dir_alias () {
    applyMethodToAliasesFiles "$OLDPWD" destroyAlias
    applyMethodToAliasesFiles $(pwd) createAlias
}

add-zsh-hook chpwd dir_alias;
dir_alias;
