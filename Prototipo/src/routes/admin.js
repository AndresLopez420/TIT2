const { request, response, query } = require('express');
const express = require('express');
const router = express.Router();

const pool = require('../database');


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
    const solicitaciones = await pool.query("SELECT solicita.rut, persona.nombres,persona.apellidos,persona.correo_electronico,persona.telefono_personal,persona.telefono_contacto,persona.direccion,solicita.motivo, profesional.nombre as nombre_profesional, DATE_FORMAT(hora_medica.fecha_hora, '%Y-%m-%d %H:%i:%s.') as 'horario' FROM solicita INNER JOIN persona ON solicita.rut = persona.rut INNER JOIN hora_medica ON solicita.id_hora = hora_medica.id_hora INNER JOIN profesional ON hora_medica.rut_p = profesional.rut_p");
    res.render('admin/solicitudes', { solicitaciones });
});


router.get('/eliminar/:id',async (req,res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM hora_medica WHERE id_hora = ?", [id]);
    req.flash('success','Hora medica eliminada satisfactoriamente');
    res.redirect('../lista');
});

router.get('/eliminar_solicitud/:id',async (req,res) => {
    const { id_solicita } = req.params;
    await pool.query("DELETE FROM solicita WHERE id_solicita = ?", [id_solicita]);
    req.flash('success','Solicitud eliminada satisfactoriamente');
    res.redirect('../solicitudes');
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

module.exports = router;