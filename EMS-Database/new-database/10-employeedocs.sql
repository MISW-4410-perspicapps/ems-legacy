create table employeedocs
(
    id             int auto_increment
        primary key,
    docName        varchar(255)  null,
    docFile        longblob      null,
    docType        varchar(255)  null,
    comment        varchar(1000) null,
    registrationId int           not null,
    directoryId    int           not null,
    date           date          null,
    status         bit           null,
    constraint directory_id_for_employeeDocs
        foreign key (directoryId) references directorydetails (id),
    constraint registrationId_for_documents
        foreign key (registrationId) references registration (id)
)
    charset = latin1;

INSERT INTO ems_database.employeedocs (id, docName, docFile, docType, comment, registrationId, directoryId, date, status) VALUES (1, 'Reports', '' , 'image/png', 'RCB captain.', 5, 2, '2017-05-10', true);
INSERT INTO ems_database.employeedocs (id, docName, docFile, docType, comment, registrationId, directoryId, date, status) VALUES (2, 'Imagw', '', 'image/png', 'Image', 9, 4, '2017-05-11', true);
INSERT INTO ems_database.employeedocs (id, docName, docFile, docType, comment, registrationId, directoryId, date, status) VALUES (3, 'Prueba','', 'image/png', 'Prueba de imagen', 3, 1, '2025-06-10', true);
