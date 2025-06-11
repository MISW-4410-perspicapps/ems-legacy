create table ate
(
    id          int auto_increment
        primary key,
    employeeId  int null,
    managerId   int null,
    directoryId int null,
    ateStatus   bit null,
    status      bit null
)
    charset = latin1;

INSERT INTO ems_database.ate (id, employeeId, managerId, directoryId, ateStatus, status) VALUES (1, 7, 4, 5, true, true);
INSERT INTO ems_database.ate (id, employeeId, managerId, directoryId, ateStatus, status) VALUES (2, 5, 6, 12, true, true);
