# Com executar els scripts

Els scripts estàn escrits en el llenguatge Coffeescript (http://coffeescript.org/).
Coffeescript és un llenguatge que pot ser o bé interpretat directament o bé compilat a
Javascript. Alhora, Javascript es pot interpretar mitjançant node (instal·lat als PCs de la FIB).

Per poder executar-los cal primer instal·lar l'intèrpret node, si és que no està instal·lat:

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

Un cop instal·lat, ja es poden executar els scripts de la carpeta scripts-js, que ja han sigut compilats a Javascript.

Si es vol executar els codis originals en Coffeescript (que tenen un codi més llegible ja que no estàn compilats), situats a la carpeta scripts,
cal instalar coffeescript mitjançant la comanda:

sudo npm install -g coffee-script

A partir d'aquí, l'ús és independent de si treballem amb els scripts de la carpeta scripts-js o scripts.

Els scripts estàn basats en optim (https://github.com/albertsgrc/optim) un programa de terminal que he estat desenvolupant durant el quadrimestre
i que m'ha servit per automatitzar moltes de les tasques que formen part de la metodologia d'optimització ensenyada a classe. El codi de optim
s'inclou en la carpeta scripts/optim ja que és usat pels scripts de la carpeta superior.

ATENCIÓ: Tots els scripts s'han d'executar desde la carpeta corresponent (scripts o scripts-js) ja que utilitzen paths relatius

Són els següents:

- new: Crea una nova versió optimitzada de ftdock a partir de l'última creada amb el nom indicat. Les versions es guarden a optimizations/sources/3D_Dock/progs/<nom-versió>,
       excepte la versió original, situada a original/sources/3D_Dock/progs.

  EXEMPLE D'ÚS: new library
    Crea una nova versió optimitzada amb el nom 00X-library a partir de la versió X-1, on X-1 és
    el número de l'última versió.

- compile: Permet compilar totes les versions de ftdock optimitzades i la versió original amb un pròposit determinat (check|speedup|assembly|profile|profile_gprof), que determina els flags de compilació.
           Només compila si cal (com el Makefile).
           És utilitzat per els altres scripts per compilar el codi amb el propòsit corresponent abans de realitzar les accions de l'script.
           Els executables de ftdock resultants es guarden a la carpeta execs de l'arrel del projecte.

  EXEMPLE D'ÚS: compile speedup
    Compila totes les versions amb els flags -O3 -march=native

- assembly: Permet visualitzar ràpidament el codi assemblador dels programes. L'assemblador resultant es guarda a execs/assembly/(nom-programa)_(timestamp).s

  EXEMPLE D'ÚS: assembly
    Obté l'assemblador de l'última versió modificada
  EXEMPLE D'ÚS 2: assembly -A
    Obté l'assemblador de totes les versions
  EXEMPLE D'ÚS 3: assembly ftdock-opt001-library
    Obté l'assemblador de la versió 001-library

- check: Permet comprovar que els programes són correctes, comparant el seu output amb el que correspongui de la carpeta outputs.
         Utilitza la funció eq definida a checker.coffee (checker.js a scripts-js) per comprovar l'igualtat de les sortides.
         Només comprova que la columna d'scores tingui diferències de com a molt 2 unitats entre scores situats a la mateixa fila.

  EXEMPLE D'ÚS: check
    Comprova l'última versió modificada amb el test 1
  EXEMPLE D'ÚS 2: check 3
    Comprova l'última versió modificada amb el test 4
  EXEMPLE D'ÚS 3: check a
    Comprova l'última versió modificada amb tots els tests
  EXEMPLE D'ÚS 4: check a -A
    Comprova totes les versions amb tots els tests

- speedup: Permet mesurar mètriques del rendiment dels programes. La sintaxi es la mateixa que pel check,
           canviant check per speedup.

  EXEMPLE D'ÚS 1: speedup
    Calcula i mostra mètriques de rendiment pel test 1 comparant l'última versió modificada amb la penúltima modificada.
  EXEMPLE D'ÚS 2: speedup a -A
    Calcula i mostra mètriques de rendiment per tots els testos i tots els programes en ordre alfabètic. Els speedups són respecte el programa original,
    tot i que especificant la opció --previous es pot fer que l'speedup es calculi respecte l'anterior en ordre alfabètic.
  EXEMPLE D'ÚS 3: speedup a -A -r -f 5
    Igual que l'anterior però realitza 5 execucions per versió i calcula la mitjana de les mètriques.
  EXEMPLE D'ÚS 4: speedup a -A -r 5 -f -C
    Igual que l'anterior però a més genera fitxers en format CSV amb les dades recollides, que es guarden a la carpeta execs/csv

- cs: Combina els dos anteriors (check + speedup), tot i que no es permet l'opció -r ni -C de speedup

    EXEMPLE D'ÚS: cs a -A
      Check i speedup per tots els testos i programes (primer tots els programes pel test1, després tots pels test2, etc.)

- list: Llista els noms de totes les versions disponibles (amb el prefix ftdock-opt)

    EXEMPLE D'ÚS: list

- profile: Permet fer profiling fàcilment. Els profilings resultants es guarden a la carpeta execs/profiling. La sintaxi és la mateixa que pel check i speedup, amb diferents opcions.

    EXEMPLE D'ÚS 1: profile
      Fa profiling de l'última versió modificada amb operf i opannotate amb l'event CPU_CLK_UNHALTED i counter 50000
    EXEMPLE D'ÚS 2: profile a -A -g --forward-options :-l
      Fa profiling de totes les versions amb tots els testos mitjançant gprof amb les opcions -b (per defecte) i -l (indicada)
    EXEMPLE D'ÚS 3: profile ftdock-opt001-library --event branches --counter 500000
      Fa profiling de la versió 001-library amb operf i opannotate amb l'event BR_MISS_PRED_RETIRED i el contador 500000
      Els events disponibles són branches, llc_misses (misses l3), l1 (misses l1), l2 (misses l2), tlb (misses tlb), cycles (CPU_CLK_UNHALTED)

- clean: Serveix per netejar executables i fitxers generats de la carpeta execs

    EXEMPLE D'ÚS 1: clean
      Esborra tots els executables de la carpeta execs

    EXEMPLE D'ÚS 1: clean --ultra-deep
      Esborra tots els executables, carpetes profiling, assembly i csv de la carpeta execs

A vegades (no sé perquè) alguns scripts tenen problemes de permisos per copiar a i esborrar fitxers de la carpeta execs.
Executar sudo chmod a+wr -R execs ho soluciona temporalment, sinó executar els scripts amb sudo és una altra opció.
