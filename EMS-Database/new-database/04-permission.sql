create table permission
(
    id         int auto_increment
        primary key,
    permission varchar(20) null,
    status     bit         null
)
    charset = latin1;

INSERT INTO ems_database.permission (id, permission, status) VALUES (1, 'Public', true);
INSERT INTO ems_database.permission (id, permission, status) VALUES (2, 'Private', true);
INSERT INTO ems_database.permission (id, permission, status) VALUES (3, 'Protect', true);
INSERT INTO ems_database.permission (id, permission, status) VALUES (4, 'Default', true);
