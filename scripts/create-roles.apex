// Script para criar hierarquia de papéis (Roles)
UserRole diretoriaGeral = new UserRole(
    DeveloperName = 'Diretoria_Geral',
    Name = 'Diretoria Geral'
);
insert diretoriaGeral;

// Recuperar a role criada para obter o ID
diretoriaGeral = [SELECT Id FROM UserRole WHERE DeveloperName = 'Diretoria_Geral' LIMIT 1];

// Gerência Acelerato (pai: Diretoria Geral)
UserRole gerenciaAcelerato = new UserRole(
    DeveloperName = 'Gerencia_Acelerato',
    Name = 'Gerência Acelerato',
    ParentRoleId = diretoriaGeral.Id
);
insert gerenciaAcelerato;

// Gerência ERP (pai: Diretoria Geral)
UserRole gerenciaERP = new UserRole(
    DeveloperName = 'Gerencia_ERP',
    Name = 'Gerência ERP',
    ParentRoleId = diretoriaGeral.Id
);
insert gerenciaERP;

// Suporte (pai: Diretoria Geral)
UserRole suporte = new UserRole(
    DeveloperName = 'Suporte',
    Name = 'Suporte',
    ParentRoleId = diretoriaGeral.Id
);
insert suporte;

// Recuperar roles para próximo nível
gerenciaAcelerato = [SELECT Id FROM UserRole WHERE DeveloperName = 'Gerencia_Acelerato' LIMIT 1];
gerenciaERP = [SELECT Id FROM UserRole WHERE DeveloperName = 'Gerencia_ERP' LIMIT 1];

// Executivo Acelerato (pai: Gerência Acelerato)
UserRole executivoAcelerato = new UserRole(
    DeveloperName = 'Executivo_Acelerato',
    Name = 'Executivo Acelerato',
    ParentRoleId = gerenciaAcelerato.Id
);
insert executivoAcelerato;

// Executivo ERP (pai: Gerência ERP)
UserRole executivoERP = new UserRole(
    DeveloperName = 'Executivo_ERP',
    Name = 'Executivo ERP',
    ParentRoleId = gerenciaERP.Id
);
insert executivoERP;

// Recuperar roles para último nível
executivoAcelerato = [SELECT Id FROM UserRole WHERE DeveloperName = 'Executivo_Acelerato' LIMIT 1];
executivoERP = [SELECT Id FROM UserRole WHERE DeveloperName = 'Executivo_ERP' LIMIT 1];

// SDRs Acelerato (pai: Executivo Acelerato)
UserRole sdrsAcelerato = new UserRole(
    DeveloperName = 'SDRs_Acelerato',
    Name = 'SDRs Acelerato',
    ParentRoleId = executivoAcelerato.Id
);
insert sdrsAcelerato;

// SDRs ERP (pai: Executivo ERP)
UserRole sdrsERP = new UserRole(
    DeveloperName = 'SDRs_ERP',
    Name = 'SDRs ERP',
    ParentRoleId = executivoERP.Id
);
insert sdrsERP;

System.debug('✅ Hierarquia de papéis (Roles) criada com sucesso!');
System.debug('Roles criadas:');
System.debug('1. Diretoria Geral');
System.debug('2. Gerência Acelerato (pai: Diretoria Geral)');
System.debug('3. Gerência ERP (pai: Diretoria Geral)');
System.debug('4. Suporte (pai: Diretoria Geral)');
System.debug('5. Executivo Acelerato (pai: Gerência Acelerato)');
System.debug('6. Executivo ERP (pai: Gerência ERP)');
System.debug('7. SDRs Acelerato (pai: Executivo Acelerato)');
System.debug('8. SDRs ERP (pai: Executivo ERP)');
