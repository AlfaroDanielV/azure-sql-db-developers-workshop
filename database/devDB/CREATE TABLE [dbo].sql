CREATE TABLE [dbo].[products]
(
    [product_id] [int] NOT NULL,
    [product_name] [nvarchar](1000) NOT NULL,
    [ListPrice] [money] NOT NULL
) 
GO

insert into dbo.products (product_id, product_name, ListPrice)
values 
    (1,N'Candy',1.99),
    (2,N'Bike',100.00),
    (3,N'Doll',15.99),
    (4,N'Goo',189.50);
GO

select * from dbo.products;
GO