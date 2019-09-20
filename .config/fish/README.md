#`~/.config/fish`

<p align="center">
    <img src="https://i.imgur.com/WidJ8uW.jpg">
</p>

Hello, and welcome to my overly complicated Fish config. This has been evolving over many years and it's now in a place where it's easily extensible and I'm very happy with it. Please see the individual sections below for more detail about how it all works.

## Prompt

### Dynamic Elements
The main aspect of my prompt is that it dynamically changes based on current conditions and folder contents. Out of the gate in my homedir it'll look pretty simplistic:
[Image of my homedir prompt]

However, it can get pretty wild from there. Here are a few examples of the elements that it can load.

A directory with VimScript files:

After running a k8s command inside a golang directory that's in a git repo on a branch:

In a directory with goland and Docker filer after a command took 2 minutes to run and has failed with `SIGINT`:

On a remote host, inside of a Docker container, after running a sucessful `go build`:

### Async Features
The aspect of my prompt that I'm most proud of is making the longest running bits asynchronous. After originally creating this promot I noticed that my `__fish_prompt_git_status` command would take a long time to return in directories with lots of submodules, see: this repo, and I knew that it wouldn't do. Since I was new to Fish I tried a lot of ideas that other people had offered, and none of them seemed to work until I found @MaxMilton's "Pure" Fish theme and it's async features. As of now my prompt will draw almost always in under 50ms and will load in elements as the finish processing.

[GIF of async features running]

### Auto `git fetch`


## Functions

## Vim Integration

## FZF

## Greets
@zgracem for the [modular prompt idea](https://github.com/zgracem/dotconfig/tree/master/fish). Most of my `~/.config/fish/prompt` directory would not be possible without them!
@MaxMilton for creating an [async prompt](https://github.com/MaxMilton/pure/blob/master/functions/__pure_run_async.fish) that works with my setup! I tried different configs for months before finding their ideas.
