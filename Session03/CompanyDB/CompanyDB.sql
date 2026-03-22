create table company.Departments
(
    department_id   serial primary key,
    department_name varchar(100) not null unique
);
create table company.Employees
(
    emp_id        serial primary key,
    name          varchar(100) not null,
    dob           date         not null,
    department_id int,
    foreign key (department_id) references company.Departments (department_id)
);
create table company.Projects
(
    project_id   serial primary key,
    project_name varchar(100) not null,
    start_date   date         not null,
    end_date     date,
    check (end_date is null or end_date >= start_date)
);
create table company.EmployeeProjects
(
    emp_id     int,
    project_id int,
    primary key (emp_id, project_id),
    foreign key (emp_id) references company.Employees (emp_id),
    foreign key (project_id) references company.Projects (project_id)
);