" Title:        Live Server
" Description:  Little development server with live reload capability.
" Last Change:  25 July 2022
" Maintainer:   manzeloth <https://github.com/manzeloth>
" Credits:      <https://www.npmjs.com/package/live-server> (MIT License) Copyright (c) 2012 Tapio Vierros


" Functions to call live-server npm package.
function! LiveServer(action)

    " Starts live-server in a new buffer in the background.
    if a:action == "start"
        tabe 
        term live-server
        tabclose
        echo "Started a new live-server (npm) instance."

    " Delete all buffers running live-server.
    elseif a:action == "stop"
        let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "\.'."live-server".'$"')
        if empty(buffers) |throw "no *."."live-server"." buffer" | endif
        exe 'bd! '.join(buffers, ' ')
        echo "Stopped all live-server instances (npm)."

    else
        echo "Enter a valid argument: start/stop."
    endif
endfunction

" Autocomplete arguments for the function.
function! CompletionLiveServer(ArgLead, CmdLine, CursorPos)
    return ['start', 'stop']
endfunction

" Exposes the plugin's functions for use as commands in Vim.
command! -nargs=1 -complete=customlist,CompletionLiveServer LiveServer exec LiveServer(<q-args>)
