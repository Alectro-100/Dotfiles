#!/usr/bin/env python3

import sys
import subprocess
from pathlib import Path

RED = "\033[38;2;244;0;0m"
YELLOW = "\033[38;2;244;200;75m"
GREEN = "\033[38;2;0;244;0m"
HL="\033[1m"
NC = "\033[0m"

UseCompression = False
Compression_level = "-4";
Output = ""
File = ""

def Usage():
    print("-f, --file           Output file name");
    print("-o, --output         Same as -f");
    print("-z, --compress       Use Compression");
    print("-[0-9]               Compression level");

class Log:
    OFF = -1;
    l_Error = 0;
    l_Warning = 1;
    l_Info = 2;

    _level = l_Info;

    @classmethod
    def SetLevel(cls, level):
        cls._level = level;

    @classmethod
    def INFO(self, info):
        if self._level >= self.l_Info:
            print(f"[{HL}{GREEN}INFO{NC}]: {info}");

    @classmethod
    def WARNING(self, warning):
        if self._level >= self.l_Warning:
            print(f"[{HL}{YELLOW}WARNING{NC}]: {warning}");

    @classmethod
    def ERROR(self, error):
        if self._level >= self.l_Error:
            print(f"[{HL}{RED}ERROR{NC}]: {error}");

def create_tarball(input_files_arr, output_name):
    tar_name = output_name + ".tar";
    subprocess.run(
            ["tar", "--create", "--file", output_name] + input_files_arr,
            check=True
    )
    Log.INFO("Created tarball {tar_name}");

def CmdLine():
    global UseCompression, Compression_level, Output
    args = sys.argv[1:];
    i = 0;
    while i < len(args):
        if args[i].startswith("-"):
            if args[i] == "-o" or args[i] == "--output":
                Output = args[i + 1];
                Log.INFO(f"Output: {Output}");
            elif args[i] == "-f" or args[i] == "--file":
                Output = args[i + 1];
                Log.INFO(f"Output: {Output}");
            elif len(args[i]) and args[i][1].isdigit():
                Compression_level = args[i];
                Log.INFO(f"Compression level: {Compression_level}");
            elif args[i] == "-z" or args[i] == "--compress":
                UseCompression = True;
                Log.INFO(f"Use Compression: {UseCompression}");
            elif args[i] == "-h" or args[i] == "--help":
                Usage();
        else:
            check(args[i]);
        i += 1;

if __name__ == '__main__':
    CmdLine();
    Log.SetLevel(Log.l_Info);
    Log.INFO("Yesh It works");
    Log.WARNING("It doesn't feel good");
    Log.ERROR("Something is really nuked well, fr");

