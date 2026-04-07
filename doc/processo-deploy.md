# Processo de Deploy

Este documento registra o passo a passo operacional para preparar e executar um deploy com manifesto controlado.

## Objetivo

Garantir que o deploy seja feito com escopo explicito, validacao manual do manifesto e registro claro do que foi executado.

## Passo a passo

1. Receber de voce o nome da branch de trabalho da tarefa, conforme definido no ClickUp.
2. Atualizar a branch `main` local com a versao mais recente do repositorio remoto.
3. Criar a branch de trabalho informada por voce para a entrega.
4. Receber de voce a org de dev (org fonte) para retrieve dos componentes.
5. Confirmar que a org de dev esta conectada no Salesforce CLI.
6. Receber de voce a lista explicita dos itens que devem compor o `manifest/package-deploy.xml`.
7. Organizar as alteracoes em commits logicos somente depois que o escopo do deploy estiver claro.
8. Gerar o arquivo `manifest/package-deploy.xml` contendo somente os itens informados por voce.
9. Fazer retrieve da org de dev com base no manifesto aprovado, para garantir os componentes locais (source-backed).
10. Incluir dependencias minimas apenas quando forem estritamente necessarias para o deploy funcionar.
11. Parar o processo e deixar o conteudo final no arquivo `manifest/package-deploy.xml` para validacao manual diretamente no editor.
12. Prosseguir com o commit final e com o deploy somente apos aprovacao explicita do manifesto no arquivo.
13. Executar o deploy na org de destino.
14. Se o deploy falhar, corrigir o problema e tentar novamente.
15. Ao final, registrar:
   - resumo do que foi deployado
   - comandos executados
   - proximos passos para homologacao e producao

## Regra obrigatoria

- Nunca substituir automaticamente o conteudo de `manifest/package-deploy.xml` sem validacao previa.
- Nunca assumir sozinho quais itens devem entrar no `manifest/package-deploy.xml`; a lista deve vir de voce antes da geracao do arquivo e antes do commit final.
- Nunca definir sozinho o nome da branch da tarefa; ele deve ser informado por voce antes do inicio do trabalho.
- Nunca executar retrieve em org de dev nao informada por voce.

## Validacao do manifesto

- Para manifestos pequenos, a validacao pode ser feita por chat.
- Para manifestos grandes, a validacao deve ser feita diretamente no arquivo `manifest/package-deploy.xml`.
- Se necessario, voce pode editar ou colar manualmente a versao final do XML no proprio arquivo.
- O processo so avanca depois da sua aprovacao explicita do conteudo final salvo no arquivo.

## Parametros definidos para este projeto

- Branch de trabalho: informada por voce a cada tarefa, conforme ClickUp
- Org de dev (fonte): informada por voce em cada tarefa
- Org de destino atual: `bluesoft-homolog`
- Org de destino futura: producao, quando voce solicitar explicitamente

## Como reutilizar em outros projetos

Sim. Este documento pode ser criado em outros projetos, desde que os parametros abaixo sejam ajustados antes do uso:

- regra de nomenclatura da branch de trabalho
- alias ou username da org de destino
- caminho do manifesto, se o projeto usar outra estrutura
- criterios adicionais de validacao ou testes

## Fluxo resumido para execucao por agente

1. Receber de voce o nome da branch da tarefa.
2. Atualizar `main`.
3. Criar branch da demanda.
4. Receber de voce a org de dev (fonte) e os itens que entrarao no manifesto.
5. Montar `package-deploy.xml` com escopo minimo.
6. Fazer retrieve da org de dev usando o manifesto.
7. Parar para aprovacao humana no arquivo.
8. Consolidar commit final e executar deploy na org solicitada.
9. Corrigir e repetir se necessario.
10. Entregar resumo final da execucao.