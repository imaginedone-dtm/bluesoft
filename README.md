# Bluesoft Salesforce Project

Projeto Salesforce Bluesoft desenvolvido com Salesforce DX.

## Estrutura do Projeto

```
bluesoft/
├── force-app/          # Código-fonte Salesforce
├── config/             # Configurações
├── scripts/            # Scripts utilitários
├── manifest/           # Manifests para deploy
└── package.json        # Dependências npm
```

## Requisitos

- Node.js e npm
- Salesforce CLI (sf ou sfdx)
- Uma organização Salesforce ou Salesforce Developer Edition

## Configuração

1. Instale as dependências:
```bash
npm install
```

2. Autentique com sua organização Salesforce:
```bash
sf org login web
```

## Comandos Úteis

- `npm run lint` - Lint dos arquivos LWC e Aura
- `npm run test` - Executa testes unitários
- `npm run prettier` - Formata o código
- `sf project deploy start` - Deploy do código para a organização

## Estrutura de Diretórios

- `force-app/main/default/` - Metadados Salesforce
- `config/` - Definições de scratch org
- `scripts/` - Scripts diversos

## Referências

- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/)
- [LWC Documentation](https://lwc.dev/)
