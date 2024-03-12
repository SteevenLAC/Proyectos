
package com.Ejemplo.service;

import com.Ejemplo.Musica.dominio.Musica;
import com.Ejemplo.Musica.repository.MusicaRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class MusicaService {
    
    private final MusicaRepository musicaRepository;
    
    public MusicaService(MusicaRepository musicaRepository) {
        this.musicaRepository = musicaRepository;
    }
    
    public List<Musica> buscarDestacados(){
     
        
        return musicaRepository.buscarTodos();
    
    }
    
    
    public List<Musica> buscar (String consulta){
        return musicaRepository.findByNombreContaining(consulta);
    
    }
    
    public Musica guardar(Musica musica){
        return musicaRepository.save(musica);
    
    }

    
}
