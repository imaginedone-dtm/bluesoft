// Script para criar Permission Sets com permissões específicas

// ==========================================
// 1. PS_Diretoria (Bluesoft - Diretoria)
// ==========================================
PermissionSet psDiretoria = new PermissionSet(
    Name = 'PS_Diretoria',
    Label = 'Bluesoft - Diretoria',
    Description = 'Permission Set para Diretoria - Read em Lead, Account, Contact, Opportunity'
);
insert psDiretoria;

psDiretoria = [SELECT Id FROM PermissionSet WHERE Name = 'PS_Diretoria' LIMIT 1];

List<ObjectPermissions> diretoriaPerms = new List<ObjectPermissions>();
diretoriaPerms.add(new ObjectPermissions(
    ParentId = psDiretoria.Id,
    SObjectType = 'Lead',
    PermissionsRead = true
));
diretoriaPerms.add(new ObjectPermissions(
    ParentId = psDiretoria.Id,
    SObjectType = 'Account',
    PermissionsRead = true
));
diretoriaPerms.add(new ObjectPermissions(
    ParentId = psDiretoria.Id,
    SObjectType = 'Contact',
    PermissionsRead = true
));
diretoriaPerms.add(new ObjectPermissions(
    ParentId = psDiretoria.Id,
    SObjectType = 'Opportunity',
    PermissionsRead = true
));
insert diretoriaPerms;

// ==========================================
// 2. PS_Gerencia (Bluesoft - Gerência)
// ==========================================
PermissionSet psGerencia = new PermissionSet(
    Name = 'PS_Gerencia',
    Label = 'Bluesoft - Gerência',
    Description = 'Permission Set para Gerência - CRUD em Lead, Account, Contact, Opportunity'
);
insert psGerencia;

psGerencia = [SELECT Id FROM PermissionSet WHERE Name = 'PS_Gerencia' LIMIT 1];

List<ObjectPermissions> gerenciaPerms = new List<ObjectPermissions>();
for (String objectName : new List<String>{ 'Lead', 'Account', 'Contact', 'Opportunity' }) {
    gerenciaPerms.add(new ObjectPermissions(
        ParentId = psGerencia.Id,
        SObjectType = objectName,
        PermissionsCreate = true,
        PermissionsRead = true,
        PermissionsEdit = true,
        PermissionsDelete = true
    ));
}
insert gerenciaPerms;

// ==========================================
// 3. PS_Executivo (Bluesoft - Executivo de Vendas)
// ==========================================
PermissionSet psExecutivo = new PermissionSet(
    Name = 'PS_Executivo',
    Label = 'Bluesoft - Executivo de Vendas',
    Description = 'Permission Set para Executivo - Create, Read, Edit em Lead, Account, Contact, Opportunity'
);
insert psExecutivo;

psExecutivo = [SELECT Id FROM PermissionSet WHERE Name = 'PS_Executivo' LIMIT 1];

List<ObjectPermissions> executivoPerms = new List<ObjectPermissions>();
for (String objectName : new List<String>{ 'Lead', 'Account', 'Contact', 'Opportunity' }) {
    executivoPerms.add(new ObjectPermissions(
        ParentId = psExecutivo.Id,
        SObjectType = objectName,
        PermissionsCreate = true,
        PermissionsRead = true,
        PermissionsEdit = true
    ));
}
insert executivoPerms;

// ==========================================
// 4. PS_SDR (Bluesoft - SDR)
// ==========================================
PermissionSet psSDR = new PermissionSet(
    Name = 'PS_SDR',
    Label = 'Bluesoft - SDR',
    Description = 'Permission Set para SDR - Create, Read, Edit em Lead; Read em Account, Contact, Opportunity'
);
insert psSDR;

psSDR = [SELECT Id FROM PermissionSet WHERE Name = 'PS_SDR' LIMIT 1];

List<ObjectPermissions> sdrPerms = new List<ObjectPermissions>();
// Lead: Create, Read, Edit
sdrPerms.add(new ObjectPermissions(
    ParentId = psSDR.Id,
    SObjectType = 'Lead',
    PermissionsCreate = true,
    PermissionsRead = true,
    PermissionsEdit = true
));
// Account, Contact, Opportunity: Read
sdrPerms.add(new ObjectPermissions(
    ParentId = psSDR.Id,
    SObjectType = 'Account',
    PermissionsRead = true
));
sdrPerms.add(new ObjectPermissions(
    ParentId = psSDR.Id,
    SObjectType = 'Contact',
    PermissionsRead = true
));
sdrPerms.add(new ObjectPermissions(
    ParentId = psSDR.Id,
    SObjectType = 'Opportunity',
    PermissionsRead = true
));
insert sdrPerms;

// ==========================================
// 5. PS_Suporte (Bluesoft - Suporte)
// ==========================================
PermissionSet psSuporte = new PermissionSet(
    Name = 'PS_Suporte',
    Label = 'Bluesoft - Suporte',
    Description = 'Permission Set para Suporte - Read, Edit em Account, Contact; Read em Opportunity'
);
insert psSuporte;

psSuporte = [SELECT Id FROM PermissionSet WHERE Name = 'PS_Suporte' LIMIT 1];

List<ObjectPermissions> suportePerms = new List<ObjectPermissions>();
// Account, Contact: Read, Edit
suportePerms.add(new ObjectPermissions(
    ParentId = psSuporte.Id,
    SObjectType = 'Account',
    PermissionsRead = true,
    PermissionsEdit = true
));
suportePerms.add(new ObjectPermissions(
    ParentId = psSuporte.Id,
    SObjectType = 'Contact',
    PermissionsRead = true,
    PermissionsEdit = true
));
// Opportunity: Read
suportePerms.add(new ObjectPermissions(
    ParentId = psSuporte.Id,
    SObjectType = 'Opportunity',
    PermissionsRead = true
));
insert suportePerms;

System.debug('✅ Permission Sets criados com sucesso!');
System.debug('Permission Sets criados:');
System.debug('1. PS_Diretoria - Bluesoft - Diretoria');
System.debug('2. PS_Gerencia - Bluesoft - Gerência');
System.debug('3. PS_Executivo - Bluesoft - Executivo de Vendas');
System.debug('4. PS_SDR - Bluesoft - SDR');
System.debug('5. PS_Suporte - Bluesoft - Suporte');
