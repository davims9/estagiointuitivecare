import os
import tabula 
import pandas as pd
import re
from zipfile import ZipFile

# Caminho do arquivo PDF
current_directory = os.getcwd()

pdf_path = os.path.join(current_directory, 'questao2', 'Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf')

print(f"Procurando o arquivo em: {pdf_path}")

# Definir os cabeçalhos para pegar corretamente as tabelas em cada pagina
nome_colunas = [
    "PROCEDIMENTO",
    "RN (alteração)",
    "VIGÊNCIA",
    "OD",
    "AMB",
    "HCO",
    "HSO",
    "REF",
    "PAC",
    "DUT",
    "SUBGRUPO",
    "GRUPO",
    "CAPÍTULO"
]

# Extrair tabelas com configurações otimizadas
tabelas = tabula.read_pdf(
    pdf_path,
    pages='all',
    multiple_tables=True,
    lattice=True,
    pandas_options={'header': None},
    guess=False,
    stream=True
)

# Função para corrigir quebras de linha
def corrigir_quebras(texto):
    if not isinstance(texto, str):
        return texto
    # Substituir quebras de linha por espaço quando não for início de nova entrada
    texto = re.sub(r'(?<!\n)\n(?!\n)', ' ', texto)
    # Remover múltiplos espaços
    texto = re.sub(r'\s+', ' ', texto).strip()
    return texto

# Processar tabelas
tabelas_processadas = []
for tabela in tabelas:
    if len(tabela.columns) >= len(nome_colunas):
        # Encontrar linha de cabeçalho
        for idx, row in tabela.iterrows():
            if any(col in str(row[0]) for col in nome_colunas[:3]):
                tabela.columns = nome_colunas[:len(tabela.columns)]
                tabela = tabela.iloc[idx+1:]
                break
        
        # Aplicar correção de quebras de linha
        for col in tabela.columns:
            tabela[col] = tabela[col].apply(corrigir_quebras)
        
        # Substituir OD e AMB
        tabela = tabela.replace({
            'OD': 'Seg. Odontológica',
            'AMB': 'Seg. Ambulatorial'
        })
        
        # Filtrar linhas válidas
        tabela = tabela.dropna(how='all')
        tabela = tabela[~tabela['PROCEDIMENTO'].astype(str).str.contains('PROCEDIMENTO|Rol de Procedimentos', na=False)]
        
        tabelas_processadas.append(tabela)

# Consolidar resultados
if tabelas_processadas:
    tabela_final = pd.concat(tabelas_processadas, ignore_index=True)
    
    # Limpeza final
    tabela_final = tabela_final.dropna(how='all')
    tabela_final = tabela_final[tabela_final['PROCEDIMENTO'].notna()]
    
    # Salvar CSV com separador ;
    csv_path = 'questao2\procedimentos_saude.csv'
    tabela_final.to_csv(csv_path, index=False, encoding='utf-8-sig', sep=';')
        
    zip_path = 'questao2\Teste_DaviMouraSouza.zip'
    with ZipFile(zip_path, 'w') as zipf:
        zipf.write(csv_path, arcname='procedimentos_saude.csv')  # Compacta o arquivo CSV com o nome dentro do ZIP
    print(f"Tabela {csv_path} salva e compactada sucesso: {zip_path}")

else:
    print("Nenhuma tabela válida encontrada.")