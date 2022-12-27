#include <iostream>
#include <fstream>

/**
 * Copies input to output line by line
 * Usage: io [INPUT [OUTPUT]]
 * If INPUT/OUTPUT is omitted, stdin/stdout is assumed
 */
int main(int argc, const char** argv) {
  std::ios::sync_with_stdio(false);
  std::string input = "-";
  std::string output = "-";

  if (argc >= 2) input = argv[1];
  if (argc >= 3) output = argv[2];
  if (input == "-") input = "/dev/stdin";
  if (output == "-") output = "/dev/stdout";

  std::ifstream ifs{input};
  std::ofstream ofs{output};

  std::string line;
  while (std::getline(ifs, line)) {
    ofs << line << "\n";
  }

  return 0;
}