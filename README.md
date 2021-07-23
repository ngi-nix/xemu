# mega65 - xemu

- upsteam: https://github.com/lgblgblgb/xemu
- ngi-nix: https://github.com/ngi-nix/ngi/issues/81

xemu is a custom built emulator for older hardware platforms like the Commodore 65 and since mega65
is similar to the C65, it can emulate that too.

## Using

In order to use this [flake](https://nixos.wiki/wiki/Flakes) you need to have the 
[Nix](https://nixos.org/) package manager installed on your system. Then you can simply run this 
with:

```
$ nix shell github:ngi-nix/xemu -c xemu-<platform>
```

You can also enter a development shell with:

```
$ nix develop
```

For information on how to automate this process, please take a look at [direnv](https://direnv.net/).
