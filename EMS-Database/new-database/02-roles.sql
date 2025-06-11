create table roles
(
    id       int auto_increment
        primary key,
    rolename varchar(20) null,
    status   bit         null
)
    charset = latin1;

INSERT INTO ems_database.roles (id, rolename, status) VALUES (1, 'Admin', true);
INSERT INTO ems_database.roles (id, rolename, status) VALUES (2, 'Manager', true);
INSERT INTO ems_database.roles (id, rolename, status) VALUES (3, 'Employee', true);
INSERT INTO ems_database.roles (id, rolename, status) VALUES (4, 'NA', false);
