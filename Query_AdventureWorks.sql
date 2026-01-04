-- EXERCÍCIO 1 (WHERE)
SELECT name
FROM Production.Product
WHERE weight > 500 AND weight <= 700 

-- EXERCÍCIO 2 (WHERE)
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'M' AND SalariedFlag = 1;

-- EXERCÍCIO 3 (WHERE)
SELECT *
FROM person.person
WHERE FirstName = 'Peter' and LastName = 'Krebs';

SELECT *
FROM person.EmailAddress
WHERE BusinessEntityID = 26;

-- EXERCÍCIO 1 (COUNT)
SELECT count(*)
FROM Production.Product;

-- EXERCÍCIO 2 (COUNT)
SELECT count(size)
FROM Production.Product;

-- EXERCÍCIO 3 (COUNT)
SELECT count(DISTINCT size)
FROM Production.Product;

-- EXERCÍCIO 1 (ORDER BY)
SELECT TOP 10 ProductID, ListPrice
FROM Production.Product
ORDER BY ListPrice desc;

-- EXERCÍCIO 2 (ORDER BY)
SELECT TOP 4 Name, ProductNumber
FROM Production.Product
ORDER BY ProductID asc;

-- EXERCÍCIO 1 (FUNDAMENTOS SQL - Quantos produtos há no sistema que custam mais que 1500 "dólares"?)
SELECT count(ListPrice)
FROM Production.Product
WHERE ListPrice > 1500;

-- EXERCÍCIO 2 (FUNDAMENTOS SQL - Quantas pessoas temos com o sobrenome que inicia com a letra "P"?)
SELECT count(LastName) 
FROM Person.Person
WHERE lastname LIKE 'P%';

-- EXERCÍCIO 3 (FUNDAMENTOS SQL - Quantas cidades únicas temos em nosso sistema?)
SELECT count(DISTINCT (city))
FROM Person.Address;

-- EXERCÍCIO 4 (FUNDAMENTOS SQL - Quais são as cidades únicas cadastradas em nosso sistema?)
SELECT DISTINCT (city)
FROM person.Address;

-- EXERCÍCIO 5 (FUNDAMENTOS SQL - Quantos produtos vermelhos tem o preço entre 500 e 1000 dólares?)
SELECT count(*)
FROM Production.Product
WHERE color = 'red' and ListPrice BETWEEN 500 and 1000;

-- EXERCÍCIO 6 (FUNDAMENTOS SQL - Quantos produtos cadastrados tem a palavra 'road' no nome?)
SELECT count(*)
FROM Production.Product
WHERE name like '%road%';

-- FUNÇÕES DE AGREGAÇÃO
SELECT COUNT(FirstName)
FROM Person.Person

SELECT max(LineTotal) AS "MAIOR VALOR"
FROM Sales.SalesOrderDetail

SELECT min(LineTotal) AS "MENOR VALOR"
FROM Sales.SalesOrderDetail

SELECT avg(LineTotal) AS "MEDIA"
FROM Sales.SalesOrderDetail

SELECT sum(LineTotal) AS "SOMA"
FROM Sales.SalesOrderDetail

