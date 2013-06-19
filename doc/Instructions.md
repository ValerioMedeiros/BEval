BIntegration
============

### Advanced instructions

A proof obligation can be solved using diiffents parameters of ProB. Learn more about parameters in [ProB Command Line].

### Main parameters of call


`-p init` - it loads definitions from B module. This parameter is very useful when the proof obligation was not fully expand in only logic and math elements. But this parameter uses more memory and processor. This parameter is obligatory to use,  when the proof obligation has dependency of definitions. For example, the proof obligation `0 : UCHAR` depends of $UCHAR$=0..255 definition. But this proof obligation can be expanded in   `0  :  0..255` and it becomes independent. This parameter can be only disabled when the current proof obligation is fully independent.

`-p KODKOD TRUE` - can be solved using a mixture of SAT-solving and ProB's own constraint-solving capabilities developed using constraint logic programming: the first-order parts which can be dealt with by Kodkod and the remaining parts solved by the existing ProB kernel providing an alternative way of solving B.

`-p SMT TRUE` - it forces ProB to do more aggressive constraint solving.

There are still several different parameters available: time out,  constraint logic programming over finite domains and others. The full list is available in ProB`s web site ([ProB Command Line]).



[ProB Command Line]: http://www.stups.uni-duesseldorf.de/ProB/index.php5/Using_the_Command-Line_Version_of_ProB
