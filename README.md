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
