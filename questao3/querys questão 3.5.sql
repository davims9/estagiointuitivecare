SELECT dc.reg_ans, op.razao_social, op.nome_fantasia, 
	SUM(vl_saldo_final - vl_saldo_inicial) AS despesas_medico_hospitalar
	FROM operadoras op
		INNER JOIN dados_contabeis dc ON (dc.reg_ans = op.registro_ans)  
		INNER JOIN contas_contabeis cc ON (cc.codigo_conta = dc.cod_conta_contabil)
	WHERE cc.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
		AND (YEAR(data_diops) = (SELECT YEAR(MAX(data_diops)) 
									FROM dados_contabeis) 
			AND QUARTER(data_diops) = (SELECT QUARTER(MAX(data_diops)) 
											FROM dados_contabeis 
                                            WHERE YEAR(data_diops) = (SELECT YEAR(MAX(data_diops)) 
																			FROM dados_contabeis)))  
    GROUP BY dc.reg_ans, op.razao_social, op.nome_fantasia
	ORDER BY despesas_medico_hospitalar DESC
    LIMIT 10;
    
SELECT dc.reg_ans, op.razao_social, op.nome_fantasia,
	SUM(vl_saldo_final - vl_saldo_inicial) AS despesas_medico_hospitalar
	FROM operadoras op
		INNER JOIN dados_contabeis dc ON (dc.reg_ans = op.registro_ans) 
		INNER JOIN contas_contabeis cc ON (cc.codigo_conta = dc.cod_conta_contabil)
	WHERE cc.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
		AND YEAR(data_diops) = (SELECT YEAR(MAX(data_diops)) 
									FROM dados_contabeis)
    GROUP BY dc.reg_ans, op.razao_social, op.nome_fantasia
	ORDER BY despesas_medico_hospitalar DESC
    LIMIT 10