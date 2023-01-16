#include <fstream>
#include <iostream>

/**
 * Copies input to output line by line
 * Usage: io [INPUT [OUTPUT]]
 * If INPUT/OUTPUT is omitted, stdin/stdout is assumed
 */
int main(int argc, const char **argv) {
  std::ios::sync_with_stdio(false);
  std::string mode = "1";
  std::string input = "-";
  std::string output = "-";

  if (argc >= 2)
    mode = argv[1];

  if (argc >= 3)
    input = argv[2];
  if (argc >= 4)
    output = argv[3];
  if (input == "-")
    input = "/dev/stdin";
  if (output == "-")
    output = "/dev/stdout";

  std::ifstream ifs{input};
  std::ofstream ofs{output};

  if (mode[0] == '1') {
    // read line at a time from the input
    std::string line;
    while (std::getline(ifs, line)) {
      ofs << line << "\n";
    }
  }

  if (mode[0] == '2') {
    int length = 1024 * 1024;
    char *buffer = new char[length];
    int bytes = 0;
    // read 1M blocks from the input
    while (!ifs.eof()) {
      ifs.read(buffer, length);
      ofs.write(buffer, ifs.gcount());
    }
  }

  return 0;
}
