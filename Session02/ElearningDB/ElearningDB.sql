create table elearning.Students
(
    student_id serial primary key,
    first_name varchar(50)         not null,
    last_name  varchar(50)         not null,
    email      varchar(100) unique not null
);
create table elearning.Instructors
(
    instructor_id serial primary key,
    first_name    varchar(50)         not null,
    last_name     varchar(50)         not null,
    email         varchar(100) unique not null
);
create table elearning.Courses
(
    course_id     serial primary key,
    course_name   varchar(100) not null,
    instructor_id int,
    foreign key (instructor_id) references elearning.Instructors (instructor_id)
);
create table elearning.Enrollments
(
    enrollment_id serial primary key,
    student_id    int,
    course_id     int,
    enroll_date   date not null default current_date,
    foreign key (student_id) references elearning.Students (student_id),
    foreign key (course_id) references elearning.Courses (course_id)
);
create table elearning.Assignments
(
    assignment_id serial primary key,
    course_id     int,
    title         varchar(100) not null,
    due_date      date         not null,
    foreign key (course_id) references elearning.Courses (course_id)
);
create table elearning.Submissions
(
    submission_id   serial primary key,
    assignment_id   int,
    student_id      int,
    submission_date date not null,
    grade           numeric(5, 2) check (grade >= 0 and grade <= 100),
    foreign key (assignment_id) references elearning.Assignments (assignment_id),
    foreign key (student_id) references elearning.Students (student_id)
);