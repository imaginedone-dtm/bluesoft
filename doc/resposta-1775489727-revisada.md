# Plano de Deploy Revisado - BluesoftDEV para Homologacao

## Objetivo
Este plano revisa a estrategia anterior para reduzir risco de falha e sobrescrita em homologacao.

Principios desta revisao:
- Deploy por manifest por onda (escopo minimo necessario)
- Evitar deploy por pasta inteira quando houver metadado sensivel
- Separar metadados de alto risco (Profiles e Settings)
- Definir gates de entrada e saida por onda
- Definir rollback funcional rapido

---

## Escopo e Premissas
- Origem: force-app do projeto local
- Destino: org de homologacao
- Sem execucao automatica neste documento
- In_App_Checklist_Settings__c permanece fora do escopo inicial
- Settings ficam fora do primeiro ciclo, salvo aprovacao explicita

---

## Estrategia de Ondas (Revisada)

### Onda 0 - Preparacao e Baseline (obrigatoria)
Objetivo: validar pre-condicoes e reduzir incerteza.

Entradas:
- Alias da org homolog definido
- Time alinhado sobre janela de deploy

Saidas esperadas:
- Inventario do que ja existe em homolog (roles, RT, campos criticos)
- Decisao formal sobre Profiles e Settings no ciclo atual
- Lista de manifests por onda aprovada

Gate para avancar:
- Sem bloqueios de dependencia conhecidos
- Escopo da Onda 1 aprovado

---

### Onda 1 - Fundacao (baixo risco, sem dependencias funcionais fortes)
Componentes:
- Roles (8)
- GlobalValueSet Tags
- StandardValueSets (OpportunityStage, LeadStatus, LeadSource, Industry, AccountType, AccountRating)
- ContentAsset bluesoft_logo_600x120

Revisoes importantes:
- Roles: confirmar hierarquia e nomes em homolog para evitar conflito
- StandardValueSets: validar impacto em dados existentes (ordem e valores inativos)

Gate de saida:
- Roles e value sets disponiveis sem erro
- Sem regressao visivel em picklists padrao

---

### Onda 2 - Modelo de Dados (escopo seletivo)
Componentes (por tipo, nao por pasta inteira de objeto):
- CustomField de Account, Contact, Lead, Opportunity
- ValidationRule (2)
- BusinessProcess de Opportunity (2)
- RecordType de Opportunity (2)

Fora do escopo desta onda:
- Objeto In_App_Checklist_Settings__c
- Metadados de objeto nao necessarios ao go-live

Revisoes importantes:
- Preferir manifests por tipo e membro explicito
- Nao usar deploy amplo de objects/Account, objects/Lead, etc., para evitar trazer listViews/fieldSets/compactLayouts sem necessidade

Gate de saida:
- Campos criados/atualizados conforme lista
- Validation Rules ativas e sem falso positivo
- Record Types ativos e associados ao Business Process correto

---

### Onda 3 - Experiencia (UI e navegacao em camadas)
Fase 3A (core):
- LWC tagsBadge
- Path Assistants (Acelerato, ERP_Bluesoft)
- Layouts diretamente ligados aos 2 RT de Opportunity
- Flexipages custom criticas (Conta, Contato, Lead, Oportunidade Acelerato, Oportunidade ERP)

Fase 3B (expansao controlada):
- Demais layouts
- Utility Bars
- Quick Actions padrao
- Reports

Revisoes importantes:
- Utility Bars somente para apps presentes em homolog
- Quick Actions padrao podem entrar depois da validacao do core

Gate de saida 3A:
- Path correto por RT
- Pagina de registro critica carregando sem erro
- tagsBadge renderizando em Account com Tags

Gate de saida 3B:
- Sem regressao de navegacao em apps padrao
- Acoes rapidas principais funcionando

---

