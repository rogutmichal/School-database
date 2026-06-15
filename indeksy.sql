
select t.name, i.name, i.type, i.type_desc from sys.tables t join sys.indexes i on t.object_id=i.object_id

set statistics io on 

select * from Uczestnictwo
where Uczniowie_Id_osoby = 200;


create clustered  index ind_uczest_id_os  on Uczestnictwo(Uczniowie_Id_osoby)
