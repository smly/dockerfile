# smly/notebook

## Usage

```
$ docker run --rm -ti \
  -p 8888:8888 \
  --user kohei \
  -v /mnt/btc_dump:/mnt \
  -v /mnt/notebooks:/home/kohei/work \
  smly/notebook:0.4
```

## Composed Softwares

* ubuntu 16.04 (Linux 4.4)
* opencv 3.1.0 + opencv contrib
* anaconda
* xgboost == 0.60, libFM, RGF
