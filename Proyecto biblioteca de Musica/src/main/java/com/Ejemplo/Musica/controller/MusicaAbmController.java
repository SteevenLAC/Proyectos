
package com.Ejemplo.Musica.controller;

import com.Ejemplo.Musica.dominio.Musica;
import com.Ejemplo.service.MusicaService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MusicaAbmController {
    
    private final MusicaService musicaService ;
    
    public MusicaAbmController(com.Ejemplo.service.MusicaService musicaservice) {
        this.musicaService = musicaservice;
    }
    
   
    
    @PostMapping("/musica/guardar")
    public String guardar(Musica musica){
        
        musicaService.guardar(musica);
        
        return"redirect:/";
    }
    
}
