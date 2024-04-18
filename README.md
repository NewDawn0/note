# note
A simple note taking utility for temporary notes

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
    * [Building from source using Go](#building-from-source-using-go)
    * [Using Nix](#using-nix)
        * [Imperatively](#imperatively)
        * [Declaratively](#declaratively)
* [Usage](#usage)

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
#### Imperatively
```bash
git clone https://github.com/NewDawn0/note
nix profile install .
```
#### Declaratively
1. Add it as an input to your system flake as follows
    ```nix
    {
      inputs = {
        # Your other inputs ...
        note = {
          url = "github:NewDawn0/note";
          inputs.nixpkgs.follows = "nixpkgs";
          # Optional: If you use nix-systems
          inputs.nix-systems.follows = "nix-systems"
        };
      };
    }
    ```
2. Add this to your overlays to expose note to your pkgs
    ```nix
    (final: prev: {
      note = inputs.note.packages.${prev.system}.default;
    })
    ```
3. Then you can either install it in your `environment.systemPackages` using 
    ```nix
    environment.systemPackages = with pkgs; [ note ];
    ```
    or install it to your `home.packages`
    ```nix
    home.packages = with pkgs; [ note ];
    ```

## Usage
```bash
# This will open a new note markdown in your $EDITOR
note

# Use note --help to see all the use cases
# Output of note --help
Usage of note:
  -args string
    	Text editor arguments used
  -ed string
    	Text editor used : (If unset $EDITOR is used) (default "nvim")
  -ext string
    	File extension of the note (default "md")
```
