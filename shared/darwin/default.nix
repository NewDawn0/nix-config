{ lib, fn, ... }: fn.auto-out ./. (f: ./${f}) "darwin-"
