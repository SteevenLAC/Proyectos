DROP TABLE IF EXISTS musica

CREATE TABLE musica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    autor VARCHAR(200),
    descripcion VARCHAR(3000),
    imagen_Url VARCHAR(1000),
    video VARCHAR(1000)
);

INSERT INTO musica ( nombre, autor, descripcion, imagenUrl, videoUrl)
VALUES
('Sufrir es crecer ', 'SHÉ ', 'Álbum musical: Tiempo Vol.2 ', 'https://i.ytimg.com/vi/ScFdey6Z5ic/hqdefault.jpg ', 'https://www.youtube.com/watch?v=f_kYAgd0x5o '),
('De vuelta a casa ', 'Brock Ansiolitiko ', ' Álbum musical: Ver-S.O.S', 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/90/5e/ca/905eca41-3992-62cd-2427-f379dfac5357/8433391604762.jpg/1200x1200bb.jpg ', 'https://www.youtube.com/watch?v=TIeWFKhox5Q '),
('Aprendí ', 'Dante ', 'Álbum musical: Ápeiron ', 'https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/17/3c/c7/173cc7b6-afd0-9170-fe74-3a44e9823a9f/8429006293407_Cover.jpg/1200x1200bf-60.jpg ', ' https://www.youtube.com/watch?v=_klegOHjhww'),
('Venid por mí (Remake Magnos 2023) ', ' Santaflow', 'Rap en español, sonido hip hop con fusiones rock y metal. Beef, canciones hardcore. ', 'https://i.ytimg.com/vi/2GBsLiw7jYY/maxresdefault.jpg ', 'https://www.youtube.com/watch?v=2GBsLiw7jYY ');

('Mr. Delincuente ', ' Norykko', 'Hip-hop/rap, lanzado en 2016 ', 'https://i.ytimg.com/vi/y6pgyNmXtQw/maxresdefault.jpg ', 'https://www.youtube.com/watch?v=y6pgyNmXtQw&list=RD2GBsLiw7jYY&index=4');
('Mucho Para Mí ', ' Santa RM Ft. Franco Escamilla', 'Hip-hop/rap, lanzado en 2021 ', 'https://i.ytimg.com/vi/ymJ1svwvpLQ/maxresdefault.jpg', 'https://www.youtube.com/watch?v=ymJ1svwvpLQ&list=RD2GBsLiw7jYY&index=23 ');
('Street fighter ', ' Santaflow', 'Álbum: Ave Fénix. Hip-hop/rap, lanzado en 2021 ', 'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/1a/17/8d/1a178d9a-ea96-0f9c-d460-3fd0237b9e96/195497207596.jpg/600x600bf-60.jpg', 'https://www.youtube.com/watch?v=l_JqYPrUx6g');