-- GROUP BY (AGRUPAR POR..., exemplo: há vários ID's 707 e 708, ent ele agrupa todos os 707 e 708 em duas linhas apenas (uma pra cada))
/*
	sintaxe básica

	SELECT coluna_ou_funcao_agregacao(coluna)
	FROM tabela
	WHERE condição
	GROUP BY coluna_ou_colunas
	ORDER BY coluna_ou_colunas
*/

-- QUANTIDADE DE CADA NOME QUE HÁ NO BANCO DE DADOS "AdventureWorks2017"
SELECT FirstName AS "NOMES", COUNT(FirstName) AS "QTD NOMES"
FROM person.Person
GROUP BY FirstName
ORDER BY [QTD NOMES], NOMES asc;

-- PREÇO MÉDIO DOS PRODUTOS QUE SÃO PRATAS
SELECT color, AVG(ListPrice) AS "Preço Médio"
FROM Production.Product
WHERE color = 'Silver'
GROUP BY color;

-- EXERCÍCIO 1 (INTERMEDIÁRIO - Quantas pessoas tem o mesmo MiddleName?)
SELECT middlename, COUNT(MiddleName) AS "Quantidade de pessoas"
FROM Person.Person
GROUP BY MiddleName;

-- EXERCÍCIO 2 (INTERMEDIÁRIO - EM MÉDIA, QUAL A QUANTIDADE QUE CADA PRODUTO É VENDIDO NA LOJA?)
SELECT ProductID AS "CÓDIGO DO PRODUTO", AVG(OrderQty) AS "QUANTIDADE MÉDIA DE VENDAS"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID asc

-- EXERCÍCIO 3 (INTERMEDIÁRIO - QUAIS FORAM OS 10 PRODUTOS QUE TIVERAM OS MAIORES VALORES DE VENDA POR PRODUTO, DO MAIOR PARA O MENOR?)
SELECT TOP 10 ProductId, SUM(LineTotal) AS "VALOR DE VENDA MAIS ALTO"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY [VALOR DE VENDA MAIS ALTO] desc

-- EXERCÍCIO 4 (INTERMEDIÁRIO - Quantos produtos e qual é a quantidade média de produtos temos cadastrados nas nossas ordens de serviço (WorkOrder), agrupados por productID?)
SELECT 
	ProductID, 
	COUNT(ProductID) AS "CONTAGEM",
	AVG(OrderQty) AS "QTD MÉDIA"
FROM 
	Production.WorkOrder
GROUP BY 
	ProductID;

-- EXERCÍCIO 1 (HAVING - QUAIS SÃO OS PRODUTOS QUE, NO TOTAL DE VENDAS, ESTÃO ENTRE 162k A 500k EM ORDEM CRESCENTE?)
SELECT 
	ProductID, 
	SUM(LineTotal) AS "VALOR TOTAL DE VENDA"
FROM 
	sales.SalesOrderDetail
GROUP BY 
	ProductID
HAVING 
	SUM(LineTotal) BETWEEN 162000 AND 500000
ORDER BY 
	[VALOR TOTAL DE VENDA] ASC;

-- EXERCÍCIO 2 (HAVING - QUAIS PROVÍNCIAS ESTÃO REGISTRADAS NO BANCO DE DADOS MAIS QUE 1000 VEZES?)
SELECT StateProvinceID, count(StateProvinceID) AS "CONTAGEM"
FROM Person.Address
GROUP BY StateProvinceID
HAVING count(StateProvinceID) > 1000
ORDER BY CONTAGEM ASC;

-- EXECÍCIO 3 (HAVING - QUAIS PRODUTOS NÃO ESTÃO TRAZENDO, EM MÉDIA, NO MÍNIMO 1 MILHÃO EM TOTAL DE VENDAS?)
SELECT ProductID, AVG(LineTotal) AS "VALOR TOTAL DE VENDA"
FROM sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) < 1000000
ORDER BY [VALOR TOTAL DE VENDA] ASC;

-- EXERCÍCIO 1 (INNER JOIN - A equipe de gestão precisa das informações sobre o nome e a subcategoria de todos os produtos do sistema!)
SELECT pp.name NOME_PRODUTO, ps.name SUBCATEGORIA
FROM production.Product pp
INNER JOIN production.ProductSubcategory ps ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
ORDER BY SUBCATEGORIA, NOME_PRODUTO ASC;

