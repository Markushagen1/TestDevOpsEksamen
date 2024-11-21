Oppgave 1.

Leveranse 1A)

https://xn7zuklare.execute-api.eu-west-1.amazonaws.com/Prod/generate-image

Metode: Post

Headers: Key (Content-Type) Value (application/json)

<img width="1013" alt="Skjermbilde 2024-11-12 kl  16 21 49" src="https://github.com/user-attachments/assets/30148d8a-8de5-4e09-b6e0-5542a33d8bd8">


Leveranse 1B)

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11801270674/job/32874193779

- Lenke til vellykket bygging med github actions!

Leveranse 2b)

Lenke til sqs kø:

https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36

aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36 --message-body "A red screen"
 - Filteret til bedrock modellen er sensitivt og enkelte ord kan blokkeres, so keep it PG friendly!!!

Vellykket kjøring av terraform:

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11822484249/job/32939630155

Teste workflowen fra en annen brach, kun terrafrom plan ikke apply:

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11822624088/job/32940076529

3b)

  markuspgr301/java-sqs-client

  https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36

docker run -e AWS_ACCESS_KEY_ID=<hemmelig_id> \
  -e AWS_SECRET_ACCESS_KEY=<hemmelig_nøkkel> \
  -e SQS_QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36 \
  markuspgr301/java-sqs-client "me on top of a pyramid"   
  

Tagge stategi Latest; 

Jeg valgte å benytte meg av tagge strategien Latest ettersom dette er standarden under utvikling. Dette forenkler flyten under utvikling ved å eliminere behovet for å endre tag referanser i config filer og pipelines. Når nye versjoner bygges og pushes med latest taggen, kan miljøer som trekker inn denne taggen automatisk hente de nyeste versjonene. Dette skaper en konsistens under utvikling eller i testmiljøer ved at man alltid jobber med den nyeste versjonen. Dersom dette skulle vært i et produksjonsmiljø hadde det vært hensiktsmessig å legge ved versjonsbaserte tagger også, eksempelvis V1.3.9....

4 )
Liten kommentar til metrics:

For å fremprovosere en alarm kan enkelte verdier i terraform konfigurasjonen endres ettersom lambda funksjonen prosseserer raskt med nåværende konfigurasjon.
  - batch size 10 -> 1
  - Visibility timeout 120 -> 60
  - Threshold for alarm -> Kan settes enda lavere enn 30 sec

Kan fremprovoseres ved:

for i in {1..50}; do 
  aws sqs send-message \
    --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36 \
    --message-body "A blue flamingo, version $i" \
    --region eu-west-1
  sleep 0.2
done

Sender avgårde 50 meldinger for å fremprovosere alarmen, og blir varslet via mail. 

Oppgave 5)

1. Automatisering og kontinuerlig levering (CI/CD): Hvordan påvirker serverless-arkitektur sammenlignet med mikrotjenestearkitektur CI/CD-pipelines, automatisering, og utrullingsstrategier?

Både mikrotjenester og serverless deler et felles mål om å forbedre fleksibiliteten og skalerbarheten til applikasjoner som ofte er svært komplekse. De deler flere likheter, men det er allikevel noen viktige forskjeller å vurdere før man tar et valg ettersom de påvirker CI/CD pipelines, automatisering og utrullingsstrategier forskjellig.

I en mikrotjeneste arkitektur deler man opp en applikasjon i mindre uavhengige tjenster som kommuniserer via et nettverk. Disse tjenestene er ofte pakket inn i containere som tilrettelegger for standardiserte CI/CD pipelines ved hjelp av etablerte verktøy som Docker og Kubernetes. Dette forenkler prosessen for å bygge, deploye og teste applikasjonen.

Ved bruk av en serverless arkitektur derimot, håndteres infrastrukturen av skyleverandøren. Dette forenkler utviklingen, men kan komplisere CI/CD prosesser. Her bygges og testes hver funksjon separat (isoleres) og lokale testmiljøer kan være vanskelig å sette opp. Automatisering skjer via verktøy som kan definere infrastruktur som kode, et slikt verktøy er Terraform som vi har benyttet oss av. Utrullingsstrategier som gradvis utrullig kan bli mer komplisert på grunn av at hver funksjon fungerer "selvstendig". 

Dersom man velger serverless kan man redusere kostnader og enklere tilpasse infrastrukturen, men det krever dog større tilpassing av utviklings og testprosesser. Mikrotjenester kan gi mer kontroll og benytter seg av etablerte praksiser, men kan dermed øke kompleksiteten og kostander. 

2. Observability (overvåkning): Hvordan endres overvåkning, logging og feilsøking når man går fra mikrotjenester til en serverless arkitektur? Hvilke utfordringer er spesifikke for observability i en FaaS-arkitektur?

