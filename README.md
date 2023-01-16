# C/C++ IO benchmark

Simple IO reading/writing benchmark based on C stdio library and C++ iostream/fstream libraries. 


## Benchmark result on m1 macOS
| | macOS | container |
|-----|-----|-----|
| C   | 1.2s | 1.3s |
| C++ | 3.1s 😱 | 1.4s |

**TL;DR**
macOS C++ stream library is poorly implemented and runs 2x slower than a VM running on the macOS host!

# Try it yourself
## A. Benchmark natively
```bash
# download data
curl https://datasets.imdbws.com/title.basics.tsv.gz | gunzip > text
# install hyperfine
brew install hyperfine # macOS
sudo apt-get install -y hyperfine # ubuntu
# build
make
# run benchmark
bash run.sh
```

OR

```
make run
```
Which will curl the input data in, build the exe files, and run the benchmark tests

## B. Benchmark inside Docker container
```bash
# build docker image
docker build -t io .
# run docker container
docker run --rm -it io
# run benchmark inside the container
bash run.sh
```

# Watch
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/c7UqR56vlsE/0.jpg)](https://www.youtube.com/watch?v=c7UqR56vlsE)

# Bench results

```
Benchmark 1: ./iostream text output_iostream
  Time (mean ± σ):      7.153 s ±  0.390 s    [User: 5.192 s, System: 1.730 s]
  Range (min … max):    6.686 s …  8.084 s    10 runs

Benchmark 2: ./stdio text output_stdio
  Time (mean ± σ):      3.102 s ±  0.174 s    [User: 1.438 s, System: 1.568 s]
  Range (min … max):    2.953 s …  3.417 s    10 runs

Benchmark 3: ./bin/iostream_zig 2 text output_zig
  Time (mean ± σ):      1.122 s ±  0.048 s    [User: 0.134 s, System: 0.628 s]
  Range (min … max):    1.068 s …  1.239 s    10 runs

Summary
  './bin/iostream_zig 2 text output_zig' ran
    2.76 ± 0.20 times faster than './stdio text output_stdio'
    6.38 ± 0.44 times faster than './iostream text output_iostream
```


