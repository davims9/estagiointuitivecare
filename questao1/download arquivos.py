import os
import requests
from bs4 import BeautifulSoup
from zipfile import ZipFile

# 1.1 Acesso ao site
url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
response = requests.get(url)
soup = BeautifulSoup(response.content, "html.parser")

# Localizar os links dos Anexos I e II
anexos = {}
for link in soup.find_all("a", href=True):
    if "Anexo I" in link.text or "Anexo II" in link.text:
        anexos[link.text.strip()] = link['href']

# 1.2 Download dos PDFs
os.makedirs("anexos", exist_ok=True)
for nome, link in anexos.items():
    pdf_response = requests.get(link)
    with open(f"anexos/{nome}.pdf", "wb") as file:
        file.write(pdf_response.content)

# 1.3 Compactar os PDFs em um arquivo ZIP
with ZipFile("anexos.zip", "w") as zipf:
    for nome in anexos.keys():
        zipf.write(f"anexos/{nome}.pdf", arcname=f"{nome}.pdf")

print("Anexos baixados e compactados com sucesso!")
