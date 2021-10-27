#!/usr/bin/env python3

"""
Aline Osmar  | 00287711 
André Carini | 00260843


EREINF01145 B - Fundamentos de Banco de Dados (Renata Galante)

Trabalho Final - Parte 2
    Implementação em Python das consultas ao banco de dados.

    Aplicativo de aprendizagem de idiomas Duolingo.


Dependências:
    -> Python 3
    -> xterm
    -> imagemagick
    -> lsix (bash script, incluso no diretório, em ./lsix)
        -> Permissões de execução são necessárias (chmod +x ./lsix)
    -> psycopg2 (pip3 install psycopg2-binary)
        É o driver de acesso ao PostgreSQL para Python.
    -> prettytable (pip3 install prettytable)
        Auxiliar para formatação de output do terminal em tabelas.
    -> PostgreSQL 13
        -> Database  'duolingo'
        -> Usuário   'duolingo'
        -> Senha     'duolingo'
        -> Endereço  'localhost'
        -> Porta     '5432'
        -> Permissão SUPERUSER (para pg_read_binary_file)
        -> Arquivos de inserção (imagens e áudio) no ./imagens_e_audios/ devem ser
           copiados para a pasta $PGDATA/Duolingo. Para identificar qual é a pasta
           $PGDATA, rode o comando 'SHOW data_directory' pelo psql usando um user
           com permissão SUPERUSER.


Como utilizar:
    Primeiro, carregue no PostgreSQL o arquivo definitions.sql
    e então o arquivo insertions.sql.
    No terminal, execute:
        xterm -ti vt340 -fa 'Monospace' -fs 14
    E então, navegue até a pasta com o código e execute:
        python3 codigo.py

"""

import subprocess
import psycopg2
from prettytable import PrettyTable, from_db_cursor

print("\n\n\nConectando ao banco de dados...")

con = psycopg2.connect(database="duolingo", user="duolingo", password="duolingo", host="127.0.0.1", port="5432")

cur = con.cursor()

print("... conectado!")

print("\n\n\n\n\n\nAline Osmar  | 00287711")
print("André Carini | 00260843 \n\n\n")

print("CONSULTA 1")
print("Quantidade de lingotes gastos, por usuário, da divisão bronze: \n")
input("")

cur.execute("""
    SELECT username, SUM(preço) AS lingotes
    FROM usuário NATURAL JOIN compra NATURAL JOIN itens_da_loja
    WHERE rankingdivisão='bronze'
    GROUP BY username;
""")
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 2")
print("Username, experiência total e quantidade de conquistas, de usuários matriculados em mais de um idioma: \n")
input("")

cur.execute("""
    SELECT username, exptotal, COUNT(conquista.título_conquista) AS nrodeconquistas
    FROM usuário 
        NATURAL JOIN estudo
        INNER JOIN desbloqueio ON desbloqueio.usuario_user = estudo.username
        INNER JOIN conquista ON conquista.objetivo = desbloqueio.progresso
    GROUP BY username
    HAVING COUNT(idioma_nome)> 1;
""")
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 3")
print("Username, ranking, experiência, maior nível de idioma, de amigos do usuário de username 'umaLinha' [PARÂMETRO] \n")
input("")

cur.execute("""
    SELECT usuário.username, exptotal, 
        rankingdivisão, rankingposição,
        MAX(nível) AS maior_nível_de_idioma 
    FROM estudo NATURAL JOIN usuário
    WHERE usuário.username IN
        (SELECT DISTINCT username
        FROM amizade
        WHERE username IN
            (SELECT userseguindo AS username
            FROM amizade
            WHERE username=%(username)s
                
            UNION 
               
            SELECT userehseguido AS username
            FROM amizade
            WHERE username=%(username)s))
    GROUP BY usuário.username;
""",
{
    'username': (input("Username selecionado: "))
})
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 4")
print("Divisão (do ranking) e username dos usuários que desbloquearam todas as conquistas que o username 'umaLinha' [PARÂMETRO] tem: ")
input("")

cur.execute("""
    SELECT DISTINCT username, rankingdivisão
    FROM usuário U
    WHERE username <> %(username)s 
    AND NOT EXISTS
        (SELECT *
        FROM desbloqueio
        INNER JOIN conquista ON conquista.objetivo = desbloqueio.progresso
        WHERE usuario_user=%(username)s
        AND conquista.título_conquista NOT IN
            (SELECT conquista.título_conquista
            FROM desbloqueio
            INNER JOIN conquista ON conquista.objetivo = desbloqueio.progresso
            WHERE usuario_user=U.username));
""",
{
    'username': (input("Username selecionado: "))
})
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 5")
print("Enunciados e respostas corretas das perguntas de tradução, da lição de francês que o username 'jovemAprendiz3' [PARÂMETRO] tem disponível para fazer:")
input("")

