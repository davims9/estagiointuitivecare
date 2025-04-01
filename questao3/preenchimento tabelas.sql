USE operadoras_ativas_ans;

CREATE TEMPORARY TABLE temp_operadoras (
    registro_ans VARCHAR(50),
    cnpj VARCHAR(50),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(50),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(5),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(255),
    regiao_de_comercializacao VARCHAR(10),
    data_registro_ans DATE
);

-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Relatorio_cadop.csv'
INTO TABLE temp_operadoras
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

INSERT INTO regiao VALUES 
	(1,'Região 1', 'todo o território nacional ou em grupos de pelo menos três estados dentre os seguintes: São Paulo, Rio de Janeiro, Minas Gerais, Rio Grande do Sul, Paraná e Bahia'),
    (2,'Região 2', 'no Estado de São Paulo ou em mais de um estado, excetuando os grupos definidos no critério da região 1'),
    (3,'Região 3', 'em um único estado, qualquer que seja ele, excetuando-se o Estado de São Paulo'),
    (4,'Região 4', 'no Município de São Paulo, do Rio de Janeiro, de Belo Horizonte, de Porto Alegre ou de Curitiba ou de Brasília'),
    (5,'Região 5', 'em grupo de municípios, excetuando os definidos na região 4'),
	(6,'Região 6', 'em um único município, excetuando os definidos na região 4');
    
INSERT INTO modalidades(nome)
SELECT DISTINCT t.modalidade 
	FROM temp_operadoras t;

INSERT INTO operadoras (
    registro_ans, cnpj, razao_social, nome_fantasia, modalidade_id,
    logradouro, numero, complemento, bairro, cidade, uf, cep,
    ddd, telefone, fax, endereco_eletronico, representante,
    cargo_representante, regiao_comercializacao, data_registro_ans
)
SELECT 
    t.registro_ans,
    t.cnpj,
    t.razao_Social,
	t.nome_fantasia,
    m.id,
    t.logradouro,
    t.numero,
    t.complemento,
    t.bairro,
    t.cidade,
    t.uf,
    t.cep,
    t.ddd,
    t.telefone,
    t.fax,
    t.endereco_eletronico,
    t.representante,
    t.cargo_Representante,
    r.id,
    t.data_registro_ans
	FROM temp_operadoras t
		LEFT JOIN modalidades m ON TRIM(t.modalidade) = m.nome
		LEFT JOIN regiao r ON t.regiao_de_comercializacao = r.id;

    
CREATE TEMPORARY TABLE temp_dados_contabeis (
    data_diops DATE NOT NULL,
    reg_ans VARCHAR(10) NOT NULL,
    conta_contabil VARCHAR(9) NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    vl_saldo_inicial DECIMAL(20,2) NOT NULL,
    vl_saldo_final DECIMAL(20,2) NOT NULL
);

-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/1T2023.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/2t2023.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/3T2023.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');
    
-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/4T2023.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/1T2024.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/2T2024.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/3T2024.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


-- Carregar dados do CSV para a tabela temporária
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dadoscontrabeis/4T2024.csv'
INTO TABLE temp_dados_contabeis
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_diops, reg_ans, conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
	data_diops = IF (@data_diops REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$', STR_TO_DATE(@data_diops, '%d/%m/%Y'), @data_diops),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

INSERT INTO contas_contabeis
(codigo_conta,descricao)
SELECT DISTINCT t.conta_contabil, t.descricao 
	FROM temp_dados_contabeis t;

INSERT INTO dados_contabeis
(data_diops, reg_ans, cod_conta_contabil, vl_saldo_inicial, vl_saldo_final)
SELECT t.data_diops, op.registro_ans, cc.codigo_conta, t.vl_saldo_inicial, t.vl_saldo_final
	FROM temp_dados_contabeis t
		LEFT JOIN contas_contabeis cc ON (cc.codigo_conta = t.conta_contabil)
		LEFT JOIN operadoras op ON (op.registro_ans = t.reg_ans);
    