blue=$(tput setaf 4)
green=$(tput setaf 2)
red=$(tput setaf 1)
normal=$(tput sgr0)

function run_commands() {
    commands=$*

    echo -e ${green}${commands}${normal}
    eval $commands    
    echo 
}

function call_restapi_json() {
    commands=$*

    echo -e ${green}${commands}${normal}
    eval $commands 2> /dev/null | python -m json.tool
    echo 
}
