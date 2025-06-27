# JFlex Parser Build and Run Guide

## Build Process

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

### Alias Build:
```bash
alias build='jflex ./scanner.jflex & java java_cup.Main ./parser.cup & javac *.java'
```
oppure

```bash
alias build='jflex ./scanner.jflex & java java_cup.MainDrawTree ./parser.cup & javac *.java'
```

### Run:
```bash
java Main input.txt
```

### Run alias:
```bash
alias run='java Main input.txt'
```

### Build && run:
```bash
alias build_run='jflex ./scanner.jflex & java java_cup.Main ./parser.cup & javac *.java & java Main input.txt'
```
oppure

```bash
alias build_run='jflex ./scanner.jflex & java java_cup.MainDrawTree ./parser.cup & javac *.java & java Main input.txt'
```