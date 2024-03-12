
package com.Ejemplo.Musica.controller;

import com.Ejemplo.Musica.dominio.Musica;
import com.Ejemplo.service.MusicaService;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ListadoController {
    
    private final MusicaService musicaservice;
    
    public ListadoController(MusicaService musicaservice) {
        this.musicaservice = musicaservice;
    }
    
    @RequestMapping("/")
    public String listarMusica(Model model){
        List<Musica> destacados = musicaservice.buscarDestacados();
        model.addAttribute("musicas",destacados);
     
        //Búsqueda de musica
        return "listado";
    }
    
    @RequestMapping("/Buscar")
    public String buscar(String consulta, Model model){
        List<Musica> music = musicaservice.buscar(consulta);
        model.addAttribute("musicas", music);
        
        return "listado";
    
    }
    
}