Overgangen fra en mikrotjeneste arkitektur til en serverless arkitektur påvirker overvåkning, logging og feilsøking betydelig. Mens mikrotjenester legger til rette for et velkjent rammeverk for observability, introduseres utfordringer med serverless knyttet til funksjonenes kortvarige og hendelsesbaserte natur.

Ved en mikrotjeneste arkitektur kjører tjenester kontinuerlig i dedikerte containere. Dette gir oss muligheten for stabile strømmer av metrikker som CPU bruk, minne bruk og nettverksflyt. Verktøy som Prometheus og Grafana gjør det enkelt å innsamle å visualisere denne dataen. Logghåndtering med Elasticsearch, Fluentd og Kibana gir muligheten for å standardisere løsninger for ulike logger. Tracing med verktøy som Jaeger eller Zipkin tilrettelegger for detaljert sporing av forespørsler gjennom flere tjenester. Denne tilgangen til flere gode overvåkningsverktøy hjelper med å identifisere og løse problemer. Dette gjøres ofte med å simulere hendelser lokalt i test/utviklings miljøer. 

Men mikrotjenester har også sine utfordringer. Arkitekturen kan gjøre det utfordrende å konfigurere overvåkning for hver enkelt tjeneste, og avhengigheter tjenestene imellom kan gjøre det vanskelig å identifisere hva årsaken til problemene faktisk er. Logging kan fort bli en stor kostnadspost dersom store mengder data genereres, så dette må håndteres riktig. Administrasjonen av infrastruktur med skalering og oppdatering, legger et også stort ansvar på utviklingsteamet.

I en serverless arkitektur er mye av infrastrukturen "satt bort" til skyleverandøren, dette reduserer administrasjonsbyrden og gjør det mulig å fokusere på forretningslogikken. Funksjonenes korte levetid og en hendelsesbasert modell stiller imidlertid nye krav til overvåkning. Loggingen og overvåkningen må tilpasses slik at de kan fange opp data i korte tidsvinduer, samtidig som behovet for sentralisert logging øker. Her kan verktøy som AWS CloudWatch spille en viktig rolle. En utfordring er at utviklerne i større grad må stole på skyleverandørens verktøy, noe som kan ha begrenset fleksibilitet og ikke alltid gir tilgang til ønsket informasjon.

Spesifikke utfordringer ved serverless inkluderer problemer som kaldstart, hvor funksjoner som ikke brukes ofte trenger lengere tid på å starte opp. Dette krever nøye overvåkning for å sikre jevn ytelse. Det må også håndteres kostnadssporing for funksjonskall, overvåkning av minnebruk, og håndtering av timeout-hendelser. Feilsøking av problemer i produksjon er også mye mer komplisert ettersom man ikke har tilgang til underliggende infrastruktur.

På den positive siden reduserer serverless administrasjonsarbeidet, noe som gjør det enklere å skalere applikasjoner med en ujevn belastning. Skyleverandøren tar ansvar for mye av infrastrukturen, inkludert skaleringslogikk og feiltoleranse. Dette gjør serverless til et godt valg for mindre komplekse applikasjoner eller de som har svært varierende trafikk. Samtidig kan denne begrensede kontrollen over overvåking og mangelen på mulighet for lokal testing føre til utfordringer når man skal feilsøke problemer som oppstår.

Avslutningsvis gir mikrotjenester større kontroll over observability og er godt egnet for mer komplekse systemer som krever stabilitet og forutsigbarhet. Serverless på den andre enden, gir forenklet drift og er ideelt for applikasjoner med variabel belastning, men krever tilpasning til skyleverandørens verktøy og modeller. Når man skal velge  mellom de to, bør valget baseres på applikasjonens behov for fleksibilitet, kompleksitet og ressursstyring.


3. Skalerbarhet og kostnadskontroll: Diskuter fordeler og ulemper med tanke på skalerbarhet, ressursutnyttelse, og kostnadsoptimalisering i en serverless kontra mikrotjenestebasert arkitektur.

Når vi tenker på skalerbarhet, ressursutnyttelse og kostandskontroll har både mikrotjenester og serverless fordeler og ulemper. Valget mellom de to avhenger av applikasjonens spesifikke krav. Den kanskje største fordelen med serverless er den innebygde skalerbarheten. Funksjonene kan skalere opp eller ned etter etterspørsel. Dette gjør det til et godt valg for applikasjoner som får uforutsigbar trafikk. Ved lav trafikk minimeres resurssbruken og omvendt, imens man kun betaler for det man faktisk bruker. I motsatt ende krever mikrotjenester manuell konfigurasjon av skalering, for eksempel igjennom containere som kjøres i Kubernetes. Enda dette fører til bedre kontroll, innebærer dette ofte høyere faste kostnader ettersom tjenestene kjøres som "normalt" enda trafikken er lav. 

