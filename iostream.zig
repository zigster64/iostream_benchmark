const std = @import("std");

// /**
//  * Copies input to output line by line
//  * Usage: io [INPUT [OUTPUT]]
//  * If INPUT/OUTPUT is omitted, stdin/stdout is assumed
//  */

pub fn main() !void {
    var args = std.process.args();
    _ = args.next().?; // points to name of this exe

    const mode = args.next().?;

    const inputname = args.next().?;
    const outputname = args.next().?;

    const inputdata = try std.fs.cwd().openFile(inputname, .{});
    defer inputdata.close();

    std.log.info("mode {s} input {s} output {s}", .{ mode, inputname, outputname });

    var inputfile = std.io.bufferedReader(inputdata.reader());
    var ifs = inputfile.reader();

    const outputdata = try std.fs.cwd().createFile(outputname, .{});
    defer outputdata.close();

    var outputfile = std.io.bufferedWriter(outputdata.writer());
    var outfs = outputfile.writer();

    if (mode[0] == '1') {
        var buffer: [1024]u8 = undefined;
        while (try ifs.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
            try outfs.writeAll(line);
            try outfs.writeByte('\n');
        }
    }

    if (mode[0] == '2') {
        var buffer: [1024 * 1024]u8 = undefined;
        while (true) {
            var bytes = try ifs.read(&buffer);
            if (bytes == 0) break;
            var outbytes = try outfs.write(buffer[0..bytes]);
            try std.testing.expect(bytes == outbytes);
        }
    }
    try outputfile.flush();
}

// #include <iostream>
// #include <fstream>

// int main(int argc, const char** argv) {
//   std::ios::sync_with_stdio(false);
//   std::string input = "-";
//   std::string output = "-";

//   if (argc >= 2) input = argv[1];
//   if (argc >= 3) output = argv[2];
//   if (input == "-") input = "/dev/stdin";
//   if (output == "-") output = "/dev/stdout";

//   std::ifstream ifs{input};
//   std::ofstream ofs{output};

//   std::string line;
//   while (std::getline(ifs, line)) {
//     ofs << line << "\n";
//   }

//   return 0;
// }
