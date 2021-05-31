# Kbdfans Niu Mini

## rationale

This layout enables mouse keys and is optimized for vim usage.
I spend all my computer time on MacOS, ChromeOS, and Linux.

## procedures

For some reason, the following command doesn't flash firmware on my Mac,

```
make niu_mini:nosarthur:avrdude
```

So I generate the .hex file and use qmk toolbox to flash.

```
make niu_mini:nosarthur
```

If mouse key support is not important to you, you can generate the .hex file
from [qmk configurator](https://config.qmk.fm/#/niu_mini/LAYOUT_planck_mit).

