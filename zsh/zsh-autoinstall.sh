#!/bin/sh
export ZDOTDIR=/etc/zsh
export ZSH=/etc/zsh/ohmyzsh
export ZSH_CUSTOM=$ZSH/custom
apt update
apt-get install -y zsh

echo 'export ZDOTDIR=/etc/zsh' >> /etc/zsh/zshenv
yes "yes" | curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

while [ ! -f /etc/zsh/.zshrc ]; do
    sleep 1
done

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' /etc/zsh/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' /etc/zsh/.zshrc

curl https://raw.githubusercontent.com/WoodieDudy/scriptiky/main/zsh/p10k.zsh -o /etc/zsh/.p10k.zsh
echo '[[ ! -f /etc/zsh/.p10k.zsh ]] || source /etc/zsh/.p10k.zsh' >> /etc/zsh/.zshrc

echo PATH=$PATH >> /etc/zsh/.zshrc

export SHELL="zsh"
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | zsh

echo "setw -g mouse on" >> /etc/tmux.conf
echo "set-option -g default-shell /bin/zsh" >> /etc/tmux.conf

chsh -s /usr/bin/zsh
zsh
