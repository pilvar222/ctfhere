#!/usr/bin/env python3

from pwn import *
import os
from pathlib import Path
import sys

{bindings}

context.binary = {bin_name}

# https://stackoverflow.com/questions/43878953/how-does-one-detect-if-one-is-running-within-a-docker-container-within-python
def is_docker():
    cgroup = Path('/proc/self/cgroup')
    return Path('/.dockerenv').is_file() or cgroup.is_file() and 'docker' in cgroup.read_text()

def conn():
  if args.REMOTE:
    r = remote("addr", 1337)
  else:
    if args.GDB:
      if not is_docker():
        os.system('ssh-keygen -f "~/.ssh/known_hosts" -R "[localhost]:24889"')
        s = ssh(user="root", host='localhost', port=24889)
        s.set_working_directory('/mnt/') # hacky way to fix challenges with relative imports. TODO: make something cleaner that this with a pwninit patch
        r = s.process(["/mnt/"+exe.path.split("/")[-1]])
        gdb.attach(r)
        import time
        time.sleep(1)
      else:
        r = process({proc_args})
        gdb.attach(r)
    elif is_docker() or args.DANGER:
      r = process({proc_args})
    else:
      error("You are not running from a container. Please use REMOTE, GDB, or DANGER argument. (GDB and REMOTE are safe. DANGER will run the binary on your host machine.)")
      sys.exit(1)
  return r


def main():
  r = conn()
  # good luck pwning :)
  r.interactive()


if __name__ == "__main__":
  main()
