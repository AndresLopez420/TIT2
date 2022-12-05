const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/formulariop', async (req,res) => {
    res.render('paciente/formulariop');
});

router.post('/formualariop', async (req,res) => {
    const {rut, nombres, apellidos, telefono_personal, telefono_contacto, sexo, talla, fecha_nacimiento, correo_electronico, direccion} = req.body;
    const nuevaSolicitud = {
        rut, nombres, apellidos, telefono_personal, telefono_contacto, sexo, talla, fecha_nacimiento, correo_electronico, direccion
    };  
    await pool.query('INSERT INTO persona set ?', [nuevaSolicitud]);
    res.redirect('solicitud');
});

router.get('/listap', async (req,res) => {
    const horas = await pool.query("SELECT profesional.nombre, profesional.num_sala, especialidad.especialidad, hora_medica.fecha_hora, hora_medica.disponibilidad FROM profesional INNER JOIN pro_espec ON profesional.rut_p = pro_espec.rut_p INNER JOIN especialidad ON pro_espec.id_especialidad = especialidad.id_especialidad INNER JOIN hora_medica ON hora_medica.rut_p = profesional.rut_p;");
    res.render('paciente/listap', {  horas });
});

router.get('/solicitud', (req,res) => {
    res.render('paciente/solicitud');
});




module.exports = router;