#include <cstdio>
#include <string>
#include <cstdlib>

/**
 * Copies input to output line by line
 * Usage: io [INPUT [OUTPUT]]
 * If INPUT/OUTPUT is omitted, stdin/stdout is assumed
 */
int main(int argc, const char** argv) {
  std::string input = "-";
  std::string output = "-";

  if (argc >= 2) input = argv[1];
  if (argc >= 3) output = argv[2];
  if (input == "-") input = "/dev/stdin";
  if (output == "-") output = "/dev/stdout";

  FILE* ifs = fopen(input.data(), "r");
  FILE* ofs = fopen(output.data(), "w");

  char* line = nullptr;
  size_t capacity;
  while (auto n = getline(&line, &capacity, ifs)) {
    if (n <= 0) break;
    fwrite(line, sizeof(char), n, ofs);
  }

  free(line);
  fclose(ifs);
  fclose(ofs);

  return 0;
}
