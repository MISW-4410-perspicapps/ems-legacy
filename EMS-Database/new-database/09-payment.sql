create table payment
(
    id             int auto_increment
        primary key,
    registrationId int          not null,
    accountNum     varchar(255) null,
    salary         double       null,
    bonus          double       null,
    total          double       null,
    status         bit          null,
    constraint registration_id_for_payment
        foreign key (registrationId) references registration (id)
)
    charset = latin1;

INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (1, 1, 'NA', 100000, 0, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (2, 2, 'NA', 100000, 0, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (3, 3, 'NA', 100000, 1000, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (4, 4, 'NA', 100000, 0, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (5, 5, 'NA', 100000, 0, 8333.33333333333, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (6, 6, 'NA', 100000, 0, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (7, 7, 'NA', 100000, 0, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (8, 8, 'NA', 100000, 0, 0, true);
INSERT INTO ems_database.payment (id, registrationId, accountNum, salary, bonus, total, status) VALUES (9, 9, 'NA', 100000, 0, 0, true);
