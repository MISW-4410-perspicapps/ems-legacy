create table employeedetails
(
    id           int auto_increment
        primary key,
    employeeId   int          not null,
    role         varchar(255) null,
    divisionName varchar(255) null,
    supervisor   varchar(255) null,
    status       bit          null,
    constraint employee_id_for_employeeDetails
        foreign key (employeeId) references registration (id)
)
    charset = latin1;

INSERT INTO ems_database.employeedetails (id, employeeId, role, divisionName, supervisor, status) VALUES (1, 3, 'Software Engineer', 'Procurment', 'Kate Winslet', true);
INSERT INTO ems_database.employeedetails (id, employeeId, role, divisionName, supervisor, status) VALUES (2, 1, 'Company Administrator', 'Company', 'Gagan Shetty', true);
INSERT INTO ems_database.employeedetails (id, employeeId, role, divisionName, supervisor, status) VALUES (3, 2, 'Company Manager', 'Company', 'Kate Winslet', true);
INSERT INTO ems_database.employeedetails (id, employeeId, role, divisionName, supervisor, status) VALUES (4, 4, 'Sub Manager 1', 'NA', 'Kate Winslet', true);
