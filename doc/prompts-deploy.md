# Prompts para Acionar o Processo de Deploy

Este documento reune os prompts padrao para iniciar, conduzir e aprovar o processo de deploy.

## Prompt minimo para iniciar

Use este formato quando ja souber a branch, a org e os itens do manifesto:

```text
Iniciar processo de deploy

Branch da tarefa: feature/...
Org de dev (fonte): bluesoft-dev
Org de destino: bluesoft-homolog

Itens para o package-deploy.xml:
- item 1
- item 2
- item 3
```

## Prompt completo para iniciar

Use este formato quando quiser incluir regras adicionais para a execucao:

```text
Iniciar processo de deploy

Branch da tarefa: feature/...
Org de dev (fonte): bluesoft-dev
Org de destino: bluesoft-homolog

Itens para o package-deploy.xml:
- item 1
- item 2
- item 3

Observacoes:
- se houver dependencias, me mostre antes
- parar para validacao do XML no arquivo
- nao seguir para commit final sem minha aprovacao
```

## Prompt para iniciar e enviar os itens depois

Use este formato quando a branch ja estiver definida, mas a lista do manifesto ainda sera enviada em seguida:

```text
Iniciar processo de deploy

Branch da tarefa: feature/...
Org de dev (fonte): bluesoft-dev
Org de destino: bluesoft-homolog

Vou te passar os itens do manifesto em seguida.
```

## Prompt para deploy em producao

Use este formato quando a subida nao for para homolog:

```text
Iniciar processo de deploy

Branch da tarefa: feature/...
Org de dev (fonte): bluesoft-dev
Org de destino: bluesoft-prod

Itens para o package-deploy.xml:
- item 1
- item 2

Observacoes:
- tratar este deploy como subida para producao
- parar para validacao final do manifesto no arquivo
- nao seguir para commit final nem deploy sem minha aprovacao explicita
```

## Prompt de aprovacao do manifesto

Depois que o arquivo `manifest/package-deploy.xml` estiver pronto e revisado no editor, responda com:

```text
XML aprovado
```

Se quiser aprovar com observacao, use:

```text
XML aprovado

Observacoes:
- seguir com deploy para homolog
```

## Informacoes minimas obrigatorias

Para eu iniciar o processo sem retrabalho, preciso destes quatro blocos:

1. Branch da tarefa
2. Org de dev (fonte)
3. Org de destino
4. Itens para o `package-deploy.xml`

## Fluxo esperado apos o prompt

1. Eu confirmo branch, org e escopo.
2. Eu atualizo a base e crio a branch informada.
3. Eu monto ou atualizo `manifest/package-deploy.xml`.
4. Eu executo retrieve da org de dev com base no manifesto.
5. Voce revisa o manifesto direto no arquivo.
6. Voce responde `XML aprovado`.
7. Eu sigo para commit final e deploy.

## Reutilizacao em outros projetos

Este documento pode ser copiado para outros projetos. Antes do uso, ajuste:

- org de destino padrao
- regras de nomenclatura da branch
- caminho do manifesto, se for diferente
- observacoes obrigatorias do fluxo local