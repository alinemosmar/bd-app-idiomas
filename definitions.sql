-- Criação das tabelas
 
CREATE TYPE DIVISÃO AS ENUM ('diamante', 'platina', 'ouro', 'prata', 'bronze');
 
CREATE TABLE usuário 
( 
 Username           VARCHAR(20)     PRIMARY KEY,  
 Nome               VARCHAR(70)     NOT NULL, 
 Email              VARCHAR(254)    NOT NULL UNIQUE,    --seguindo a errata de RFC3696
 Nasc               DATE            NOT NULL, 
 Avatar             BYTEA,                                    
 ExpTotal           INTEGER         NOT NULL    DEFAULT 0   CHECK (ExpTotal >= 0),          
 QtdLingotes        INTEGER         NOT NULL    DEFAULT 0   CHECK (QtdLingotes >= 0), 
 QtdOfensiva        INTEGER         NOT NULL    DEFAULT 0   CHECK (QtdOfensiva >= 0),  
 RankingExpMês      INTEGER                     DEFAULT 0   CHECK (RankingExpMês >= 0),  
 RankingDivisão     DIVISÃO                     DEFAULT     'bronze',  
 RankingPosição     INTEGER                                 CHECK (RankingPosição > 0),
 Senha              CHAR(60)        NOT NULL           --tamanho de hash bcrypt    
); 
 
CREATE TABLE idioma 
( 
 Bandeira           BYTEA            NOT NULL,  
 Idioma_Nome        VARCHAR(20)      PRIMARY KEY  
); 
 
CREATE TABLE lição 
( 
 Lição_Sequência       SMALLINT        NOT NULL    CHECK (Lição_Sequência  >= 0),  
 Idioma_Nível          SMALLINT        NOT NULL    CHECK (Idioma_Nível  >= 0),  
 Categoria             VARCHAR(30)     NOT NULL,  
 Idioma_Nome           VARCHAR(20)     NOT NULL,
 
 PRIMARY KEY (Lição_Sequência,Idioma_Nome),
 
 FOREIGN KEY (Idioma_Nome) REFERENCES Idioma(Idioma_Nome) ON UPDATE CASCADE ON DELETE CASCADE
); 
 
CREATE TABLE pergunta 
( 
 Id_Pergunta        SERIAL          PRIMARY KEY,  
 QtdExp             SMALLINT        NOT NULL    CHECK (QtdExp > 0),  
 Título             VARCHAR(200)    NOT NULL,  
 Lição_Sequência    SMALLINT        NOT NULL,
 Idioma_Nome        VARCHAR(20)     NOT NULL,
 Pergunta_Sequência SMALLINT        NOT NULL,
 
 UNIQUE (Pergunta_Sequência, Lição_Sequência, Idioma_Nome),
 
 FOREIGN KEY (Lição_Sequência, Idioma_Nome) REFERENCES Lição(Lição_Sequência, Idioma_Nome) ON UPDATE CASCADE ON DELETE CASCADE
); 


CREATE TABLE pronunciação 
(            
 Áudio           BYTEA               NOT NULL,          
 Texto           VARCHAR(150)        NOT NULL,  
 Id_Pergunta     INTEGER             PRIMARY KEY,
 
 FOREIGN KEY (Id_Pergunta ) REFERENCES Pergunta(Id_Pergunta) ON DELETE CASCADE
); 
 
CREATE TABLE associação_com_imagem 
( 
 OpCerta        SMALLINT            NOT NULL CHECK (OpCerta >= 0 AND OpCerta <= 3),  
 Img0           BYTEA               NOT NULL,           
 Txt0           VARCHAR(50)         NOT NULL,  
 Img1           BYTEA               NOT NULL,          
 Txt1           VARCHAR(50)         NOT NULL,  
 Img2           BYTEA               NOT NULL,           
 Txt2           VARCHAR(50)         NOT NULL,  
 Img3           BYTEA               NOT NULL, 
 Txt3           VARCHAR(50)         NOT NULL,  
 Id_Pergunta    INTEGER             PRIMARY KEY, 
 
 FOREIGN KEY (Id_Pergunta) REFERENCES Pergunta(Id_Pergunta) ON DELETE CASCADE
); 
 
CREATE TABLE interpretação_de_áudio 
( 
 Áudio          BYTEA               NOT NULL,  
 StrCerta       VARCHAR(150)        NOT NULL,  
 Blocos0        VARCHAR(30)         NOT NULL,  
 Blocos1        VARCHAR(30)         NOT NULL,  
 Blocos2        VARCHAR(30)         NOT NULL,  
 Blocos3        VARCHAR(30)         NOT NULL,           --mínimo de 4 blocos, máximo de 8 blocos
 Blocos4        VARCHAR(30),  
 Blocos5        VARCHAR(30),  
 Blocos6        VARCHAR(30),  
 Blocos7        VARCHAR(30),
 Id_Pergunta    INTEGER             PRIMARY KEY, 
 
 FOREIGN KEY (Id_Pergunta) REFERENCES Pergunta(Id_Pergunta) ON DELETE CASCADE
); 
 
