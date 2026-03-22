create table school.Students
(
    student_id serial primary key,
    name       varchar(100) not null,
    dob        date         not null
);
create table school.Courses
(
    course_id   serial primary key,
    course_name varchar(100) not null,
    credits     int          not null check (credits > 0)
);
create table school.Enrollments
(
    enrollment_id serial primary key,
    student_id    int,
    course_id     int,
    grade         varchar(2) check (grade in ('A', 'B', 'C', 'D', 'F')),
    foreign key (student_id) references school.Students (student_id),
    foreign key (course_id) references school.Courses (course_id)
);