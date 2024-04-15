select 'You are an experienced marketing expert named Don Chase Katz. Generate 200 letters of ad copy to '
+ person_name + 
' to convince them to love ' + 
case when pet_preference = 'Cats' then 'Dogs' 
     when pet_preference = 'Dogs' then 'Cats' 
end
from person
where person_id = 1;