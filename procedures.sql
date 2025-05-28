USE Course

IF OBJECT_ID('drop_table', 'P') IS NOT NULL DROP PROCEDURE drop_table 
GO

CREATE PROCEDURE drop_table(@table_name VARCHAR(128))
AS
BEGIN
	DECLARE
		@id	INT = OBJECT_ID(@table_name)
	IF @id IS NOT NULL
	BEGIN
		DECLARE
			@var_fk 	VARCHAR(128),
			@var_tfk	VARCHAR(128)
		WHILE (1 = 1)
		BEGIN		
			SET @var_fk = OBJECT_NAME((SELECT TOP 1 [object_id] FROM sys.foreign_keys WHERE referenced_object_id = @id))
			IF (@var_fk is null)
				BREAK;
			SET @var_tfk = OBJECT_NAME((SELECT parent_object_id FROM sys.foreign_keys WHERE name = @var_fk))
			EXECUTE ('alter table '+ @var_tfk + ' drop constraint ' + @var_fk)
		END		
		EXECUTE ('drop table ' + @table_name)
	END
END
GO