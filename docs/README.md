<h1 align="center">
  <p align="center">
    <a href="https://github.com/z-shell/zi">
      <img align="center" src="https://github.com/z-shell/zi/raw/main/docs/images/logo.png" alt="Zi Logo" width="80" height="80" />❮ Zi ❯ Playground
    </a>
  </p>
</h1>
<h2 align="center">
  <div align="center">
    <img align="center" src="zi_playground.gif" alt="z-shell/playground" width="100%" height="100%" />
  </div>
</h2>

<h3 align="center">

  [![▶️ Playground](https://github.com/z-shell/playground/actions/workflows/run.yml/badge.svg)](https://github.com/z-shell/playground/actions/workflows/run.yml)
  
</h3><hr />

### Pull-requests welcomed!

Feel free to submit your `zshrc` if it contains `zi` commands.

You can either:

- open a PR – fastest method
- submit an issue with URL to the zshrc (or with the zshrc pasted) – [a quick link](https://github.com/z-shell/playground/issues/new?assignees=&labels=&template=request-to-add-zshrc.md)

## The repository structure

The structure of the repository is very simple:

- Directories named after the user-names of the submitting users.
- In those directories there are files that the user decided to share.
- For additional installs/setup, create and fill `bootstrap.zsh`

## Try configurations with docker

### Requirements

You should have present on your system:

- `zsh > 5.3`
- [docker](https://docs.docker.com/install/) - `curl https://get.docker.com | sh`
- [fzf](https://github.com/junegunn/fzf) or [fzy](https://github.com/jhawthorn/fzy) in your `$PATH`.

#### You might choose to install via zi

Install fzf:

```shell
zi ice from"gh-r" as"command"
zi load junegunn/fzf-bin
```

Install fzy:

```shell
zi ice as"command" make"\!PREFIX=$ZPFX install" \
  atclone"cp contrib/fzy-* $ZPFX/bin/" \
  pick"$ZPFX/bin/fzy*"
zi load jhawthorn/fzy
```

Keep in mind you will need a few Gb of free space to store docker images.

### Running a configuration

To try a configuration, you have to clone this repository and execute a `run.sh` script:

```shell
git clone 'https://github.com/z-shell/playground'
./playground/run.sh
```

Install and run this repository as a `zsh` plugin!

```shell
zi load z-shell/playground
playground
```

Now you will have to wait for a few minutes, while the required environment is
being installed into the docker image. The next time you will want to try a configuration, loading it will take less time.