Kostnadsoptimalisering ved serverless-arkitektur er tett knyttet opp til den hendelsesbaserte modellen, hvor man kun betaler for de ressursene man faktisk bruker. Eksempler kan være kjøretid og ressursbruk per funksjonskall. Serverless er dermed svært atteraktivt for applikasjoner med mange små uavhengige oppgaver. Men serverless kan også fort bli dyrt dersom man har mange langvarige eller svært hyppige prosesser hvor en eller fler funksjoner kalles ofte eller kjøres i lengre perioder. Over tid kan dermed mikrotjenester være mer kostandseffektivt ettersom denne modellen har konstant ressursforbruk. 

Når det kommer til ressursutnyttelse blir forskjellene mellom serverless og mikrotjenester merkbare. Serverless maksimerer som kjent ressursutnyttelsen ved å bare tildele ressurser når de faktisk trengs, og "slipper opp" og skalerer ned når ressursene ikke lenger behøves. Dette reduserer kostander, men kan føre til ytelsesutfordinger når det igjen kommer til kaldstart av funksjoner som ikke er blitt brukt på en stund. Ved mikrotjenester er derimot alle ressursene tilgjenlige til enhver tid. Dette sikrer forutsigbarhet. Ulempen med dette er at det kan føre til at man ikke utnytter ressursene man har når trafikken er lav, enda kostnadene løper. 

Kostnadskontroll er et annet aspekt ved serverless som kan by på utfordinger grunnet skyleverandørenes faktureringsmodellen. Det kan på forhånd være vanskelig å forutse kostnader, spesielt om trafikken varierer. Ved mikrotjenester er kostnadene mer forutsigbare, enda de er høyere i perioder med lav utnyttelse. Analyse og overvåkning over ressursbruk er viktig ved bruk av begge arkiteturene, men mikrotjenester er kanskje en knapp foran ved at det gir en mer direkte innsikt og kontroll over ressurser som brukes. 

Vi kan si at serverless er et godt valg for hendelsesbaserte applikasjoner med varierende trafikk og et krav om lavere administrasjon, mens mikrotjenester passer bedre for applikasjoner med en jevnere trafikkflyt og et behov for god kontroll over ressursutnyttelse og ytelse. 


4. Eierskap og ansvar: Hvordan påvirkes DevOps-teamets eierskap og ansvar for applikasjonens ytelse, pålitelighet og kostnader ved overgang til en serverless tilnærming sammenlignet med en mikrotjeneste-tilnærming?

Ved en overgang fra mikrotjeneste tilnærming til en serverless tilnærming endres eierskap og ansvar for applikasjonens ytelse, pålitelighet og kostnader seg for DevOps-team. 

Ved en mikrotjeneste tilnærming har teamene som oftest full kontroll over applikasjonens infratruktur, skalering og feilhåndtering. Dette gir teamet muligheten til å optimalisere ytelsen ved detaljstyring av ressursene, men innebærer samtidig større ansvar for drift. Eksempelvis administrasjon av containere eller orkestrering av Kubernetes. Påliteligheten er sterkt avhengig av teamets evne til å bygge robuste systemer med alt dette innebærer.

Ved en overgang til en serverless tilnærming overføres mye av ansvaret for infrastrukturen til skyleverandøren. DevOps teamet får dermed frigitt oppgaver som å vedlikeholde servere og håndtering av ressursallokering. Skyleverandører garanterer som oftest høy tilgjengelighet og automatisk skalering. Dette fører til redusert ansvar for pålitelighet for teamet. En ulempe ved at dette "settes bort" til skyleverandørene er at teamet kan få mindre kontroll over ytelsen. 

Kostnader er et annet område hvor eierskapet påvirkes ved en overgang fra mikrotjenester til serverless. I mikrotjenester har teamet direkte ansvar for utnyttelsen av ressursene. Teamet kan optimalisere kostnadene ved å benytte seg av verktøy som gir innsikt i den kontinuerlige driften, men dette krever en proaktiv tilnærming for å unngå ressursoverskridelser eller ineffektiv utnyttelse av ressurser. 

Ved serverless skalerer kostandene direkte med bruken. Dette kan både være en fordel og en ulempe. Teamet må ha god oversikt over hvordan funksjoner blir brukt, minimere unødvendige funksjonskall og unngå ineffektiv kode, ettersom dette kan øke kostnadene. 

Til slutt påvirker overgangen fra mikrotjenester til serverless eierskap ved å flytte ansvaret for infrastruktur og skalering til skyleverandøren. Samtidig må teamet ta et mer aktivt ansvar for optimal bruk av den valgte plattformen. Ved mikrotjenester gis større kontroll og fleksibilitet, men desto større kompleksitet og ansvar. Ved serverless reduseres driftsbryden, men god forståelse av skyplattformens kostnadsmodell, egenskaper, ytelse og begrensinger er viktig for å sikre pålitelighet og ytelse. 

  




