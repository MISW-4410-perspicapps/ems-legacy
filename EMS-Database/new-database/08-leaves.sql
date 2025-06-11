create table leaves
(
    id             int auto_increment
        primary key,
    leaveNum       int null,
    registrationId int not null,
    status         bit null,
    constraint registration_id_for_leaves
        foreign key (registrationId) references registration (id)
)
    charset = latin1;

INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (1, 4, 1, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (2, 4, 2, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (3, 3, 3, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (4, 4, 4, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (5, 4, 5, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (6, 4, 6, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (7, 4, 7, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (8, 4, 8, true);
INSERT INTO ems_database.leaves (id, leaveNum, registrationId, status) VALUES (9, 4, 9, true);
