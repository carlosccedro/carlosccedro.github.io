#!/bin/sh
# Procura arquivos com nomes típicos de material restrito.
# Uso: sh .githooks/verificar-restritos.sh            (todo o repositório)
#      sh .githooks/verificar-restritos.sh --staged   (só o que vai no commit)
PADRAO='(^|[/_. -])(restrito|gabaritos?|respostas?|solucao|solução|provas?[0-9]*|notas|notas-finais|frequencia|frequência|lista[-_]de[-_]alunos)([/_. -]|$)'
if [ "$1" = "--staged" ]; then
  LISTA=$(git diff --cached --name-only --diff-filter=ACMR)
else
  LISTA=$(git ls-files 2>/dev/null || find . -type f -not -path "./.git/*")
fi
ACHADOS=$(printf '%s\n' "$LISTA" | grep -iE "$PADRAO")
if [ -n "$ACHADOS" ]; then
  echo "BLOQUEADO: estes arquivos parecem ser material restrito:"
  printf '%s\n' "$ACHADOS" | sed 's/^/  - /'
  echo "Guarde gabaritos, provas e notas fora do portal (AVA ou repositório privado)."
  echo "Se for um falso positivo, renomeie o arquivo."
  exit 1
fi
exit 0
