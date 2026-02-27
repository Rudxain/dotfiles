#!/usr/bin/env python3
from typing import Final
from sys import argv, exit

def main(args: list[str]) -> int | None:
	print("hello world")

if __name__ == "__main__":
	exit(main(argv[1:]))
