-- 1) Quantidade de lingotes gastos, por usuário, da divisão bronze:
select username,sum(preço) as lingotes
from usuário natural join compra natural join itens_da_loja
where rankingdivisão='bronze'
group by username;
 

 
--  2) Username,exp total e quantidade de conquistas, de usuários matriculados em mais de um idioma:
select username, exptotal, count (conquista.título_conquista) nrodeconquistas
from usuário natural join estudo inner join desbloqueio on  desbloqueio.usuario_user = estudo.username inner join conquista on conquista.objetivo = desbloqueio.progresso
group by username
having count (idioma_nome)> 1;
   
   
-- 3) Username,ranking, xp, maior nível de idioma, de amigos do usuário de username umaLinha:
select usuário.username,exptotal,rankingdivisão,rankingposição, max(nível) maior_nível_de_idioma
from estudo natural join usuário
where usuário.username in (select distinct username from amizade 
				            where username in
                                    (select userseguindo username
				                     from amizade
				                     where username='umaLinha'
				                     union
				                     select userehseguido username
			                         from amizade
				                     where username='umaLinha'))			
group by usuário.username;


-- 4) Divisão (ranking) , e username dos usuários que desbloquearam todas as conquistas que o Joel Santana tem:
   select distinct username,rankingdivisão
   from  usuário U
   where username <> 'joel_santana13' and not exists (select * from 
   desbloqueio inner join conquista on conquista.objetivo = desbloqueio.progresso
   where usuario_user='joel_santana13' and conquista.título_conquista not in
													  (select conquista.título_conquista 
													   from desbloqueio inner join conquista on conquista.objetivo = desbloqueio.progresso where usuario_user=U.username));
													   
													   
													   
													  
-- 5) Enunciados e respostas corretas das perguntas de tradução, da lição de francês que o username jovemAprendiz3 tem disponível para fazer:
select título,texto,opcerta
from LiçõesdoUsuário natural join tradução
where username='jovemAprendiz3'and idioma_nome='francês';


-- 6) Trajes do Duo comprados pelo username jovemAprendiz3, avatar, preço, nome e descrição do item:
select username,avatar,nomedoitem,preço,descrição
from usuário natural join compra natural join itens_da_loja
where username='jovemAprendiz3' and traje;

-- 7) Quantidade de xp total recebida por formato de pergunta do idioma inglês no nível 2
select 'tradução',sum(qtdexp)
from lição join pergunta using (lição_sequência) natural join tradução
where lição.idioma_nome='inglês' and idioma_nível = 2
union
select 'pronunciação',sum(qtdexp)
from lição join pergunta using (lição_sequência) natural join pronunciação
where lição.idioma_nome='inglês' and idioma_nível = 2
union
select 'interpretação de áudio',sum(qtdexp)
from lição join pergunta using (lição_sequência) natural join interpretação_de_áudio
where lição.idioma_nome='inglês' and idioma_nível = 2
union
select 'associação com imagens',sum(qtdexp)
from lição join pergunta using (lição_sequência) natural join associação_com_imagem
where lição.idioma_nome='inglês' and idioma_nível = 2;


-- 8) Quantidade de xp, por idioma, que o usuário ganha ao completar todas as lições do nível em que se encontra no idioma:
select estudo.idioma_nome,sum(qtdexp) exp
from estudo join lição using (idioma_nome) join pergunta using (lição_sequência)
where lição.idioma_nível=estudo.nível and estudo.username='joel_santana13'
group by estudo.idioma_nome;


-- 9) Para cada usuário(nome), mostrar a sua quantidade de amigos e quantidade de idiomas que ele estuda:
select nome,count(distinct amizade.id_relacionamento) nro_de_amizades, count (distinct idioma_nome) nro_de_idiomas
from usuário natural join amizade natural join estudo
group by nome;


-- 10) Para cada idioma (mostrar a bandeira), mostrar a quantidade total de experiência obtida no mês pelos usuários que estudam o idioma e que gastaram mais de [parâmetro] reais na loja.
Select SUM(usuário.RankingExpMês), idioma.bandeira
From usuário natural join estudo natural join idioma
WHERE usuário.username IN
        (SELECT usuário.username
          FROM usuário NATURAL JOIN compra NATURAL JOIN itens_da_loja
          GROUP BY usuário.username
          HAVING SUM(Itens_da_loja.preço) > 1)
          GROUP BY idioma.bandeira;
