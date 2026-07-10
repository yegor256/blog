# How We Run as a Non-Root Inside Docker Container

Source: https://www.yegor256.com/2014/08/29/docker-non-root.html

Docker starts a process inside its container as a "root" user. In some
cases, this is not convenient though. For example, `initdb` from PostgreSQL doesn't like to
be started as root and will fail. In [rultor.com](https://www.rultor.com),
a DevOps team assistant,
[we're using Docker]({% pst 2014/jul/2014-07-29-docker-in-rultor %})
as a virtualization technology for every build we run.

Here is how we change the user inside a running container, right
after it is started.


First, this is how we start a new Docker container:

```bash
$ sudo docker run -i -t --rm -v "$(pwd):/main" \
  yegor256/rultor /main/entry.sh
```

There are two files in the current directory: `entry.sh` and `script.sh`.
`entry.sh` is the file being executed by Docker on start,
and it contains the following:

```bash
#!/usr/bin/env bash
adduser --disabled-password --gecos '' r
adduser r sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su -m r -c /home/r/script.sh
```

`script.sh` will be executed as a user `r` inside the container. And this
`r` user will have `sudo` permissions. This is exactly what all projects,
managing their DevOps procedures with [rultor.com](https://www.rultor.com), need.
