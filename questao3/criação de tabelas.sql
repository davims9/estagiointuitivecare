USE operadoras_ativas_ans;

CREATE TABLE modalidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    UNIQUE KEY uk_nome (nome)
);

CREATE TABLE regiao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(300),
    UNIQUE KEY uk_nome (nome)
);

CREATE TABLE operadoras (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    registro_ans VARCHAR(10),
    cnpj VARCHAR(14) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    modalidade_id INT,
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep VARCHAR(8),
    ddd VARCHAR(2),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(255),
    regiao_comercializacao INT,
    data_registro_ans DATE NOT NULL,
    UNIQUE KEY uk_registro_ans (registro_ans),
    FOREIGN KEY (modalidade_id) REFERENCES modalidades(id),
    FOREIGN KEY (regiao_comercializacao) REFERENCES regiao(id)
);


CREATE TABLE contas_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_conta VARCHAR(9),
    descricao VARCHAR(200),
    UNIQUE KEY uk_codigo_conta (codigo_conta)
);

CREATE TABLE dados_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_diops DATE NOT NULL,
    reg_ans VARCHAR(10),
    cod_conta_contabil VARCHAR(9),
    vl_saldo_inicial DECIMAL(20,2),
    vl_saldo_final DECIMAL(20,2),
	FOREIGN KEY (reg_ans) REFERENCES operadoras(registro_ans),
    FOREIGN KEY (cod_conta_contabil) REFERENCES contas_contabeis(codigo_conta)
);




