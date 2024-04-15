# note
A simple note taking utility for temporary notes

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
    * [Building from source using Go](#building-from-source-using-go)
    * [Using Nix](#using-nix)
        * [To just test it out](#to-just-test-it-out)
        * [If you a flake system config](#if-you-a-flake-system-config)

<!-- vim-markdown-toc -->

## Installation
### Building from source using Go
```bash
git clone https://github.com/NewDawn0/note.git
cd note
go build
sudo mv ./note /usr/local/bin/
```
### Using Nix
#### To just test it out
```bash
nix run https://github.com/NewDawn0/note.git
```
#### If you a flake system config
1. Add it as an input to your system flake as follows
```nix
{
    inputs.note = {
        url = "https://github.com/NewDawn0/note.git";
        inputs.nixpkgs.follows = "nixpkgs";
        # Optional: If you use nix-systems
        inputs.nix-systems.follows = "nix-systems"
    };
}
```

2. Add this to your overlays to expose note to your pkgs
```nix
(final: prev: {
    note = inputs.note.packages.${prev.system}.default;
})
```
