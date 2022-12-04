const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/formulariop', async (req,res) => {
    res.render('paciente/formulariop');
});

router.post('/add', async (req,res) => {
    const {rut, nombres, apellidos, telefono_personal, telefono_contacto, sexo, talla, fecha_nacimiento, correo_electronico, direccion} = req.body;
    const nuevaSolicitud = {
        rut, nombres, apellidos, telefono_personal, telefono_contacto, sexo, talla, fecha_nacimiento, correo_electronico, direccion
    };  
    await pool.query('INSERT INTO persona set ?', [nuevaSolicitud]);
    res.redirect('solicitud');
});

router.get('/listap', async (req,res) => {
    const horas = await pool.query("SELECT id_hora , disponibilidad , DATE_FORMAT(fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', nombre FROM hora_medica INNER JOIN profesional ON hora_medica.rut_p = profesional.rut_p");
    res.render('paciente/listap', { horas });
});

router.get('/solicitud', (req,res) => {
    res.render('paciente/solicitud');
});




module.exports = router;