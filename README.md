# Vim support for the mudlle language

What is mudlle? See https://github.com/MUME/mudlle.

## Features

- Syntax highlighting.
- Automatic folding of function bodies.

## Tunables

### Enabling syntax-based folding

Create a file `~/.vim/ftplugin/mudlle.vim` with:

```
setlocal foldmethod=syntax
```

This will create folds for all function bodies (whereas the built-in `indent`
folding method would recursively fold all blocks based on their indentation
level).

You could also add `set foldmethod=syntax` to your `~/.vimrc` if you wanted
that behaviour for all file types that provide syntax-based folding, of course.

## How to install

### Pathogen

Follow the instructions at https://github.com/tpope/vim-pathogen.

### vim-addon-manager (Debian)

Clone the repository somewhere and:

```
vim-addons -r .../vim-mudlle/registry -s .../vim-mudlle/files install mudlle-syntax
```

This is deprecated in favor of Pathogen.

## License

Distributed under the same terms as Vim itself. See `:help license`.