CREATE TABLE tradução 
( 
 Opção3       VARCHAR(100)        NOT NULL,  
 Opção2       VARCHAR(100)        NOT NULL,  
 Opção1       VARCHAR(100)        NOT NULL,  
 Texto        VARCHAR(200)        NOT NULL,  
 Id_Pergunta  INTEGER             PRIMARY KEY,
 OpCerta      VARCHAR(100)        NOT NULL, 
 
 FOREIGN KEY (Id_Pergunta) REFERENCES Pergunta(Id_Pergunta) ON DELETE CASCADE
); 
 
CREATE TABLE conquista 
( 
 Título_Conquista	VARCHAR(50)         NOT NULL,  
 Descrição          VARCHAR(150)        NOT NULL,  
 Conquista_Nível    SMALLINT            NOT NULL,  
 QtdLingotes        INTEGER             NOT NULL,  
 Imagem             BYTEA               NOT NULL,  
 Objetivo           INTEGER             NOT NULL,
 
 PRIMARY KEY (Título_Conquista, Conquista_Nível)
); 
 
CREATE TABLE itens_da_Loja 
( 
 Preço             INTEGER          NOT NULL,  
 Descrição         VARCHAR(200)     NOT NULL,  
 NomeDoItem        VARCHAR(50)      PRIMARY KEY,  
 Imagem            BYTEA,  
 
 traje             BOOLEAN          NOT NULL  DEFAULT FALSE,
 ImgSapato         BYTEA,           --Se for traje, tem as imagens   
 ImgRoupa          BYTEA,           --Se for traje, tem as imagens
 ImgAcessório      BYTEA            --Se for traje, tem as imagens
); 
 
CREATE TABLE estudo 
( 
 Nível          SMALLINT            NOT NULL  DEFAULT 0,  
 QtdCoroas      SMALLINT            NOT NULL  DEFAULT 0,  
 Idioma_Nome    VARCHAR(20)         NOT NULL,  
 Username       VARCHAR(20)         NOT NULL,
 
 PRIMARY KEY (Idioma_Nome,Username),	
 FOREIGN KEY (Username)  REFERENCES Usuário(Username) ON DELETE CASCADE,
 FOREIGN KEY (Idioma_Nome) REFERENCES Idioma(Idioma_Nome) ON DELETE CASCADE
	
); 
 


CREATE TABLE amizade 
( 
 id_relacionamento INTEGER             NOT NULL,       
 Username          VARCHAR(20)         NOT NULL,
 UserSeguindo      VARCHAR(20)          ,   
 UserEhSeguido     VARCHAR(20)         ,
 
 PRIMARY KEY (id_relacionamento),
 FOREIGN KEY (Username)  REFERENCES Usuário(Username) ON DELETE CASCADE,
 FOREIGN KEY (UserSeguindo)  REFERENCES Usuário(Username),
 FOREIGN KEY (UserEhSeguido) REFERENCES Usuário(Username)
); 
 
CREATE TABLE desbloqueio 
( 
 Progresso          SMALLINT        NOT NULL,  
 Usuario_User       VARCHAR(20)     NOT NULL,  
 Título_Conquista   VARCHAR(50)     NOT NULL, 
 Conquista_Nível    SMALLINT        NOT NULL,
 
 PRIMARY KEY (Usuario_User,  Título_Conquista, Conquista_Nível),
 FOREIGN KEY (Usuario_User) REFERENCES Usuário(Username) ON DELETE CASCADE,
 FOREIGN KEY (Título_Conquista, Conquista_Nível) REFERENCES Conquista(Título_Conquista, Conquista_Nível) ON DELETE CASCADE
); 
 
CREATE TABLE compra 
( 
 Username     VARCHAR(20)     NOT NULL,  
 NomeDoItem   VARCHAR(50)     NOT NULL,  
 id           SERIAL          PRIMARY KEY,
 
 FOREIGN KEY (Username)   REFERENCES Usuário(Username) ON DELETE CASCADE,
 FOREIGN KEY (NomeDoItem) REFERENCES Itens_da_Loja(NomeDoItem)  ON DELETE CASCADE
	
);

Create view LiçõesDoUsuário
as select lição.idioma_nome,lição.idioma_nível,lição.lição_sequência,estudo.username,pergunta.id_pergunta,pergunta.qtdexp,pergunta.título from estudo join lição using (idioma_nome) join pergunta using (lição_sequência)
where lição.idioma_nível=estudo.nível;




















