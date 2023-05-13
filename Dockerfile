# Pierwszy etap

# Obraz bazowy z node na alpine
FROM node:latest as etapPierwszy
# Etykieta z imieniem i nazwiskiem
LABEL author="Mateusz Nowak"
# Ustawienie katalogu roboczego
WORKDIR /tch_zad1
# Przeniesienie pliku packege json
COPY package.json ./
# Instalacja zależności z pliku package.json
RUN npm install
# Skopiowanie reszty plików
COPY . .

# Drugi etap

# Uzycie obrazu alpine
FROM alpine:latest

# Instalacja nodejs, curl oraz usunięcie pamięci podręcznej pakietów
RUN apk add --no-cache nodejs \
  apk add --no-cache curl \
  rm -rf /etc/apk/cache

# Ustawienie katalogu roboczego
WORKDIR /tch_zad1

# Skopiowanie plików z etapu pierwszego
COPY --from=etapPierwszy /tch_zad1 /tch_zad1

# Deklaracja portu aplikacji w kontenerze 
EXPOSE 8085

# Monitorowanie dostepnosci serwera 
HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost:8085/ || exit 1

# Uruchomienia serwera
CMD ["node", "server.js"]