cur.execute("""
    SELECT título, texto, opcerta
    FROM LiçõesdoUsuário NATURAL JOIN tradução
    WHERE username=%(username)s AND idioma_nome='francês';
""",
{
    'username': (input("Username selecionado: "))
})
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 6")
print("Trajes do Duo comprados pelo username 'jovemAprendiz3' [PARÂMETRO], avatar, preço, nome e descrição do item:")
input("")

cur.execute("""
    SELECT username, avatar, nomedoitem, preço, descrição
    FROM usuário NATURAL JOIN compra NATURAL JOIN itens_da_loja
    WHERE username=%(username)s AND traje;
""",
{
    'username': (input("Username selecionado: "))
})

rows = cur.fetchall()

for row in rows:
    print("Username: " + row[0])
    print("Nome do item: " + row[2])
    print("Preço: " + str(row[3]))
    print("Descrição: " + row[4])
    file = open("tmp/avatar", "wb")
    file.write(row[1])
    file.close()
    subprocess.check_call(['./lsix', 'tmp/avatar'])



input("")
print("\n\n\n\n\n\nCONSULTA 7")
print("Quantidade de xp total recebida por formato de pergunta do idioma inglês no nível 2")
input("")

cur.execute("""
    SELECT 'tradução' tipo_de_pergunta,sum(qtdexp)
    FROM lição join pergunta using (lição_sequência) natural join tradução
    WHERE lição.idioma_nome='inglês' and idioma_nível = 2

    UNION

    select 'pronunciação' tipo_de_pergunta,sum(qtdexp)
    from lição join pergunta using (lição_sequência) natural join pronunciação
    where lição.idioma_nome='inglês' and idioma_nível = 2

    union

    select 'interpretação de áudio' tipo_de_pergunta,sum(qtdexp)
    from lição join pergunta using (lição_sequência) natural join interpretação_de_áudio
    where lição.idioma_nome='inglês' and idioma_nível = 2

    union

    select 'associação com imagens' tipo_de_pergunta,sum(qtdexp)
    from lição join pergunta using (lição_sequência) natural join associação_com_imagem
    where lição.idioma_nome='inglês' and idioma_nível = 2;
""")
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 8")
print("Quantidade de xp, por idioma, que o usuário 'joel_santana13' ganha ao completar todas as lições do nível em que se encontra no idioma:")
input("")

cur.execute("""
    select estudo.idioma_nome,sum(qtdexp) exp
    from estudo join lição using (idioma_nome) join pergunta using (lição_sequência)
    where lição.idioma_nível=estudo.nível and estudo.username='joel_santana13'
    group by estudo.idioma_nome;
""")
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 9")
print("Para cada usuário(nome), mostrar a sua quantidade de amigos e quantidade de idiomas que ele estuda:")
input("")

cur.execute("""
    select
        nome,
        count(distinct amizade.id_relacionamento) nro_de_amizades,
        count (distinct idioma_nome) nro_de_idiomas
    from usuário natural join amizade natural join estudo
    group by nome;
""")
print(from_db_cursor(cur))



input("")
print("\n\n\n\n\n\nCONSULTA 10")
print("Para cada idioma (mostrar a bandeira), mostrar a quantidade total de experiência obtida no mês pelos usuários que estudam o idioma e que gastaram mais de [PARÂMETRO] reais na loja: ")
input("")

cur.execute("""
    Select SUM(usuário.RankingExpMês), idioma.bandeira
    From usuário natural join estudo natural join idioma
    WHERE usuário.username IN
        (SELECT usuário.username
          FROM usuário NATURAL JOIN compra NATURAL JOIN itens_da_loja
          GROUP BY usuário.username
          HAVING SUM(Itens_da_loja.preço) > %(valor)s)
    GROUP BY idioma.bandeira;
""",
{
    'valor': (input("Gastaram mais que: "))
})

rows = cur.fetchall()

for row in rows:
    print("Experiência total do mês: " + str(row[0]))
    file = open("tmp/bandeira", "wb")
    file.write(row[1])
    file.close()
    subprocess.check_call(['./lsix', 'tmp/bandeira'])

