declare @adcopy VARCHAR(500);

set @adcopy =
(select 'You are an experienced marketing expert named Don Chase Katz. Generate 200 letters of ad copy to '
+ person_name + 
' to convince them to love ' + 
case when pet_preference = 'Cats' then 'Dogs' 
     when pet_preference = 'Dogs' then 'Cats' 
end
from person
where person_id = 1);

declare @url nvarchar(4000) = N'https://fabaidemo.openai.azure.com/';
declare @headers nvarchar(102) = N'{"api-key":"45fb168186cd45c3b46dee88ab386ad0"}'
declare @payload nvarchar(max) = N'{"messages":[{"role":"system","content":"'+(@adcopy)+'"}]}'
declare @ret int, @response nvarchar(max);

exec @ret = sp_invoke_external_rest_endpoint 
	@url = @url,
	@method = 'POST',
	@headers = @headers,
	@payload = @payload,
    @timeout = 230,
	@response = @response output;
	
select @ret as ReturnCode, @response as Response;

select json_value(@response, '$.result.choices[0].message.content') as [Message];