create table leavedetails
(
    id            int auto_increment
        primary key,
    employeeId    int           not null,
    managerId     int           not null,
    details       varchar(5000) null,
    requestStatus bit           null,
    response      varchar(20)   null,
    date          date          null,
    status        bit           null,
    constraint employeeId_for_leaveDetails
        foreign key (employeeId) references registration (id),
    constraint managerId_for_leaves
        foreign key (managerId) references registration (id)
)
    charset = latin1;

INSERT INTO ems_database.leavedetails (id, employeeId, managerId, details, requestStatus, response, date, status) VALUES (1, 3, 2, 'I need leave tomorrow.', false, 'Accepted', '2017-05-08', true);
INSERT INTO ems_database.leavedetails (id, employeeId, managerId, details, requestStatus, response, date, status) VALUES (2, 9, 6, 'I need leave tomorrow', true, 'NA', '2017-05-11', true);
