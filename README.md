# JFlex Parser Build and Run Guide

Every directory contains a mini compiler, each one with a specific use case.



## Build Process
Fistly it needed the installation of jflex and java_cup you can find the guide installation here https://www.skenz.it/compilers.

Here are some useful commands that can be executed only on Linux.

### Step-by-step compilation:

```bash
jflex ./scanner.flex
java java_cup.Main ./parser.cup
java java_cup.MainDrawTree ./parser.cup
javac *.java
java Main input.txt
```

## Quick Commands

### Build (parallel execution):
```bash
jflex scanner.flex & java java_cup.Main parser.cup & javac *.java
```

### Run:
```bash
java Main input.txt
```


## Alias are vary usefull

### Alias Build:
```bash
alias build='jflex ./scanner.jflex & java java_cup.Main ./parser.cup & javac *.java'
```
or

```bash
alias build='jflex ./scanner.jflex & java java_cup.MainDrawTree ./parser.cup & javac *.java'
```


### Run alias:
```bash
alias run='java Main input.txt'
```

### Build && run:
```bash
alias build_run='jflex ./scanner.jflex & java java_cup.Main ./parser.cup & javac *.java & java Main input.txt'
```
or

```bash
alias build_run='jflex ./scanner.jflex & java java_cup.MainDrawTree ./parser.cup & javac *.java & java Main input.txt'
```
