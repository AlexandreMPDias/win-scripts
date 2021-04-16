# Set Editor to use vscode
git config --global core.editor "code --wait"

# Set Alias
git config --global alias.f "fetch -p"
git config --global alias.u "!git fetch -p && git pull"
git config --global alias.last "log -1 HEAD --decorate"
git config --global alias.plog "!git log --pretty='format:%C(cyan){%an} %C(yellow)%ar %C(green)[%h] %C(auto)%s'"