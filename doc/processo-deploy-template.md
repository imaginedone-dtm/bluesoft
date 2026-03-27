# Template de Processo de Deploy

Este documento serve como modelo para padronizar o processo de deploy em outros projetos.

## Objetivo

Executar deploy com escopo controlado, validacao manual do manifesto e rastreabilidade das acoes realizadas.

## Parametros do projeto

Preencha os campos abaixo antes de usar este processo:

- Branch base: `<main|master|release/x.y>`
- Regra para branch de trabalho: `<origem do nome, ex.: ClickUp, Jira, Azure Boards>`
- Org de dev (fonte para retrieve): `<alias-ou-username-da-org-fonte>`
- Org de destino: `<alias-ou-username-da-org>`
- Org de destino alternativa: `<producao, pre-prod, staging, outra>`
- Caminho do manifesto: `<manifest/package-deploy.xml>`
- Comando de deploy adotado pelo projeto: `<sf project deploy start ...>`
- Validacoes adicionais obrigatorias: `<testes, queries, aprovacao funcional, smoke test>`

## Passo a passo

1. Receber do responsavel pela demanda o nome da branch de trabalho.
2. Atualizar a branch base local com a versao mais recente do repositorio remoto.
3. Criar a branch de trabalho informada para a entrega.
4. Receber do responsavel pela demanda a org de dev (fonte) para retrieve.
5. Confirmar que a org de dev esta conectada no Salesforce CLI.
6. Receber do responsavel pela demanda a lista explicita dos itens que devem compor o manifesto.
7. Organizar as alteracoes em commits logicos somente depois que o escopo do deploy estiver claro.
8. Gerar o manifesto de deploy contendo somente os itens informados.
9. Fazer retrieve da org de dev com base no manifesto aprovado para garantir os componentes locais.
10. Incluir dependencias minimas apenas quando forem estritamente necessarias.
11. Parar o processo e deixar o manifesto pronto no arquivo para validacao manual direta no editor.
12. Prosseguir com o commit final e com o deploy somente apos aprovacao explicita do conteudo final do arquivo.
13. Executar o deploy na org de destino.
14. Se o deploy falhar, corrigir o problema e tentar novamente.
15. Ao final, registrar o resumo do deploy, os comandos executados e os proximos passos.

## Regra obrigatoria

- Nunca substituir automaticamente o conteudo do manifesto sem validacao previa.
- Nunca assumir sozinho quais itens devem entrar no manifesto; a lista deve ser informada antes da geracao do XML e antes do commit final.
- Nunca definir sozinho o nome da branch da tarefa; ele deve ser informado antes do inicio do trabalho.
- Nunca executar retrieve em org de dev nao informada pelo responsavel da demanda.

## Validacao do manifesto

- Para manifestos pequenos, a validacao pode acontecer por chat.
- Para manifestos grandes, a validacao deve acontecer diretamente no arquivo do manifesto.
- O responsavel pela demanda pode editar ou colar manualmente a versao final no arquivo antes da aprovacao.
- O processo so avanca depois da aprovacao explicita do conteudo final salvo no arquivo.

## Checklist de pre-deploy

- Branch base atualizada.
- Nome da branch da demanda recebido e confirmado.
- Branch da demanda criada corretamente.
- Org de dev (fonte) recebida, conectada e conferida.
- Lista de itens do manifesto recebida e confirmada.
- Alteracoes revisadas.
- Commits organizados de forma logica.
- Manifesto montado com escopo minimo.
- Retrieve executado a partir da org de dev com base no manifesto.
- Dependencias revisadas e justificadas.
- Validacao manual do manifesto aprovada.
- Alias da org de destino conferido.
- Comandos de validacao do projeto executados, quando aplicavel.

## Checklist de pos-deploy

- Deploy concluido sem erros.
- Componentes implantados confirmados.
- Testes e validacoes minimas executados na org.
- Resumo do que foi deployado registrado.
- Comandos executados registrados.
- Pendencias ou riscos remanescentes documentados.
- Proximos passos para homologacao e producao definidos.

## Modelo de entrega final

Use esta estrutura ao encerrar a execucao:

### Resumo do que foi deployado

- `<item 1>`
- `<item 2>`

### Comandos executados

```bash
<comando 1>
<comando 2>
```

### Proximos passos

1. `<passo para homologacao>`
2. `<passo para producao>`

## Observacoes para reutilizacao

Este template pode ser copiado para qualquer repositorio, desde que os parametros do projeto sejam preenchidos antes do primeiro uso.