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

Vellykket kjøring av terraform:

https://github.com/Markushagen1/TestDevOpsEksamen/actions/runs/11822484249/job/32939630155

# Oppdatering for test
