# smly/notebook

## Usage

```
$ docker run --rm -ti \
  -p 8888:8888 \
  --user kohei \
  -v /mnt/btc_dump:/mnt \
  -v /mnt/notebooks:/home/kohei/work \
  smly/notebook
```

## Composed Softwares

* ubuntu 16.04 (Linux 4.4)
* opencv 3.1.0 + opencv contrib
* python 3.6.0a2
* (base)
  * numpy == 1.11.1
  * scipy == 0.18.0
  * pandas == 0.18.1
    * python-dateutil>=2
    * pytz>=2011k
    * six>=1.5
  * jupyter
* (ml)
  * scikit-learn == 0.17.1
  * xgboost == 0.47
  * ml_metrics
* (visualize)
  * matplotlib
  * seaborn
