INSERT INTO usuário VALUES('jovemAprendiz3', 'Astolfo Barros Barbosa','astolfobbarbosa2@gmail.com','2001-01-01',pg_read_binary_file('Duolingo/jovemaprendiz.jpg'),3069,14,2,30,'bronze',24,'$2y$12$seTm81r7VQCYgYxOox98Zeuy91tOVHTjP.3dxNXZIQqKSEIdgSjI2');
INSERT INTO usuário VALUES('joel_santana13', 'Joel Natalino Santana','joelnatalsantana@gmail.com','1948-12-25',pg_read_binary_file('Duolingo/joel.jpg'),20,5,0,0,'bronze',49,'$2y$12$y3SzdZ50Pa1.c80MiNoRYeSCegp01xLFRAQa./StKbgz8lQ/s.ovu');
INSERT INTO usuário VALUES('umaLinha', 'Aline Machado Osmar','alineosmarm@gmail.com','1998-04-10',pg_read_binary_file('Duolingo/a.jpg'),1000,50,5,100,'ouro',10,'$2y$12$SZKpt1jKuLXYZCDdbqGoGuwzIi/iZ6VICNQP8ek8e///siaj1ck7K');

INSERT INTO amizade VALUES(1,'umaLinha','joel_santana13','joel_santana13');
INSERT INTO amizade VALUES(2,'umaLinha','jovemAprendiz3',NULL);
INSERT INTO amizade VALUES(3,'joel_santana13','umaLinha','umaLinha');
INSERT INTO amizade VALUES(6,'joel_santana13','jovemAprendiz3','jovemAprendiz3');
INSERT INTO amizade VALUES(4,'jovemAprendiz3',NULL,'umaLinha');
INSERT INTO amizade VALUES(5,'jovemAprendiz3','joel_santana13','joel_santana13');

INSERT INTO idioma  VALUES(pg_read_binary_file('Duolingo/bandeira-alemanha.jpg'),'alemão');
INSERT INTO idioma  VALUES(pg_read_binary_file('Duolingo/bandeira-eua.jpg'),'inglês');
INSERT INTO idioma  VALUES(pg_read_binary_file('Duolingo/franca.jpg'),'francês');
INSERT INTO idioma  VALUES(pg_read_binary_file('Duolingo/japao.png'),'japonês');


INSERT INTO estudo VALUES(2,5,'inglês','joel_santana13');
INSERT INTO estudo VALUES(3,15,'alemão','joel_santana13');
INSERT INTO estudo VALUES(2,10,'francês','jovemAprendiz3');
INSERT INTO estudo VALUES(15,30,'inglês','umaLinha');
INSERT INTO estudo VALUES(2,5,'japonês','jovemAprendiz3');



INSERT INTO lição VALUES(2,2,'básico','francês');
INSERT INTO lição VALUES(10,3,'plurais','alemão');
INSERT INTO lição VALUES(19,2,'comidas 1','inglês');
INSERT INTO lição VALUES(12,3,'frases','alemão');
INSERT INTO lição VALUES(25,2,'estudos','japonês');

INSERT INTO pergunta VALUES(14,15,'Escolha a tradução correta:',2,'francês',3);
INSERT INTO pergunta VALUES(15,25,'Fale esta frase:',2,'francês',5);
INSERT INTO pergunta VALUES(18,10,'Toque no que escutar',2,'francês',2);
INSERT INTO pergunta VALUES(19,10,'Qual destas imagens é "a mulher"?',2,'francês',4);
INSERT INTO pergunta VALUES(49,10,'Escolha a tradução correta:',19,'inglês',3);
INSERT INTO pergunta VALUES(50,15,'Fale esta frase:',19,'inglês',4);
INSERT INTO pergunta VALUES(51,10,'Toque no que escutar',19,'inglês',5);
INSERT INTO pergunta VALUES(48,5,'Qual destas imagens é "A maçã"?',19,'inglês',2);
INSERT INTO pergunta VALUES(52,15,'Fale esta frase:',12,'alemão',1);
INSERT INTO pergunta VALUES(53,10,'Toque no que escutar',12,'alemão',2);
INSERT INTO pergunta VALUES(54,15,'Escolha a tradução correta:',10,'alemão',3);
INSERT INTO pergunta VALUES(55,10,'Qual destas imagens é "O menino"?',10,'alemão',4);

INSERT INTO pronunciação VALUES(pg_read_binary_file('Duolingo/No we do not eat meat.m4a'),'No we do not eat meat',50);
INSERT INTO pronunciação VALUES(pg_read_binary_file('Duolingo/le garcon.m4a'),'le garçon',15);
INSERT INTO pronunciação VALUES(pg_read_binary_file('Duolingo/Du bist willkommen!.m4a'),'Du bist willkommen!',52);

