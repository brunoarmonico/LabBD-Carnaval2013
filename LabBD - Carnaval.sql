create database Carnaval2013
go 
use Carnaval2013

create table escola (

id int identity (1,1),
nome_escola varchar(40)

primary key (id)
)

create table jurado (

id int identity (1,1),
nome_jurado varchar(40)

primary key (id)
)

create table quesito (
id int identity (1,1),
nome_quesito varchar(20) not null,
primary key (id)
)
drop table notas

create table notas (
id int identity (1,1),
nota decimal (3,1),
id_jurado int,
id_escola int,
id_quesito int,
descarte decimal(3,1)

primary key (id),
foreign key (id_jurado) references jurado(id),
foreign key (id_escola) references escola(id),
foreign key (id_quesito) references quesito(id)
)

insert into escola(nome_escola) values 
('Acadêmicos do Tatuapé'),
('Rosas de Ouro'),
('Mancha Verde'),
('Vai-Vai'),
('X-9 Paulistana'),
('Dragões da Real'),
('Aguia de Ouro'),
('Nenê de Vila Matilde'),
('Gaviões da Fiel'),
('Mocidade Alegre'),
('Tom Maior'),
('Unidos de Vila Maria'),
('Acadêmicos do Tucuruvi'),
('Imperios de Casa Verde')

insert into jurado(nome_jurado) values 
('Dmitri'),
('Afonso'),
('Ricardo'),
('Ana'),
('Vasili')

insert into quesito (nome_quesito) values
('Comissão de Frente'),
('Evolução'),
('Fantasia'),
('Bateria'),
('Alegoria'),
('Harmonia'),
('Samba-Enredo'),
('Mestre Sala'),
('Porta-Bandeira'),
('Enredo')

select * from notas

drop procedure adiciona_nota

create procedure adiciona_nota (@nota decimal(3,1), @id_quesito int, @id_jurado int, @id_escola int, @saida varchar(max) output) 
as
	declare @query varchar (max),
			@contador int,
			@menor int,
			@maior int
	if (@nota < 5 or @nota > 10)
	begin
		set @saida = 'Nota inválida'
	end
	else
	begin
		set @query = 'insert into notas (nota, id_jurado, id_escola, id_quesito) values (' + cast(@nota as varchar(5))  +', ' + cast(@id_jurado as varchar(2)) +', ' + cast(@id_escola as varchar(2)) + ', ' + cast(@id_quesito as varchar(2)) +')'
		exec (@query)
		set @contador = (select count(id_jurado) from notas
			where (id_escola = @id_escola) and (id_quesito = @id_quesito))
		if (@contador >= 3)
		begin
			set @menor = (select min(nota) from notas
			where (id_escola = @id_escola) and (id_quesito = @id_quesito))

			set @maior = (select max(nota) from notas
			where (id_escola = @id_escola) and (id_quesito = @id_quesito))
		end
		update notas set descarte = null where (id_escola = @id_escola) and (id_quesito = @id_quesito)
		update top(1) notas set descarte = @menor where (nota = @menor) and (id_escola = @id_escola) and (id_quesito = @id_quesito)
		update top(1) notas set descarte = @maior where (nota = @maior) and (id_escola = @id_escola) and (id_quesito = @id_quesito)

		set @saida = 'Nota inserida com sucesso!'
	end

	select * from notas
declare @saida varchar (max)
exec adiciona_nota 10, 4, 2, 2, @saida output
print @saida


select * from notas

create procedure recebe_notas
as
select nt.id as id_nota, nt.nota as nota, nt.id_jurado as id_jurado, jr.nome_jurado as nome_jurado,
 nt.id_quesito as id_quesito, qr.nome_quesito as nome_quesito, nt.id_escola as id_escola, es.nome_escola as nome_escola
  from notas nt
inner join jurado jr
on nt.id_jurado = jr.id
inner join quesito qr
on nt.id_quesito = qr.id
inner join escola es
on nt.id_escola = es.id
return

exec recebe_notas

create function fn_prnota (@id_esc int, @id_que int, @id_jur int)
returns @tabela table (
escola varchar (50),
quesito varchar (50),
jurado varchar (50)
)
as
begin
insert @tabela (escola, quesito, jurado)
select nome_escola, nome_quesito, nome_jurado from escola, quesito, jurado where (escola.id = @id_esc) and (quesito.id = @id_que) and (jurado.id = @id_jur)
return
end

select * from fn_prnota (2, 5, 3)

drop table notas

create function fn_pesquisa_quesito (@id_que int)
returns @tabela table (
ordem int identity(1,1),
escola varchar (50),
quesito varchar (50),
jurado varchar (50),
nota decimal(3,1),
descarte decimal(3,1)
)
as
begin
	insert @tabela (escola, quesito, jurado, nota, descarte)
	select es.nome_escola as nome_escola, qr.nome_quesito as nome_quesito, jr.nome_jurado as nome_jurado, nt.nota as nota, nt.descarte as descarte
  from notas nt
inner join jurado jr
on nt.id_jurado = jr.id
inner join quesito qr
on nt.id_quesito = qr.id
inner join escola es
on nt.id_escola = es.id
where (id_quesito = @id_que)
order by (nt.id_escola)
return
end

select * from fn_pesquisa_quesito(1)

create function fn_pegar_quesitos ()
returns @tabela table(
id int,
nome_quesito varchar(20)
)
as
begin
	insert @tabela (id, nome_quesito)
	select * from quesito
return	
end

select * from fn_pegar_quesitos()

create function fn_pega_total()
returns @tabela table(
id int identity (1,1),
nome varchar(40),
total decimal(7,1)
)
as
begin
	insert @tabela(nome,total)
	select es.nome_escola, sum(nt.nota) from notas nt
	inner join escola es
	on es.id = nt.id_escola
	where nt.descarte is null
	group by nome_escola
	order by sum(nt.nota) desc
return
end

select * from fn_pega_total()
