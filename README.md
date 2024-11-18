Oppgave 1.

Leveranse 1A)

https://xn7zuklare.execute-api.eu-west-1.amazonaws.com/Prod/generate-image
Metode: Post
Headers: Key (Content-Type) Value (application/json)

<img width="1013" alt="Skjermbilde 2024-11-12 kl  16 21 49" src="https://github.com/user-attachments/assets/30148d8a-8de5-4e09-b6e0-5542a33d8bd8">

(Skriv nærmere etterhver)!

Hardkodingen av bucket navnet, er fjernet. Bruker ikke Generate_image.py, men app.py!


Leveranse 1B)

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11801270674/job/32874193779

Lenke til vellykket bygging med github actions!


Lenke til sqs kø:
https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36

aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36 --message-body "A red screen"
Filteret til bedrock modellen er svært sensitivt, så enkelte ord kan blokkere!

Vellykket kjøring av terraform:

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11822484249/job/32939630155

Teste workflowen fra en annen brach, kun terrafrom plan ikke apply:

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11822624088/job/32940076529

3b)
https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11891097246/job/33131140234
docker run -e AWS_ACCESS_KEY_ID=<din-aws-access-key-id> \
  -e AWS_SECRET_ACCESS_KEY=<din-aws-secret-access-key> \
  -e SQS_QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/244530008913/image-generation-queue-36 \
  markuspgr301/java-sqs-client "me on top of a pyramid"   
  (sjekk om dette også er riktig etterpå!)


Tagge stategi: Latest; skriv mer om dette senere NB!!!!!!!!!!!!!!!

<img width="1146" alt="Skjermbilde 2024-11-18 kl  13 24 50" src="https://github.com/user-attachments/assets/a72d440b-997d-4e6f-8aeb-a33500b311a5">
Etter å ha deaktivert SQS triggeren til lambda funkjsonen og sendt mange meldinger, slo den over til alarm og epost ble sendt til spesifisert epostadresse fra varibles.tf


