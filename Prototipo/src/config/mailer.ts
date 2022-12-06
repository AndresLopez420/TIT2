const nodemailer = require("nodemailer");

export const transporter = nodemailer.createTransport({
    host: "smtp.gmail.email",
    port: 465,
    secure: true, // true for 465, false for other ports
    auth: {
      user: 'pruebalecofq@gmail.com', // generated ethereal user
      pass: 'osknjilrgajfjlrn', // generated ethereal password
    },
  });
  
  transporter.verify().then( ()=> {
    console.log('Listo para envio de Correos');
  });