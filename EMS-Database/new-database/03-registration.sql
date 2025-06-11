create table registration
(
    id             int auto_increment
        primary key,
    firstname      varchar(255) null,
    lastname       varchar(255) null,
    email          varchar(255) null,
    address        varchar(255) null,
    phone          varchar(20)  null,
    username       varchar(255) null,
    password       varchar(255) null,
    role           int          not null,
    managerstatus  bit          null,
    managerId      int          null,
    activitystatus bit          null,
    date           date         null,
    constraint role_for_registration
        foreign key (role) references roles (id)
)
    charset = latin1;

INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (1, 'Gagan', 'Shetty', 'gsolur@albany.edu', '489 washington avenue', '9035245991', 'admin', 'admin', 1, false, 1, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (2, 'Kate', 'Winslet', 'wkate@albany.edu', '523 North Allen, Albany', '9078734456', 'KW001', 'kw001', 2, true, 2, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (3, 'Johny', 'Depp', 'jsparrow@albany.edu', '583 western avenue', '9876545678', 'JD002', 'jd002', 3, false, 2, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (4, 'Jai', 'Kumar', 'jai@albany.edu', '235 clifton park', '9878656789', 'JK005', 'jk005', 2, true, 2, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (5, 'Ganapati', 'Naik', 'naik@ait.com', '111 clifton park', '9897655678', 'GN003', 'gn003', 3, false, 4, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (6, 'vishu', 'Murundi', 'vishu@albany.edu', '94 North Allen street, Albany', '9878656789', 'VM004', 'vm004', 2, true, 2, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (7, 'Tejus', 'Gowda', 'tejus@yahoo.com', '90 kent steert', '9078734456', 'TG006', 'tg006', 3, false, 6, true, '2017-05-08');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (8, 'Achala', 'Rao', 'arao@gmail.com', '750 Los Angles', '9035245991', 'ML007', 'ml007', 3, false, 0, false, '2017-05-10');
INSERT INTO ems_database.registration (id, firstname, lastname, email, address, phone, username, password, role, managerstatus, managerId, activitystatus, date) VALUES (9, 'Harish', 'Kumar', 'sharish@albany.edu', '94 North Allen street, Albany', '9878656789', 'e1234', '1234', 3, false, 6, true, '2017-05-11');
