# ##############################################################################
# OPTIONS
# ##############################################################################

set-option -g  default-terminal 'screen-256color'
set-option -ga terminal-overrides ",xterm-256color:Tc"

set -g detach-on-destroy off
set -g renumber-windows on
set -g set-clipboard on
set -g status-position top
set -g status-justify left
set -g default-terminal "${TERM}"
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
set -g bell-action none
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'
set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
set -g @fzf-url-history-limit '2000'

setw -g monitor-activity

set-environment -g PATH "/usr/local/bin:/bin:/usr/bin:$PATH"

# ##############################################################################
# BINDS
# ##############################################################################

bind  ^X  lock-server
bind  ^C  new-window -c "$HOME"
bind  ^D  detach
bind  *   list-clients
bind  H   previous-window
bind  L   next-window
bind  r   command-prompt "rename-window %%"
bind  R   source-file ~/.config/tmux/tmux.conf
bind  ^A  last-window
bind  ^W  list-windows
bind  w   list-windows
bind  z   resize-pane -Z
bind  ^L  refresh-client
bind  l   refresh-client
bind  |   split-window
bind  s   split-window -v -c "#{pane_current_path}"
bind  v   split-window -h -c "#{pane_current_path}"
bind  '"' choose-window
bind  h   select-pane -L
bind  j   select-pane -D
bind  k   select-pane -U
bind  l   select-pane -R
bind  :   command-prompt
bind  *   setw synchronize-panes
bind  P   set pane-border-status
bind  c   kill-pane
bind  x   swap-pane -D
bind  S   choose-session
bind  R   source-file ~/.config/tmux/tmux.conf
bind  K   send-keys "clear"\; send-keys "Enter"

bind -r -T prefix , resize-pane -L 20
bind -r -T prefix . resize-pane -R 20
bind -r -T prefix - resize-pane -D 7
bind -r -T prefix = resize-pane -U 7

bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key t swap-window -t 1

# ##############################################################################
# OTHER
# ##############################################################################

# Fix bar background color
set -g status-bg default
set -g status-style bg=default

set -Fg 'status-format[1]' ''
set -g status 2
