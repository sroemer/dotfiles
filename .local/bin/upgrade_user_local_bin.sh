#!/bin/bash

# Install td-watson and nodejs via python pip
if ! [[ -x $(command -v pip) ]]; then
    echo "ERROR: pip required but not available"
    exit 1
fi
echo "INFO : installing/upgrading td-watson and nodeenv"
if ! pip install --upgrade --user td-watson nodeenv; then
    echo "ERROR: installing/upgrading td-watson and nodeenv failed (pip returned $?)"
else
    echo "INFO : installing/upgrading td-watson and nodeenv finished"

    # Install nodejs runtime environment and bash-/diagnostic-language-servers
    NODE_DIR="$HOME/.local/nodejs/"
    if [[ -d "$NODE_DIR" ]]; then
        echo "INFO : removing existing nodejs directory"
        rm -rf "$NODE_DIR"
    fi

    if [[ -d "$NODE_DIR" ]]; then
        echo "ERROR: nodejs installation directory still exists."
        exit 1
    else
        echo "INFO : installing latest nodejs to $NODE_DIR"
        nodeenv "$NODE_DIR"

        echo "INFO : activating nodejs environment"
        # shellcheck source=/dev/null
        . "$NODE_DIR/bin/activate"

        echo "INFO : installing bash-language-server"
        npm i -g bash-language-server

        echo "INFO : installing diagnostic-languageserver"
        npm i -g diagnostic-languageserver

        echo "INFO : deactivating nodejs environment"
        deactivate_node
    fi

fi