### Onda 4 - Seguranca (prioridade em Permission Sets)
Fase 4A (recomendada):
- Permission Sets: PS_Diretoria, PS_Executivo, PS_Gerencia, PS_SDR, PS_Suporte

Fase 4B (condicional):
- Profiles (somente se aprovado): priorizar Admin e Usuario Bluesoft

Revisoes importantes:
- Profiles sao alto risco de sobrescrita de FLS/visibilidade
- Se homolog ja tiver configuracoes consolidadas, manter Profiles fora do ciclo

Gate de saida 4A:
- Permission Sets atribuiveis e com visibilidade esperada

Gate de saida 4B:
- Validacao dirigida de FLS e visibilidade por perfil
- Sem perda de acesso em perfis existentes

---

### Onda 5 - Settings (opcional e tardia)
Componentes:
- Settings (128)

Recomendacao:
- Nao incluir no primeiro deploy de homolog
- Aplicar somente settings necessarios, de forma seletiva, apos validacao funcional

Gate de saida:
- Aprovacao explicita do owner funcional
- Evidencia de que nao ha sobrescrita indesejada

---

## Politica de Manifest por Onda
Para cada onda, criar package xml dedicado com:
- Apenas tipos e membros estritamente necessarios
- Exclusao explicita de itens de risco fora do escopo
- Versionamento no repositorio para rastreabilidade

Beneficios:
- Menos falhas por dependencia lateral
- Menor superficie de sobrescrita
- Melhor auditoria do que entrou em cada etapa

---

## Checklist de Validacao Pos-Deploy (Revisado)

Validacoes tecnicas minimas:
- Custom Fields esperados nos 4 objetos
- Record Types de Opportunity ativos
- PathAssistants Acelerato e ERP_Bluesoft
- Permission Sets PS_* disponiveis
- Roles Bluesoft presentes

Validacoes funcionais minimas:
- Criacao de Opportunity com RT Acelerato_Vendas e exibicao do path correto
- Criacao de Opportunity com RT ERP_Vendas e exibicao do path correto
- Validacao de CNPJ bloqueando caracteres nao numericos em Account e Lead
- Layout por RT aplicado corretamente
- Usuario teste com Permission Set enxergando campos esperados

Critico:
- Executar validacao de regressao rapida em navegacao principal dos apps

---

## Rollback Funcional (Plano Rapido)
Este plano nao depende de rollback tecnico completo; prioriza restauracao de operacao.

Acoes de contingencia por impacto:
1. Desatribuir temporariamente Flexipage custom do app/objeto impactado
2. Desabilitar uso de Record Type recem publicado (se causar bloqueio)
3. Reverter atribuicoes de Permission Set recem aplicadas
4. Postergar Onda seguinte ate correcoes

Criterio de acionamento:
- Erro bloqueante em criacao/edicao de registro
- Perda de acesso para perfil critico
- Queda de fluxo comercial principal

---

## Matriz de Risco (Revisada)
- Alto: Profiles, Settings, deploy amplo de objects por pasta
- Medio: Utility Bars, Quick Actions padrao em massa, Roles com hierarquia existente
- Baixo: LWC isolado, Reports, ContentAsset

Mitigacao chave:
- Manifest seletivo por onda
- Gates de aprovacao
- Seguranca em duas fases (Permission Sets antes de Profiles)

---

## Criterios de Pronto para Homolog
O deploy revisado e considerado pronto quando:
- Ondas 1, 2, 3A e 4A concluidas sem bloqueio
- Validacoes funcionais minimas aprovadas
- Sem regressao critica em acesso e navegacao
- Decisao formal registrada para 3B, 4B e 5

---

## Diferencas em relacao ao plano anterior
- Troca de deploy por pasta para deploy por manifest por onda
- Separacao de UI em core (3A) e expansao (3B)
- Separacao de seguranca em Permission Sets (4A) e Profiles (4B)
- Settings movido para etapa tardia e opcional
- Inclusao de rollback funcional e gates formais