-- EXERCÍCIO 2 (INNER JOIN - A equipe de logística precisa saber quais cidades pertencem a quais estados para fazer uma pesquisa de rotas! Inclua as informações de ID's)
SELECT AD.AddressID, AD.City, SP.StateProvinceID, SP.Name StateProvinceName
FROM Person.StateProvince SP
INNER JOIN Person.Address AD ON SP.StateProvinceID = AD.StateProvinceID
ORDER BY City, StateProvinceName ASC;

/*
			* * * *  TIPOS DE JOINS  * * * *

	INNER JOIN (ou apenas JOIN): retorna apenas a interseção (o que é igual em ambas as tabelas)

	FULL OUTER JOIN (ou apenas FULL JOIN): retorna tudo (o left, o right e a interseção das tabelas)

	LEFT OUTER JOIN (ou apenas LEFT JOIN): retorna apenas o left (Tabela A) E a interseção

	RIGHT OUTER JOIN (ou apenas RIGHT JOIN): retorna apenas o right (Tabela B) E a interseção
*/

-- EXERCÍCIO (LEFT JOIN - QUANTAS PESSOAS NÃO POSSUEM UM CARTÃO DE CRÉDITO CADASTRADO?)
SELECT count(*) 
FROM Person.Person PP
LEFT JOIN Sales.PersonCreditCard PC
ON pp.BusinessEntityID = pc.BusinessEntityID -- 19.972 POSSUEM E NAO POSSUEM CARTÃO DE CRÉDITO

SELECT count(*)
FROM Person.Person PP
INNER JOIN Sales.PersonCreditCard PC
ON pp.BusinessEntityID = pc.BusinessEntityID -- 19.118 POSSUEM CARTÃO DE CRÉDITO

SELECT 19972 - 19118 AS "Quantidade de pessoas sem cartão de crédito" -- RESPOSTA FINAL 

-- EXERCÍCIO (UNION - Traga, em ordem crescente, todos os nomes, INCLUSIVE DUPLICADOS, que comecem com K ou com G)
SELECT FirstName
FROM Person.Person
WHERE FirstName LIKE 'K%'
UNION ALL -- apenas 'UNION' retorna dados únicos (não duplicados), enquanto que 'UNION ALL' traz tudo, incluindo duplicatas
SELECT FirstName
FROM Person.Person	
WHERE FirstName LIKE 'G%'
ORDER BY FirstName -- não há necessidade de 'asc' aqui, pois o order by sozinho já retorna em ordem crescente

-- EXERCÍCIO 1 (SUBQUERY - Monte um relatório de todos os produtos que possuem preço de venda acima da média do próprio banco de dados)
SELECT *
FROM Production.Product
WHERE ListPrice > (
	SELECT AVG(ListPrice) FROM Production.Product -- retorna a média do listprice para ser comparado na consulta externa
	)

-- EXERCÍCIO 2 (SUBQUERY - Quais são os nomes dos funcionários que têm o cargo de Design Engineer?)
SELECT FirstName
FROM Person.Person
WHERE BusinessEntityID IN -- consulta externa retorna os nomes dos funcionários encontrados, por IDs apenas, na consulta interna
	(
	SELECT BusinessEntityID
	FROM HumanResources.Employee
	WHERE JobTitle = 'Design Engineer'
	-- consulta interna retorna os IDs dos funcionáros cujo cargo é desing engineer na tabela HumanResources.Employee
	)

/*
	Abaixo deixo o código que fiz para o mesmo exercício anterior, porém utilizando inner join ao invés de subconsulta

	SELECT P.Firstname
	FROM Person.Person P
	INNER JOIN HumanResources.Employee E
	ON P.BusinessEntityID = E.BusinessEntityID 
	WHERE E.JobTitle = 'Design Engineer' 
*/

-- EXERCÍCIO 3 (SUBQUERY - Traga um relatório completo de todos os endereços que estão no Estado de  'Alberta')
SELECT * -- selecionei todas as colunas para um relatório completo
FROM Person.Address 
WHERE StateProvinceID IN -- na consulta externa o ID de 'Alberta' será usado no filtro WHERE para mostrar as informações do relatório total
	(
	SELECT StateProvinceID
	FROM Person.StateProvince
	WHERE Name = 'Alberta'
	-- na consulta interna será retornado o ID do estado de 'Alberta'
	)