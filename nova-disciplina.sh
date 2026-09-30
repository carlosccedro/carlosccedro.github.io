#!/usr/bin/env bash
# Cria uma nova disciplina a partir do modelo em _templates/disciplina.
# Uso: ./nova-disciplina.sh pasta-da-disciplina "Nome da Disciplina"
# Exemplo: ./nova-disciplina.sh seguranca-da-informacao "Segurança da Informação"
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Uso: ./nova-disciplina.sh pasta-da-disciplina \"Nome da Disciplina\""
  exit 1
fi

pasta="$1"
nome="$2"
destino="disciplinas/$pasta"

if [ -e "$destino" ]; then
  echo "A pasta $destino já existe. Escolha outro nome."
  exit 1
fi

cp -r _templates/disciplina "$destino"
sed -i.bak "s/Nome da disciplina/$nome/g" "$destino/index.qmd" "$destino/slides/_metadata.yml"
rm -f "$destino/index.qmd.bak" "$destino/slides/_metadata.yml.bak"

echo "Disciplina criada em $destino"
echo "Próximos passos: edite $destino/index.qmd (ementa, objetivos e cronograma)"
echo "e visualize com: quarto preview"
