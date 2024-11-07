---
title: Development tools
description: Set up a working environment for developing software
author: Stephen Taylor
---
# Tools for the job

!!! abstract "Like any craftperson, you need the right tools on hand. Some of them are likely to be new to you."

These tools are rich in commands, features and options, but as a solo developer you do not need more than the basics.
You will find ample tutorials on the Web. 

For each, take some study time to familiarise yourself with the basics and bookmark where to learn more when you need it.


## :fontawesome-solid-terminal: Command shell

This is where you command  the computer’s operating system to run programs or copy, move or delete files.

The *command shell* is a window in which the computer executes commands you type, not unlike the APL session. 
The Windows command shell is [PowerShell](https://learn.microsoft.com/en-gb/powershell/), and the Mac command shell is the Terminal app, which runs [Zsh](https://www.zsh.org).
(If you use Linux, you will almost certainly already be familiar with the Bash or Zsh command shells.)

Example: Delete all files with extension `doc`:

=== ":fontawesome-brands-windows: Windows"

	```dos
	> del *.doc
	```

=== ":fontawesome-brands-apple: macOS"

	```bash
	$ rm *.doc
	```

=== ":fontawesome-brands-linux: Linux"

	```bash
	$ rm *.doc
	```

Commands can be combined into programs and saved in files as scripts.


## Regular expressions

Operating-system commands rely heavily on [Regular Expressions](https://en.wikipedia.org/wiki/Regular_expression), a syntax for patterns that can be matched to text strings. 

For example the regex `*.doc` matches the name of any file with the `doc` extension. 


## APL user commands

APL [User Commands](FIXME) are like operating-system commands, but run inside your session. Just as you can define your own shell commands, you can define your own APL user commands.


## :fontawesome-solid-code-branch: Source-code manager

You are already using [Link](https://dyalog.github.io/link), which stores your code and variables in text files.
Those files are your *code base*, and your code base needs managing.

You manage it so you always have a tested, working version, known as the `main` branch.
(Perhaps one should think of it as the *trunk*.)
To improve it, you *check out* a new *feature branch* to edit.
When you are satisfied with the changes, you *merge* them back into the trunk – the `main` branch. 

Each merge into the trunk is recorded as a *commit*.
A commit functions as a save point. 
If you find you need to, you can ‘roll back’ to an earlier commit. 
Nothing is lost. 
And you can easily inspect the differences between two commits.

The most widely used source-code manager is [Git](https://git-scm.com).

> [DadoFlow](https://github.com/the-carlisle-group/Dado/wiki/DadoFlow-Introduction) is a radically simplified Git branching model and workflow designed for APL programmers.
 
> :fontawesome-brands-youtube:
> [A Git workflow for Dyalog APL](https://youtu.be/VuAYeDYmh6g)



## :fontawesome-solid-code: Interactive development environment

The Dyalog IDE is all you need for editing, running and debugging your APL code, but lacks tool for search-and-replace. 
For example, suppose you need to change all references to `GLOBALVAR` to `GLOBAL_VAR`?

-   If you are familiar with the [Visual Studio Code](https://code.visualstudio.com) IDE, you might prefer to edit your code in that.
-   A good text editor will allow you to search and replace through folders of files. (Some popular choices are [Sublime Text](https://www.sublimetext.com) and [Atom](https://atom-editor.cc).)
-   The [Fire](https://github.com/aplteam/Fire) APL package offers a GUI for find-and-replace within the workspace. 



## :fontawesome-brands-github: GitHub

[GitHub](https://github.com) is a platform on which developers share code and collaborate on it.
As a solo developer you can manage without it, but GitHub is a great way to back up (all versions of) your source.
Your users would probably prefer you keep backups somewhere safe!

Git will show you the differences (diff) between two commits, but if you‘re using it from the command shell its diff displays can be a little cryptic. 
A GitHub diff is easier to read.


## :fontawesome-solid-clipboard-list: Tests

As you wrote your code, you wrote expressions to confirm it returns the right results. 

Now, as you extend and modify your system, use tests to ensure your changes don’t break anything that worked before. 
Good practice is to keep a *suite* of test cases and run all of them before merging a feature branch back into the trunk. 

The test suite grows as you add features to the code.

Any time a bug is identified, start by writing a test that replicates the problem (i.e. fails), edit the code until the test passes, then run the whole suite to check you didn’t break anything else.

Consider practising [Test-Driven Development](https://en.wikipedia.org/wiki/Test-driven_development): for each new feature, treat its absence as if it were a bug, and start by writing the tests it is to pass. 

You need a way of running tests and inspecting the results.

:fontawesome-solid-hand-point-right:
[Devt Tools/Testing](devtools/testing.md)


## :fontawesome-solid-boxes-stacked: Packages

Feel free to write all the APL code you need by yourself! (Such fun.)
Or – use or adapt packages written by other APLers who have had to deal with the same problem. 

The [Tatin package manager](https://tatin.dev/) manages APL code libraries to ensure you get the packages and versions you want.

The [Cider project manager](https://github.com/aplteam/Cider/blob/main/html/Cider-User-Guide.html) keeps track of which versions of which packages your application uses, and the packages on which they themselves depend.

Tatin and Cider are included wth Dyalog 19.0 and better.




*[GUI]: Graphical user interface
*[IDE]: Interactive development environment