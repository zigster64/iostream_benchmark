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
Benchmark 1: ./bin/iostream 1 text out/output_iostream
  Time (mean ± σ):      8.742 s ±  0.682 s    [User: 5.967 s, System: 2.265 s]
  Range (min … max):    7.558 s …  9.850 s    10 runs

Benchmark 2: ./bin/iostream 2 text out/output2_iostream
  Time (mean ± σ):      2.315 s ±  0.305 s    [User: 0.394 s, System: 1.787 s]
  Range (min … max):    1.964 s …  2.875 s    10 runs

Benchmark 3: ./bin/stdio text out/output_stdio
  Time (mean ± σ):      3.722 s ±  0.577 s    [User: 1.698 s, System: 1.818 s]
  Range (min … max):    3.348 s …  5.299 s    10 runs

  Warning: The first benchmarking run for this command was significantly slower than the rest (5.299 s). This could be caused by (filesystem) caches that were not filled until after the first run. You should consider using the '--warmup' option to fill those caches before the actual benchmark. Alternatively, use the '--prepare' option to clear the caches before each timing run.

Benchmark 4: ./bin/iostream_zig 2 text out/output_zig
  Time (mean ± σ):      1.079 s ±  0.013 s    [User: 0.148 s, System: 0.667 s]
  Range (min … max):    1.065 s …  1.110 s    10 runs

Summary
  './bin/iostream_zig 2 text out/output_zig' ran
    2.15 ± 0.28 times faster than './bin/iostream 2 text out/output2_iostream'
    3.45 ± 0.54 times faster than './bin/stdio text out/output_stdio'
    8.10 ± 0.64 times faster than './bin/iostream 1 text out/output_iostream'
```


