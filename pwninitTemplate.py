#!/usr/bin/env python3

from pwn import *
import os

{bindings}

context.binary = {bin_name}

def conn():
  if args.REMOTE:
    r = remote("addr", 1337)
  else:
    if args.GDB:
      os.system('ssh-keygen -f "~/.ssh/known_hosts" -R "[localhost]:24889"')
      s = ssh(user="root", host='localhost', port=24889)
      r = s.process(["/mnt/"+exe.path.split("/")[-1]])
      gdb.attach(r)
    else:
      r = process({proc_args})
  return r


def main():
  r = conn()
  # good luck pwning :)
  r.interactive()


if __name__ == "__main__":
  main()
