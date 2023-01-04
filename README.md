# sftp
====

Fork of atmoz/sftp:
Simple and easy to use SFTP server based on CentOS

## Usage
-----

- Define users and passwords in comma separated list with SFTP_USERS ("user1:pass1[:uid][:e],user2:pass2[:uid][:e]").
- Mount volumes in user's home folder.
- Supports encrypted password and optional UID specification.

The users are chrooted to their home folders, so it is important to mount the volumes in separate folders inside the user's home folder (/home/your-user/**your-folder**).

### Examples
--------

Simple (one user and one folder):

```
docker run \
    -e SFTP_USERS='foo:123' \
    -v "/sftp/share:/home/foo/share" \
    -p 2222:22 -d atmoz/sftp
```

Multiple users with specific UIDs and folders:

```
docker run \
    -e SFTP_USERS='foo:123:1000,bar:abc:1001' \
    -v "/sftp/share:/home/foo/share" \
    -v "/sftp/ebooks:/home/foo/ebooks" \
    -v "/sftp/http:/home/bar/http" \
    -p 2222:22 -d atmoz/sftp
```

Encrypted password and specified UID:

```
docker run \
    -e SFTP_USERS='foo:$1$xyz$jAlmRpcFe.aiPOIXET9GG/:1050:e' \
    -v "/sftp/share:/home/foo/share" \
    -v "/sftp/ebooks:/home/foo/ebooks" \
    -v "/sftp/http:/home/bar/http" \
    -p 2222:22 -d atmoz/sftp
```

### Docker compose example
```
---
version: "2.1"
services:
  sftp-compose:
    image: akegata/sftp-centos
    container_name: sftp
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      # Any $ in SFTP_USERS needs to be duplicated to be parsed correctly.
      - SFTP_USERS=<user>:<password>:<uid>:e,
                   <user2>:<password>:<uid>:e,
    volumes:
      - <host-dir>/upload:/home/<user>/pool/
      - <host-dir>/upload:/home/<user2>/pool/
    ports:
      - 2200:22/tcp # Allows HTTP access to the internal webserver.

```

#### Generate encrypted password
```
Use atmoz/makepasswd to generate encrypted password:
echo -n "your-password" | docker run -i --rm atmoz/makepasswd --crypt-md5 --clearfrom=-
```
