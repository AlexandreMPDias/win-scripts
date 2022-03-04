# Set Editor to use vscode
git config --global core.editor "code --wait"

# Set Alias
git config --global alias.c "!git commit --no-verify -m"
git config --global alias.f "fetch -p"
git config --global alias.u "!git fetch -p && git pull"
git config --global alias.last "!git log -1 HEAD --decorate"
git config --global alias.l "!git log --pretty='format:%C(cyan){%an} %C(yellow)%ar %C(green)[%h] %C(auto)%s'"
git config --global alias.clean-up "!git branch --merged | egrep  -v '(^\*|master|main|dev|staging)' | xargs -n 1 -r git branch -d"