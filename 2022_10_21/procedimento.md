#Classic procedimento

- Definisci le regular expression per i token, per i comment e sep
- inserisci gli elementi nel template che richiede il testo dal template nel jflex, aggiungere sth se necessario
- ricoardati di riportare anche quelli in fondo
- scommenta i correspettiivi in parser.cup
- riporta in questa rifa: 

```bash
terminal SEP, TOK1, TOK2, TOK3, S;
```

tutti gli altri simboli che non ci sono nei commenti
- scrivere gli header e ricorda di riportarli nei non terminal
- dopodiche scrivere tutti i body richiesti come il compere
- Inserire anche qui tutti i simobli terminali o non terminali che sono stati usati
- quando è necessario inserire una sematica (es: per expr) è necessario inserire quanto è il valore RESULT a seconda dei casi
- nel momento in cui deve essere inserito in memeoria un qualcosa (per esempio salvare l'ID di una variabile) si deve usare la parse.table (funzione push(k, v) e get(k) ) e modificare il tipo della hashtable, quella nel teplate:
```java
init with {:
		table = new HashMap<String, HashMap<String, Double>>();
:};
```
(ricordarsi di farlo anche sotto)

è la più generica possibiele, se per esmpio vogliamo solo inserire solo valori interi scriveremo

```java
    table = new HashMap<String, Integer>();
```

- aggiungere i marker non terminali, servono quando dobbiamo leggere il rulstato di qualcosa che sta all'interno di un lista
(es quando vigliamo che un exp1 sia uguale a le espressioni all'intero di un qualcos'altro)



