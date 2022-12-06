const { request, response, query } = require('express');
const express = require('express');
const router = express.Router();

const pool = require('../database');

router.get('/formulariop', async (req,res) => {
    res.render('paciente/formulariop');
});

router.post('/formulariop', async (req,res) => {
    const {rut, nombres, apellidos, telefono_personal, telefono_contacto, sexo, talla, fecha_nacimiento, correo_electronico, direccion} = req.body;
    const nuevaPaciente = {
        rut, 
        nombres, 
        apellidos, 
        telefono_personal, 
        telefono_contacto, 
        sexo, talla, 
        fecha_nacimiento, 
        correo_electronico, 
        direccion
    };  
    await pool.query('INSERT INTO persona set ?', [nuevaPaciente]);
    req.flash('success','Paciente ingresado satisfactoriamente');
    res.redirect('solicitud');
});

router.get('/listap', async (req,res) => {
    const horas = await pool.query("SELECT profesional.nombre, profesional.num_sala, especialidad.especialidad, DATE_FORMAT(hora_medica.fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', hora_medica.disponibilidad FROM profesional INNER JOIN pro_espec ON profesional.rut_p = pro_espec.rut_p INNER JOIN especialidad ON pro_espec.id_especialidad = especialidad.id_especialidad INNER JOIN hora_medica ON hora_medica.rut_p = profesional.rut_p;");
    res.render('paciente/listap', {  horas });
});

router.get('/solicitud', (req,res) => {
    res.render('paciente/solicitud');
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

router.post('/solicitud/:rut', async (req,res) => {
    const { rut } = req.params;
    const nuevaSolicitud = {
        motivo,
        rut
    };  
    const datos = await pool.query("UPDATE hora_medica SET ? WHERE id_hora = ?",[nuevaSolicitud,rut]);
    req.flash('success','Se ha enviado su solicitud, se le enviara un correo con la respuesta');
    res.redirect('../home');
});

module.exports = router;