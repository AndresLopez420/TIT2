const express = require('express');
const router = express.Router();
const pool = require('../database');

router.get('/algo', async (req,res) => {
    res.render('paciente/algo');
});

router.get('/listap', async (req,res) => {
    const horas = await pool.query("SELECT id_hora , disponibilidad , DATE_FORMAT(fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario', nombre FROM hora_medica INNER JOIN profesional ON hora_medica.rut_p = profesional.rut_p");
    res.render('paciente/listap', { horas });
});

router.get('/solicitar', (req,res) => {
    res.render('paciente/solicitar');
});

module.exports = router;