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
    res.redirect('solicitud/${rut}');
});

router.get('/listap', async (req,res) => {
    const horas = await pool.query("SELECT profesional.nombre, profesional.num_sala, especialidad.especialidad, DATE_FORMAT(hora_medica.fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', hora_medica.disponibilidad FROM profesional INNER JOIN pro_espec ON profesional.rut_p = pro_espec.rut_p INNER JOIN especialidad ON pro_espec.id_especialidad = especialidad.id_especialidad INNER JOIN hora_medica ON hora_medica.rut_p = profesional.rut_p;");
    res.render('paciente/listap', {  horas });
});

router.get('/solicitud/:rut', (req,res) => {
    const { rut } = req.params;
    res.render('paciente/solicitud/${rut}');
});

router.get('/eliminar/:id',async (req,res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM hora_medica WHERE id_hora = ?", [id]);
    req.flash('success','Hora medica eliminada satisfactoriamente');
    res.redirect('../lista');
});

router.post('/solicitud/', async (req,res) => {
    const rut = await pool.query("SELECT rut from persona");
    const {motivo} = req.body;
    const nuevaSolicitud = {
        rut,
        motivo
    };  
    await pool.query("INSERT INTO solicita SET ? ",[nuevaSolicitud]);
    req.flash('success','Se ha enviado su solicitud, se le enviara un correo con la respuesta');
    res.redirect('paciente/listap');
});

module.exports = router;