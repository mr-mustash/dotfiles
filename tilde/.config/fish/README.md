# Fish

<p align="center">
    <img src="https://i.imgur.com/rcIasR6.png">
</p>

Hello, and welcome to my overly complicated Fish config. This has been evolving over the last 10 years and it's now in a place where I find it both extensible and performant. Please see the individual sections below for more detail about how it all works.

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

## Functions

## Completions

All of these completions are managed by homemaker and symlinked into the completions directory.

## Vim Integration

Most of my day-to-day works occurs inside of Vim, so I thought I would make my terminal function like Vim as well. I have Fish's wonderful vi-mode turned on, as well as many aliases that'll open Vim on different conditions.

## FZF

Since Fish does not have a built in history search function I've decided to use FZF's ctrl-r feature as a replacement.

## Greets

- [@zgracem](https://github.com/zgracem) for the [modular prompt idea](https://github.com/zgracem/dotconfig/tree/master/fish). It changed the entire way of how I think about building a prompt.
- [@matchi](https://github.com/matchai) for creating [spacefish](https://github.com/matchai/spacefish) that inspired the look of my prompt, and it's ideas around modularity.
