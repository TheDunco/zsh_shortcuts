# zsh_shortcuts
My zsh shortcuts from work at Tekton

# Instructions
1. Copy the `.aliases.zshrc` file into your home direcotry (`~/.aliases.zshrc`)
2. Add `source .aliases.zshrc` into your .zshrc (my .zshrc is provided as an example)
3. Manually source your .zshrc by typing `source ~/.zshrc` (this is the `reload` command in my alias language)
4. Now you can use my aliases!
5. Feel free to change the aliases and experiment as you wish.

# Explantions
- Most git commands are the same minus the "git"
  - If you use these git shortcuts, they will automatilly track your feature branch
  - Create a feature branch using the `fb` or `featurebranch` commands.
  - If you do this and always check out branches using the `cho` command, it will save the name of your current feature branch and automatically push there.
    - This command will always re-install node_modules to ensure that they are always up to date. This is slightly annoying but the best way I've found to do it.
- If you have any questions, feel free to ask
