
package com.Ejemplo.Musica.repository;


import com.Ejemplo.Musica.dominio.Musica;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface MusicaRepository extends JpaRepository <Musica, Integer> {
    
    @Query("select m from Musica m order by m.nombre")
    List<Musica> buscarTodos();
    
    
    //@Query("from Musica m where m.nombre like %?1%")
    List<Musica> findByNombreContaining(String consulta);
    
}
