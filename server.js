const express = require('express');

const app = express();
const PORT = 8085; // ustawienie portu

// dane autora
const author = 'Mateusz Nowak'; 

var now = new Date();
const startupTime = now.toLocaleString();



app.use((req, res, next) => {
  const ip = req.ip; // pobranie adresu IP klienta
  now = new Date(); // pobranie aktualnej daty i godziny
  const clientTime = now.toLocaleString(); // obliczenie daty i godziny w strefie czasowej klienta

  // wyświetlenie informacji o adresie IP klienta i godzinie w jego strefie czasowej
  res.send(`Adres IP klienta: ${ip}<br>Data i godzina w Twojej strefie czasowej: ${clientTime}`);
});

app.listen(PORT, () => {
    console.log(`Serwer został uruchomiony przez ${author} dnia ${startupTime} na porcie ${PORT}`);
});
