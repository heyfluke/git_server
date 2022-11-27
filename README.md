# Brief & Concept

This is a simple docker image with a basic /home/git layout for serving as a ad-hoc git server. The image is based on alpine Linux which is a very small distro.

Ref to [Git on the Server - Getting Git on a Server](https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server). The simplest git repository is a bare repository which is essentially a folder with .git suffix which can be transfered in the ssh protocol. So a Linux server with sshd can be served as a git server.

It is an easy, reliable and flexable way to deploy the git server as a docker container. 

# Usage & Best practise

For quick start, you need to set at least your public ssh key for accessing the server via ssh.

```
cat ~/.ssh/id_rsa.pub > /tmp/authorized_keys
# I map 2222 to container's 22 to avoid port confliction with sshd in host.
docker run --rm -it -p 2222:22 -v /tmp/authorized_keys:/home/git/.ssh/authorized_keys heyfluke/git_server:latest
```

Now you can either scp a bare repo to the container or ssh into it to clone a new repo.

either:

```
git clone --bare https://my_repo_addr/myrepo # you get myrepo.git
scp -r myrepo.git localhost:/home/git/ -p2222
```

or:

```
ssh git@localhost -p2222
git clone --bare https://my_repo_addr/myrepo
```

You get myrepo.git in git_server. 

So you can clone the repo from git_server now: 

```
git clone ssh://git@localhost:2222/home/git/myrepo.git
```

That's it. 

You may mount the entire /home/git from the host. For me, it's easier to maintain data backup when mounting the directory from a NAS host.

```
docker run --rm -it -p 2222:22 -v $my_synology_nas/docker/git:/home/git heyfluke/git_server:latest
```

