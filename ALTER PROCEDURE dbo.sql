ALTER PROCEDURE dbo.insert_todo
    @title nvarchar(1000),
    @owner_id [varchar](128),
    @order int
AS

    declare @translated_task VARCHAR(1000);
    declare @url nvarchar(4000) = N'https://aidemo.openai.azure.com/openai/deployments/chattycathy/chat/completions?api-version=2023-07-01-preview';
    declare @headers nvarchar(102) = N'{"api-key":"1234567890"}'
    declare @payload nvarchar(max) = N'{"messages":[{"role":"system","content":"Translate \"'+(@title)+'\" into german, only respond with the translation"}]}'
    declare @ret int, @response nvarchar(max);

BEGIN

    exec @ret = sp_invoke_external_rest_endpoint 
        @url = @url,
        @headers = @headers,
        @method = 'POST',
        @payload = @payload,
        @timeout = 230,
        @response = @response output;

    set @translated_task = 
    (SELECT [translated_task]
    FROM OPENJSON(@response,'$.result.choices')
    WITH ([translated_task] NVARCHAR(100) '$.message.content'));

    insert into dbo.todo (title, owner_id, position)
    OUTPUT INSERTED.*
    values (ISNULL(@translated_task,@title), @owner_id, @order);

END;
GO