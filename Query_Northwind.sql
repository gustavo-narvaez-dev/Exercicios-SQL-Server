--SELECT NOME_COLUNA
--FROM TABELA A, TABELA B
--WHERE CONDICAO

-- EXERCÍCIO 1 (SELF JOIN - Me traga o nome e data de contratação de todos os funcionários que foram contratados no mesmo ano.)
SELECT A.FIRSTNAME, A.HIREDATE, B.FirstName, B.HireDate 
FROM DBO.Employees A, DBO.Employees B
WHERE DATEPART(YEAR, A.HireDate) = DATEPART(YEAR, B.HireDate)

-- EXERCÍCIO 2 (SELF JOIN - NA tabela detalhe do pedido, quais são os produtos que tem o mesmo percentual de desconto?)
SELECT A.ProductID, A.Discount, B.ProductID, B.Discount
FROM dbo.[Order Details] A, dbo.[Order Details] B
WHERE a.Discount = b.Discount 
ORDER BY A.Discount DESC; 