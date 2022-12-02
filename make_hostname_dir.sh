

USERNAME=$(whoami)
HOSTNAME=$(hostname)
PATH2HOME=$(echo ~)
ISHOSTNAME=0
ISBASHRC=0
ISZSHRC=0
mkdir $PATH2HOME/Settings/Shell/$HOSTNAME || ISHOSTNAME=1
if test $ISHOSTNAME -eq 0 ; then
		touch $PATH2HOME/Settings/Shell/$HOSTNAME/bashrc.bash
		touch $PATH2HOME/Settings/Shell/$HOSTNAME/zshrc.zsh
        echo "HOSTCOLOR=\"255;255;255\"" > $PATH2HOME/Settings/Shell/$HOSTNAME/bashrc.bash
		echo "source $PATH2HOME/Settings/Shell/bashrc_common.bash" > $PATH2HOME/Settings/Shell/$HOSTNAME/bashrc.bash
		echo "source $PATH2HOME/Settings/Shell/zshrc_common.bash" >  $PATH2HOME/Settings/Shell/$HOSTNAME/zshrc.zsh
		cat $PATH2HOME/.bashrc || ISBASHRC=1
		if test $ISBASHRC -eq 0 ; then
				cat $PATH2HOME/.bashrc >> $PATH2HOME/Settings/Shell/$HOSTNAME/bashrc.bash
				mv $PATH2HOME/.bashrc $PATH2HOME/.bashrc_old
		fi
		cat $PATH2HOME/.zshrc || ISZSHRC=1
		if test $ISZSHRC -eq 0 ; then
				cat $PATH2HOME/.zshrc >> $PATH2HOME/Settings/Shell/$HOSTNAME/zshrc.zsh
				mv $PATH2HOME/.zshrc $PATH2HOME/.zshrc_old
		fi
fi
