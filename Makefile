MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := help

USERNAME := $(shell whoami)
HOSTNAME := $(shell hostname)
PATH2HOME := $(shell echo ~)
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')


vim: ## set up vim
	@echo "<<< vim >>>"
	@echo "ln -s $(PATH2HOME)/.dotfiles/Vim/dot_vim $(PATH2HOME)/.vim"
	@echo "mkdir -p $(PATH2HOME)/.config"
	@echo "ln -s $(PATH2HOME)/.dotfiles/Vim/dot_vim $(PATH2HOME)/.config/nvim"
	@echo "ln -s $(PATH2HOME)/.dotfiles/Vim/dot_vim/init.vim $(PATH2HOME)/.vimrc"
	@echo "ln -s $(PATH2HOME)/.dotfiles/Vim/dein $(PATH2HOME)/.dein"
	@echo ''


tmux: ## put symlink of ".dotfiles/tmux/tmux.conf" to "~/.tmux.conf"
	@echo "<<< tmux >>>"
	@echo "ln -s $(PATH2HOME)/.dotfiles/tmux.conf $(PATH2HOME)/.tmux.conf"
	@echo ''

alacritty: ## print "ln" command option to setup alacritty
	@echo "<<< alacritty >>>"
	@echo "ln -s $(PATH2HOME)/.dotfiles/alacritty_linux.yml $(PATH2HOME)/.alacritty.yml"
	@echo ''

bash: ## put symlink of .dotfiles/
	@echo "<<< bash >>>"
	@echo "echo 'HOSTCOLOR=\"255;255;255\"' >> $(PATH2HOME)/.bashrc"
	@echo "ln -s $(PATH2HOME)/.dotfiles/inputrc.txt $(PATH2HOME)/.inputrc"
	@echo "echo 'source $(PATH2HOME)/.dotfiles/bashrc_common.bash' >> $(PATH2HOME)/.bashrc"
	@echo ''

zsh: ## set up zsh
	@echo "<<< zsh >>>"
	@echo "echo 'HOSTCOLOR=\"255;255;255\"' >> $(PATH2HOME)/.zshrc"
	@echo "echo 'source $(PATH2HOME)/.dotfiles/zshrc_common.zsh' >> $(PATH2HOME)/.zshrc"
	@echo ""
	@echo ''


help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

