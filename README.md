# LabBD
"Database Laboratory" Class Team Project - University of Pisa


**Team:** Betola Gianmarco, Catania Saverio, Chen Davide, Li Malio, Pardini Luca, Stasula Ruslan

## Una Cervecita Fresca  

La birra fatta in casa è un'attività che riceve crescente attenzione da parte degli appassionati. Ogni birraio amatoriale possiede un'attrezzatura per il processo di produzione della birra su piccola  scala  (bollitori,  fermentatori,  tubi,  ecc.)  con  una  certa  capacità  massima  di fermentazione: il numero di litri che l'attrezzatura è in grado di gestire in un unico "lotto". La preparazione della birra richiede anche ingredienti, le cui quantità effettive variano da una ricetta all'altra, questi sono vari tipi di malto, luppolo, lieviti e zuccheri (e, naturalmente, acqua). 

Ai  birrai  piace  registrare  le  proprie  ricette  per  riferimento  futuro  e  mantenere  un  elenco aggiornato degli ingredienti disponibili per fare acquisti prima della successiva produzione.

L'obiettivo di questo progetto è quello di sviluppare un'applicazione per i birrai domestici che consenta loro di mantenere un elenco di ricette e adattare quelle esistenti. L'applicazione deve anche: 
* mantenere un elenco di ingredienti disponibili;
* aggiornare questo elenco dopo un ciclo di produzione e quando vengono acquistati nuovi ingredienti; 
* produrre liste della spesa per il lotto successivo;
<br>

**Scopo del progetto**

Realizzazione di un Database ORACLE completo di analisi, progettazione dei dati e realizzazione di procedure ed interfaccia per l'applicazione web 'Una Cervecita Fresca'.
<br>  

**Descrizione del progetto**

“Una  cervecita  fresca”  è  un'applicazione  che  consente  ai  produttori  amatoriali  di  birra  di mantenere un database organizzato delle loro ricette di birra. L'applicazione consente agli utenti  di  creare,  archiviare  e  modificare  ricette,  e  successivamente  eliminarle,  se  l'utente desidera  farlo.  L'applicazione  è  destinata  solo  ai  produttori  di  birra  con  metodo  all-grain (https://www.birradegliamici.com/fare-la-birra/all-grain/),  e  quindi  tutte  le  ricette  sono  per questo tipo di birre (le birre "estratto" non sono supportate).

Ogni birrificio domestico dispone di un'attrezzatura specifica, le cui caratteristiche portano a una particolare "dimensione del lotto": il numero massimo di litri che possono essere prodotti in una singola produzione. Le ricette prevedono, oltre all'acqua:
* malti
* luppolo
* lieviti
* zuccheri
* additivi

Mentre  i  produttori  di  birra  preferiscono  creare  ricette  riferendosi  a  valori  concreti,  come chilogrammi di un particolare malto o grammi di un particolare luppolo, l'applicazione deve memorizzare queste ricette in una misura "assoluta", che consente una conversione diretta della ricetta quando l'apparecchiatura, e di conseguenza la dimensione del lotto, è diversa. Ad esempio, una possibilità è esprimere la quantità di malto in percentuale del totale e usare i grammi per litro di miscuglio (mash) per il luppolo.

Oltre  alle  ricette,  l'applicazione  deve  conservare  le istanzedella  ricetta,  ovvero  singole produzioni basate su una ricetta; queste istanze possono essere accompagnate da note per fare riferimento a problemi che possono influire sulla birra risultante, note che i produttori di birra  vorrebbero  rimanessero  memorizzate.  Un  particolare  tipo  di  nota  sono  le  note  di degustazione, che consentono ai birrai di tenere traccia delle opinioni su una birra di un dato lotto.

Oltre a queste funzionalità più tradizionali, l'applicazione “Una cervecita fresca”, mantiene un elenco  di  ingredienti  disponibili.  Ciò  consente  ai  birrai  di  avere la  lista  degli  ingredienti mancanti per la prossima produzione. Un'istanza della ricetta, ovvero una produzione di birra, dovrebbe consentire agli utenti di aggiornare l'elenco degli ingredienti disponibili, sottraendo gli ingredienti usati da quelli disponibili.

Sarà  inoltre  possibile  per  i  birrai  vendere  la  birra  prodotta.  L’applicazione  deve  offrire un’interfaccia web per la prenotazione e la vendita. Un cliente registrato può prenotare un lotto di birra in produzione, oppure parte di esso. Quando il lotto è stato prodotto, il birraio può confermare  le  prenotazioni  e  procedere  con  la  vendita  oppure,  se  non  è  soddisfatto  del prodotto, cancellarle, per non danneggiare il proprio buon nome. La birra non prenotata può essere messa in vendita e comprata da utenti registrati.  

**Scopo dell’applicazione**

Il sistema deve implementare le funzionalità sopra descritte, ovvero creazione, modifica e cancellazione di ricette, creazione di istanze di ricette (birre), supporto per le note sulle birre, controllo  degli  ingredienti  disponibili,  supporto  alla  produzione  con  allarmi,  supporto  alla vendita. 
