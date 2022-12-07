const express = require('express');
const router = express.Router();
const passport = require('passport');
const pool = require('../database');

router.get('/signup', (req, res) => {
    res.render('auth/signup');
  });

router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/signin',
    failureRedirect: '/signup',
    failureFlash: true
  }));

router.get('/signin', (req,res) => {
    res.render('auth/signin');
});

router.post('/signin', (req, res, next) => {
  passport.authenticate('local.signin',{
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req, res, next);
});


router.get('/profile', async (req,res)=> {
  const horasMedicas = await pool.query("SELECT DATE_FORMAT(fecha_hora, '%Y-%m-%d %H:%i:%s.') as horario, p.rut_p, disponibilidad, num_sala FROM hora_medica as h JOIN profesional as p ON p.rut_p=h.rut_p WHERE p.rut_p = ? ",[req.user.rut]);
  res.render('profile',{horasMedicas})
});

router.get('/logout', (req, res) => {
  req.logOut();
  res.redirect('../');
});

module.exports = router;