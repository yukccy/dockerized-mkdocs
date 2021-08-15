# Mkdocs

Docker image for Mkdocs.

## Producing the website

Make sure there is a Mkdocs project in your directory.
You can build the mkdocs project as follows:

```bash
$ docker run -v <local mkdocs directory>:<container mount point to mkdocs dir> <docker image name> produce <container mount point to mkdocs dir>
```

Example:
```bash
$ docker run --rm -v /home/mkdocs-website/project:/mkdocs/project yukccy/mkdocs produce /mkdocs/project/site > result.tar.gz
```

This command will generate a tar.gz file (result.tar.gz in the example), which is a directory created from mkdocs build.

## Running the website

You can serve the mkdocs project as follows:

```bash
$ cat <compressed mkdocs site> | docker run --rm -p 8000:8000 -i <docker image name> serve
```

Here is an example you can find in the serve.sh file:
```bash
$ cat result.tar.gz | docker run --rm -p 8000:8000 -i yukccy/mkdocs serve
```

You will be able to browse the website by http://localhost:8000 

## .gitlab-ci.yml

The project repository comes with a .gitlab-ci.yml file which includes build and test stage. 

For Build stage, it builds the docker image and push to GitLab Container Registry, with result.tar.gz as the artifact.

For Test stage, it extracts the result.tar.gz from Build stage, and cat the index.html, which proves that the mkdocs build works and it can work as an static website immediately.

## Commit history

This project has pushed to a public GitLab repository. You can check the commit history from https://gitlab.com/ccy_yuk/mkdocs-docker-sre-challenge/-/commits/master.