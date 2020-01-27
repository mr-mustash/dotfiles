# `~/.config/fish`

<p align="center">
    <img src="https://i.imgur.com/WidJ8uW.jpg">
</p>

Hello, and welcome to my overly complicated Fish config. This has been evolving over many years and it's now in a place where it's easily extensible and I'm very happy with it. Please see the individual sections below for more detail about how it all works.

## Prompt
### Dynamic Elements
The main aspect of my prompt is that it dynamically changes based on current conditions and folder contents. Out of the gate in my homedir it'll look pretty simplistic:
![](https://i.imgur.com/rrLsmoC.png)

However, it can get pretty wild from there. Here are a few examples of the elements that it can load.

A directory with VimScript files:
![](https://i.imgur.com/xl7MSRs.png)

In a directory with golang and Docker files after a command took 52 seconds to run and has failed with `SIGINT`:
![](https://i.imgur.com/36ZgK3o.png)

After running a k8s command inside a directory with golang that has uncommitted git changes and one job running in the background.
![](https://i.imgur.com/VDGRoWi.png)

### Async Features
The aspect of my prompt that I'm most proud of is making the longest running bits asynchronous. After originally creating this prompt I noticed that my `__fish_prompt_git_status` command would take a long time to return in directories with lots of submodules, see: this repo, and I knew that it wouldn't do. Since I was new to Fish I tried a lot of ideas that other people had offered, and none of them seemed to work until I found [@MaxMilton](https://github.com/MaxMilton) "Pure" Fish theme and it's async features. As of now my prompt will draw almost always in under 50ms and will load in elements as the finish processing.

### Auto `git fetch`
Using the async features above I automatically `git fetch` if it's been more than 10 minutes since it's happened on any given repo. This works great with the `git status` party of my prompt as it'll display a `↓` symbol when I'm behind from origin.

## Functions

## Completions
All of these completions are managed by homemaker and symlinked into the completions directory.

## Vim Integration
Most of my day-to-day works occurs inside of Vim, so I thought I would make my terminal function like Vim as well. I have Fish's wonderful vi-mode turned on, as well as many aliases that'll open Vim on different conditions.

## FZF
Since Fish does not have a built in history search function I've decided to use FZF's ctrl-r feature as a replacement.

## Greets
* [@zgracem](https://github.com/zgracem) for the [modular prompt idea](https://github.com/zgracem/dotconfig/tree/master/fish). It changed the entire way of how I think about building a prompt!
* [@MaxMilton](https://github.com/MaxMilton) for creating an [async prompt](https://github.com/MaxMilton/pure/blob/master/functions/__pure_run_async.fish) that works with my setup! I tried different configs for months before finding their ideas.
* [@matchi](https://github.com/matchai) for creating [spacefish](https://github.com/matchai/spacefish) that inspired the look of my prompt, and some ideas around it's modularity.
