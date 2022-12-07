const { request, response, query } = require('express');
const express = require('express');
const router = express.Router();
const pool = require('../database');
const nodemailer = require('nodemailer');


router.get('/add', (req,res) => {
    res.render('admin/hora');
});

router.post('/add', async (req,res) => {
    const {fecha_hora, rut_p} = req.body;
    const nuevaHora = {
        fecha_hora,
        rut_p
    };  
    await pool.query('INSERT INTO hora_medica set ?', [nuevaHora]);
    req.flash('success','Hora medica creada satisfactoriamente');
    res.redirect('lista');
});

router.get('/lista', async (req,res) => {
    const horas = await pool.query("SELECT id_hora , disponibilidad , DATE_FORMAT(fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', nombre FROM hora_medica INNER JOIN profesional ON hora_medica.rut_p = profesional.rut_p");
    res.render('admin/lista', { horas });
});

router.get('/solicitudes', async (req,res) => {
    const solicitaciones = await pool.query("SELECT solicita.id_solicita,solicita.rut,solicita.id_hora, persona.nombres,persona.apellidos,persona.correo_electronico,persona.telefono_personal,persona.telefono_contacto,persona.direccion,solicita.motivo, profesional.nombre as nombre_profesional, DATE_FORMAT(hora_medica.fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario' FROM solicita INNER JOIN persona ON solicita.rut = persona.rut INNER JOIN hora_medica ON solicita.id_hora = hora_medica.id_hora INNER JOIN profesional ON hora_medica.rut_p = profesional.rut_p");
    res.render('admin/solicitudes', { solicitaciones });
});


router.get('/eliminar/:id',async (req,res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM hora_medica WHERE id_hora = ?", [id]);
    req.flash('success','Hora medica eliminada satisfactoriamente');
    res.redirect('../lista');
});

router.get('/editar/:id', async (req,res) => {
    const { id } = req.params;
    const datos = await pool.query("SELECT id_hora, DATE_FORMAT(fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', rut_p FROM hora_medica WHERE id_hora = ?",[id]);
    res.render('admin/editar', {dato: datos[0]});
});

router.post('/editar/:id', async (req,res) => {
    const { id } = req.params;
    const { fecha_hora, rut_p } = req.body;
    const nuevaHora = {
        fecha_hora,
        rut_p
    };
    const datos = await pool.query("UPDATE hora_medica SET ? WHERE id_hora = ?",[nuevaHora,id]);
    req.flash('success', 'Hora medica modificada satisfactoriamente');
    res.redirect('../lista');
});

router.get('/solicitudes/sol_aprobada/:ids', async (req,res) => {
    const {ids} = req.params;
    console.log(ids);
    await pool.query("UPDATE hora_medica SET disponibilidad = 'Reservado' WHERE id_hora = (SELECT id_hora FROM solicita WHERE id_solicita= ?)",ids);
    req.flash('success', 'Correo de Confirmacion Enviado al Paciente');
    const correo_electronico = await pool.query("SELECT persona.correo_electronico as '' FROM solicita INNER JOIN persona ON solicita.rut = persona.rut WHERE solicita.id_solicita= ?;",ids);
    const correotupla = Object.values(JSON.parse(JSON.stringify(correo_electronico)));
    const aux = JSON.stringify(correotupla);
    const aux2= aux.replace('[{"":"', '');
    const correo = aux2.replace('"}]', '');
    const prueba = 'pruebalecofq@gmail.com';
    console.log(correo);
    await pool.query("DELETE FROM solicita WHERE id_solicita = ?", [ids]);
    try {
        await transporter.sendMail({
        from: 'pruebalecofq@gmail.com', // sender address
        to: correo, // list of receivers
        subject: "Solicitud de Hora medica Lecofq.", // Subject line
        html: "<b>Su hora Lecofq a sido confirmada</b>", // html body
    });
    }catch (error){
    emailStatus=error;
    return res.status(400).json({ message: 'Algo Salio Mal con el Correo'});
    }
    res.redirect('../../solicitudes'); 
});

router.get('/solicitudes/sol_rechazada/:ids', async (req,res) => {
    const {ids} = req.params;
    req.flash('success', 'Correo de Rechaso Enviado al Paciente');
    const correo_electronico = await pool.query("SELECT persona.correo_electronico as '' FROM solicita INNER JOIN persona ON solicita.rut = persona.rut WHERE solicita.id_solicita= ?;",ids);
    const correotupla = Object.values(JSON.parse(JSON.stringify(correo_electronico)));
    const aux = JSON.stringify(correotupla);
    const aux2= aux.replace('[{"":"', '');
    const correo = aux2.replace('"}]', '');
    console.log(correo);
    const prueba = 'pruebalecofq@gmail.com';
    await pool.query("DELETE FROM solicita WHERE id_solicita = ?", [ids]);

    try {
        await transporter.sendMail({
        from: 'pruebalecofq@gmail.com', // sender address
        to: correo, // list of receivers
        subject: "Solicitud de Hora medica Lecofq.", // Subject line
        html: "<b>Su hora Lecofq a sido Rechazada porfavor vuelva a solicitar una Hora</b>", // html body
    });
    }catch (error){
    emailStatus=error;
    return res.status(400).json({ message: 'Algo Salio Mal con el Correo'});
    }
    res.redirect('../../solicitudes'); 
});

let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
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

module.exports = router;

