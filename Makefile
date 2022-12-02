MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := help

USERNAME := $(shell whoami)
HOSTNAME := $(shell hostname)
PATH2HOME := $(shell echo ~)
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')


vim: ## set up vim
	@echo "<<< vim >>>"
	@echo "ln -s $(PATH2HOME)/Settings/Vim/dot_vim $(PATH2HOME)/.vim"
	@echo "mkdir -p $(PATH2HOME)/.config"
	@echo "ln -s $(PATH2HOME)/Settings/Vim/dot_vim $(PATH2HOME)/.config/nvim"
	@echo "ln -s $(PATH2HOME)/Settings/Vim/dot_vim/init.vim $(PATH2HOME)/.vimrc"
	@echo "ln -s $(PATH2HOME)/Settings/Vim/dein $(PATH2HOME)/.dein"
	@echo ''


tmux: ## put symlink of "Settings/tmux/tmux.conf" to "~/.tmux.conf"
	@echo "<<< tmux >>>"
	@echo "ln -s $(PATH2HOME)/Settings/tmux/tmux.conf $(PATH2HOME)/.tmux.conf"
	@echo ''

alacritty: ## print "ln" command option to setup alacritty
	@echo "<<< alacritty >>>"
	@echo "Option: create new setting file"
	@echo "cp ~/Settings/alacritty/alacritty_template.yml ~/Settings/alacritty/alacritty_{os_name}.yml"
	@echo ''
	@echo "ln -s $(PATH2HOME)/Settings/alacritty/alacritty_{os_name}.yml $(PATH2HOME)/.alacritty.yml"
	@echo "{os_name}"
	@ls $(PATH2HOME)/Settings/alacritty | sed -e 's/alacritty_//g' | sed -e 's/.yml//g'
	@echo ''

bash: make_hostname_dir.sh ## put symlink of Settings/
	@echo "<<< bash >>>"
	@echo "ln -s $(PATH2HOME)/Settings/Shell/inputrc.txt $(PATH2HOME)/.inputrc"
	@./make_hostname_dir.sh
	@echo "ln -s $(PATH2HOME)/Settings/Shell/$(HOSTNAME)/bashrc.bash $(PATH2HOME)/.bashrc"
	@echo ''

zsh: make_hostname_dir.sh ## set up zsh
	@echo "<<< zsh >>>"
	@./make_hostname_dir.sh
	@echo "ln -s $(PATH2HOME)/Settings/Shell/$(HOSTNAME)/zshrc.zsh $(PATH2HOME)/.zshrc"
	@echo ""
	@echo ''

fish: make_hostname_dir.sh ## set up fish
	@echo "<<< fish >>>"
	@./make_hostname_dir.sh
	@mkdir -p $(PATH2HOME)/.config
	@mkdir -p $(PATH2HOME)/.config/fish
	@echo "ln -s $(PATH2HOME)/Settings/Shell/$(HOSTNAME)/config.fish $(PATH2HOME)/.config/fish/config.fish"
	@echo ""
	@echo ''

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

