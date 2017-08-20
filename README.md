## Introduction

This is a docker container for syncing your OneDrive data, based on the
[OneDrive Free Client](https://github.com/skilion/onedrive).


## Setting up the application

Unfortunately, due to the requirement of authenticating with the OneDrive
service via OAuth, the first run must be an *interactive* run.

#### Step 1

```shell
docker pull remyjette/onedrive
```

#### Step 2

```shell
docker run -it --restart on-failure --name onedrive
  -v /path/to/onedrive:/onedrive
  remyjette/onedrive
```

*Note:*

* Update `/path/to/onedrive` to your actual path where you would like to store your OneDrive files.
* `--restart on-failure` is to cause the container to restart if the sync times out due to poor network connectivity.

#### Step 3

1. The container will provide you with an authentication URI. Copy it and visit it in your browser.

2. Authenticate with your Microsoft Account.

3. After you accept the application, your browser will redirect to a blank page with the response URI in the address bar.

4. Copy the URI to the prompt and hit `Enter`

#### Step 4

You can keep the docker container running in the foreground.

-- or --

You can hit `CTRL-C` to stop it and then restart the container.

```shell
docker start onedrive
```

## Additional options

#### Skipping file patterns

If you would like this container to skip any file patterns, set the
`SKIP_FILES` environment variable. Patterns are case insensitive. `*` and `?`
wildcards characters are supported. Use `|` to separate multiple patterns.
By default, the pattern is `.*|~*`, skipping all files that begin with a
`.` or `~`.

#### Selective Sync

To use Selective sync, create a file named `skip_file` and list the files
and folders you want to sync. Each line of the file represents a path to a
file or directory relative from the root of your OneDrive.

Here is an example:
```
Backup
Documents/latest_report.docx
Work/ProjectX
notes.txt
```

Once you have created your `skip_file`, mount it in your container as `/skip_file`:

```shell
docker run -it --restart on-failure --name onedrive
  -v /path/to/onedrive:/onedrive
  -v /path/to/skip_file:/skip_file
  remyjette/onedrive
```
