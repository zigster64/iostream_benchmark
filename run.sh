hyperfine -w3 './iostream text output_iostream' './stdio text output_stdio' './bin/iostream_zig 2 text output_zig' && cmp output_iostream output_stdio && cmp output_iostream output_zig
