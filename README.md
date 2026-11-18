# Photo CD Contact Sheet

This fixture renders four archival QA panels: two calibration frames, a
boundary-terminated Photo CD sample, and a one-pixel ICC swatch.

## Render

```sh
make install
```

The Makefile writes only `output/legacy-pcd-compatibility.png`. It does not use
the network.

## Archive asset QA

Plain `make` uses the documented `.DEFAULT_GOAL := q` archive check. It verifies
the POSIX `cksum` and byte size of all three bundled assets, uses no network or
renderer, and writes exactly one report to `output/archive-qa.txt`.

`make install` explicitly selects the preview path and does not invoke `q`. It
still renders only `output/legacy-pcd-compatibility.png`.
