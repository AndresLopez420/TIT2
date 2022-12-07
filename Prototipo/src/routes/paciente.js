const { request, response, query } = require('express');
const express = require('express');
const router = express.Router();

const pool = require('../database');

router.get('/formulariop/:id_h', async (req,res) => {
    const valor = [
        {id: req.params.id_h}
    ]
    res.render('paciente/formulariop',{valor});
});

router.post('/formulariop/:id', async (req,res) => {
    const {rut, nombres, apellidos, telefono_personal, telefono_contacto, sexo, talla, fecha_nacimiento, correo_electronico, direccion} = req.body;
    const nuevoPaciente = {
        rut, 
        nombres, 
        apellidos, 
        telefono_personal, 
        telefono_contacto, 
        sexo, 
        talla, 
        fecha_nacimiento, 
        correo_electronico, 
        direccion
    };
    const id = req.params.id;
    await pool.query('INSERT INTO persona set ?', [nuevoPaciente]);
    req.flash('success','Paciente ingresado satisfactoriamente');
    //res.redirect('../../paciente/solicitud/:id');
    res.render('paciente/solicitud',{nuevoPaciente,id});
});

router.get('/listap', async (req,res) => {
    const horas = await pool.query("SELECT hora_medica.id_hora, profesional.nombre, profesional.num_sala, especialidad.especialidad, DATE_FORMAT(hora_medica.fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', hora_medica.disponibilidad FROM profesional INNER JOIN pro_espec ON profesional.rut_p = pro_espec.rut_p INNER JOIN especialidad ON pro_espec.id_especialidad = especialidad.id_especialidad INNER JOIN hora_medica ON hora_medica.rut_p = profesional.rut_p;");
    res.render('paciente/listap', {  horas });
});

router.post('/solicitud/:rut', async (req,res) => {
    const {motivo,id_hora} = req.body;
    let rut = req.params.rut;
    const nuevaSolicitud = {
        motivo,
        id_hora,
        rut
    };
    await pool.query("INSERT INTO solicita SET ? ", [nuevaSolicitud]);
    req.flash('success','Se ha enviado su solicitud, se le enviara un correo con la respuesta');
    res.redirect('/paciente/listap');
});

module.exports = router;