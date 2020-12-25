#!/bin/sh
#
# Setup a work space called `work` with two windows
# first window has 3 panes.
# The first pane set at 65%, split horizontally, set to repos root and running vim
# pane 2 is split at 25% and running redis-server
# pane 3 is set to api root and bash prompt.
# note: `project` aliased to `cd ~/path/to/work`
#
session="work"

# set up tmux
# tmux start-server

# create a new tmux session, starting vim from a saved session in the new window
# tmux new-session -d -s $session -n vim #"vim -S ~/.vim/sessions/nu"

# Attach to new session
# tmux switch-client -t $session

# Select pane 1, set dir to repos, run vim
tmux rename-session $session
tmux rename-window -t 0 project
tmux selectp -t 0
tmux send-keys "repos;clear;vim -S ~/.vim/sessions/nu" C-m

# Split pane 1 horizontal by 65%
tmux splitw -h -p 45
tmux send-keys "j r15-services-customer;clear" C-m

# Select pane 2
tmux selectp -t 1
# Split pane 2 vertiacally by 50%
tmux splitw -v -p 50

# select pane 3
tmux selectp -t 2
tmux send-keys "j r15-cm;clear" C-m

# Select pane 1
tmux selectp -t 0

# create a new window called scratch
tmux new-window -k -d -t 1 -n docker

# return to main vim window
tmux select-window -t 1

# Select pane 1
tmux selectp -t 0
# Split pane 1 vertiacally by 35%
tmux splitw -v -p 75
# Select pane 2
tmux selectp -t 1
# Split pane 2 vertically by 35%
tmux splitw -v -p 50

# Select pane 1, set dir to Confluent, start zookeeper and broker
tmux selectp -t 0
tmux send-keys "j cp-all-in-one/cp-all-in-one-community;clear;docker-compose up -d zookeeper broker" C-m
# Select pane 2, set dir to Confluent, tail zookeeper logs
tmux selectp -t 1
tmux send-keys "j cp-all-in-one/cp-all-in-one-community;clear;docker-compose logs -f zookeeper" C-m
# Select pane 1, set dir to Confluent, tail brooker logs
tmux selectp -t 2
tmux send-keys "j cp-all-in-one/cp-all-in-one-community;clear;docker-compose logs -f broker" C-m

# create a new window called scratch
tmux new-window -t 2 -n scratch

# return to main vim window
tmux select-window -t 0

# Finished setup, attach to the tmux session!
# tmux attach-session -t $session