INSERT INTO tradução VALUES('Every single day we eat milk','Every single day we have apple','We eat rice every day','Nós comemos arroz todo dia',49,'We eat rice every day');
INSERT INTO tradução VALUES('les','la','le','a',14,'la');
INSERT INTO tradução VALUES('danke','ja','bitte','por favor',54,'bitte');

INSERT INTO associação_com_imagem VALUES(3,pg_read_binary_file('Duolingo/lasfemmes.jpg'),'las femmes',pg_read_binary_file('Duolingo/enfant.jpg'),'enfant',pg_read_binary_file('Duolingo/mere.jpg'),'mere',pg_read_binary_file('Duolingo/lafemme.jpg'),'la femme',19);
INSERT INTO associação_com_imagem VALUES(0,pg_read_binary_file('Duolingo/derjunge.jpg'),'Der junge',pg_read_binary_file('Duolingo/diejungen.jpg'),'Die jungen',pg_read_binary_file('Duolingo/diekinder.jpg'),'Die kinder',pg_read_binary_file('Duolingo/dasbaby.jpg'),'Das baby',55);
INSERT INTO associação_com_imagem VALUES(1,pg_read_binary_file('Duolingo/banana.jpg'),'The banana',pg_read_binary_file('Duolingo/apple.jpg'),'The apple',pg_read_binary_file('Duolingo/orange.png'),'The orange',pg_read_binary_file('Duolingo/grapefruit.jpg'),'The grapefruit',48);

INSERT INTO interpretação_de_áudio VALUES(pg_read_binary_file('Duolingo/she usually eats lunch here.m4a'),'she usually eats lunch here','she','eats','run','apple','usually','here','lunch',NULL,51);
INSERT INTO interpretação_de_áudio VALUES(pg_read_binary_file('Duolingo/le garcon.m4a'),'le garçon','le','femme','les','garçon','infante','femmes',NULL,NULL,18);
INSERT INTO interpretação_de_áudio VALUES(pg_read_binary_file('Duolingo/Du bist willkommen!.m4a'),'Du bist willkommen!','Du','bald','ja','bis','bist','willkommen!','junge',NULL,53);


INSERT INTO conquista VALUES('Capa de Revista','Você adicionou uma foto de perfil',1,5,pg_read_binary_file('Duolingo/capaderevista.jpg'),1); -- 1 para inseriu imagem, 0 não inseriu
INSERT INTO conquista VALUES('Sociável','Siga 3 amigos',1,10,pg_read_binary_file('Duolingo/sociavel.jpg'),3); 
INSERT INTO conquista VALUES('Majestade','Ganhe 80 coroas',9,35,pg_read_binary_file('Duolingo/majestade.jpg'),80);
INSERT INTO conquista VALUES('Intelectual','Aprenda 2000 palavras novas em um curso',10,40,pg_read_binary_file('Duolingo/intelectual.jpg'),2000); 
INSERT INTO conquista VALUES('Lenha na Fogueira','Complete uma ofensiva de 3 dias',1,5,pg_read_binary_file('Duolingo/fogueira.jpg'),3);


INSERT INTO desbloqueio VALUES(3000,'joel_santana13','Capa de Revista',1);
INSERT INTO desbloqueio VALUES(1,'joel_santana13','Sociável',1);
INSERT INTO desbloqueio VALUES(1700,'jovemAprendiz3','Intelectual',10);
INSERT INTO desbloqueio VALUES(80,'jovemAprendiz3','Majestade',9);
INSERT INTO desbloqueio VALUES(3000,'jovemAprendiz3','Capa de Revista',1);
INSERT INTO desbloqueio VALUES(1,'jovemAprendiz3','Sociável',1);

INSERT INTO itens_da_loja VALUES(5,'Tente dobrar a sua aposta de 5 lingotes ao manter 7 dias de ofensiva.','Dobro ou nada',pg_read_binary_file('Duolingo/dobro.jpg'),FALSE,NULL,NULL,NULL);
INSERT INTO itens_da_loja VALUES(30,'Aprenda com estilo.','Formal',NULL,TRUE,pg_read_binary_file('Duolingo/sapatof.png'),pg_read_binary_file('Duolingo/roupaf.png'),pg_read_binary_file('Duolingo/acessoriof.png'));
INSERT INTO itens_da_loja VALUES(50,'Seja o melhor aprendiz do Oeste','Cowboy',NULL,TRUE,NULL,NULL,pg_read_binary_file('Duolingo/acessorioc.jpg'));

INSERT INTO compra VALUES('joel_santana13','Formal',1);
INSERT INTO compra VALUES('joel_santana13','Cowboy',2);
INSERT INTO compra VALUES('jovemAprendiz3','Cowboy',3);
INSERT INTO compra VALUES('jovemAprendiz3','Formal',5);
INSERT INTO compra VALUES('umaLinha','Dobro ou nada',4);

