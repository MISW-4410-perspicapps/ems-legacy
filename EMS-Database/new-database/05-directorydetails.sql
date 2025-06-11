create table directorydetails
(
    id            int auto_increment
        primary key,
    directoryName varchar(500)  null,
    managerId     int           not null,
    permissionId  int           not null,
    accessibleIds varchar(1000) null,
    status        bit           null,
    ateIds        varchar(1000) null,
    constraint managerId_for_directory
        foreign key (managerId) references registration (id),
    constraint permissionId_for_directory
        foreign key (permissionId) references permission (id)
)
    charset = latin1;

INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (1, 'DIR-2', 2, 4, '2,3,4,6,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (2, 'KW-Public', 2, 3, '2,3,4,6,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (3, 'DIR-4', 4, 4, '4,2,5,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (4, 'DIR-6', 6, 4, '6,2,7,9,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (5, 'JK-Prot', 4, 3, '4,2,5,', true, '7,');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (6, 'JK-Public', 4, 1, 'ALL,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (7, 'KW-Protect', 2, 3, '2,3,4,6,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (8, 'KW-Protect2', 2, 3, '2,3,4,6,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (9, 'VM-Priv', 6, 2, '6,2,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (10, 'KW-Public2', 2, 1, 'ALL,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (11, 'VM-Pub', 6, 1, 'ALL,', true, 'NA');
INSERT INTO ems_database.directorydetails (id, directoryName, managerId, permissionId, accessibleIds, status, ateIds) VALUES (12, 'VM-Prot', 6, 3, '6,2,7,9,', true, '5,');
