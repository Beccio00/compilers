# JFlex Parser Build and Run Guide

## Build Process

### Step-by-step compilation:

```bash
jflex scanner.flex
java java_cup.Main parser.cup
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

