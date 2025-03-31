import os
import requests
from bs4 import BeautifulSoup
from zipfile import ZipFile

# Acesso ao site
url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
response = requests.get(url)
soup = BeautifulSoup(response.content, "html.parser")

# Localizar os links 
anexos = {}
for link in soup.find_all("a", href=True):
    if ("Anexo I" in link.text or "Anexo II" in link.text) and link['href'].endswith(".pdf"):
        anexos[link.text.strip()] = link['href']

# Download dos PDFs 
os.makedirs("anexos", exist_ok=True)
for nome, link in anexos.items():
    pdf_response = requests.get(link)
    nome_arquivo = link.split("/")[-1]
    with open(f"anexos/{nome_arquivo}", "wb") as file:
        file.write(pdf_response.content)

# Compactar os PDFs em um arquivo ZIP
with ZipFile("anexos.zip", "w") as zipf:
    for nome_arquivo in os.listdir("anexos"):
        zipf.write(f"anexos/{nome_arquivo}", arcname=nome_arquivo) 

print("Arquivos PDF baixados e compactados!")