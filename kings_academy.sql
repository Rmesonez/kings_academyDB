CREATE DATABASE kings_academy;

CREATE TABLE "users" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "firstname" varchar(20) NOT NULL,
  "lastname" varchar(20) NOT NULL,
  "email" varchar(20) NOT NULL,
  "dob" date NOT NULL,
  "password" varchar(10) NOT NULL,
  "role_id" integer NOT NULL
);

CREATE TABLE "courses" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" varchar(20) NOT NULL,
  "description" text NOT NULL,
  "teacher_id" integer NOT NULL,
  "category_id" integer NOT NULL,
  "level_id" int NOT NULL
);

CREATE TABLE "courses_videos" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "video" varchar(30) NOT NULL,
  "url" varchar(20) NOT NULL,
  "course_id" integer NOT NULL
);

CREATE TABLE "roles" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "role" varchar(15) NOT NULL
);

CREATE TABLE "categories" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "category" varchar(20) NOT NULL
);

CREATE TABLE "levels" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "level" varchar(20) NOT NULL
);

CREATE TABLE "courses_users" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" integer NOT NULL,
  "course_id" integer NOT NULL
);

ALTER TABLE "courses_users" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "courses_users" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("teacher_id") REFERENCES "role" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("level_id") REFERENCES "levels" ("id");

ALTER TABLE "courses_videos" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

-- insertions

INSERT INTO levels (level) VALUES ('Beginner'), ('Intermediate'), ('Advanced');

INSERT INTO categories (category) VALUES ('FrontEnd'), ('BackEnd');

INSERT INTO roles (role) VALUES ('Student'), ('Teacher'), ('Admin');

INSERT INTO users (firstname, lastname, email, dob, password, role_id) VALUES ('Reinaldo', 'Mesonez', 'rey@gmail.com', '1987-03-01', '12345', 1),
('Jose', 'Mesonez', 'jose@gmail.com', '1941-06-02', '12345', 1), ('Ian', 'Rosas', 'ian@gmail.com' , '1991-03-02', '12345', 2)
,('Alejandra', 'Olazagasti', 'ale@gmail.com', '1990-02-02', '12345', 2), ('Gumercindo', 'Gutierrez', 'gumer@gmail.com', '1970-08-06', '12345', 3);

INSERT INTO courses (title, description, teacher_id, category_id, level_id) VALUES ('HTML Course', 'Design the Frame', 4, 1, 1),
('Css Course', 'Web Styles', 4, 1, 1), ('NodeJs Course', 'Api Creation', 3, 2, 2), ('MongoDB Course', 'No relationals DB', 3, 2, 2),
('Phyton Course', 'Phyton Language', 3, 2, 3);


INSERT INTO courses_videos (video, url, course_id) VALUES 
('Learn HTML', 'www.html.com', 1),('Learn CSS', 'www.css.com', 2), ('Learn NodeJs', 'www.node.com', 3), 
('Learn Mongo DB', 'www.mongo.com', 4),
('Learn Phyton', 'www.phyton.com', 5);

INSERT INTO courses_users (user_id, course_id) VALUES (1, 1), (1, 3), (2, 2), (2, 4);


-- consults

SELECT id, firstname, lastname FROM users;


SELECT users.id, users.firstname, users.lastname, roles.role
FROM users 
JOIN roles ON users.role_id=roles.id;

SELECT courses.id, courses.title, categories.category 
FROM courses 
JOIN categories ON courses.category_id=categories.id;

SELECT courses.id, courses.title, levels.level 
FROM courses 
JOIN levels ON courses.level_id=levels.id;

SELECT courses.id, courses.title, levels.level, categories.category FROM courses 
JOIN levels ON courses.level_id=levels.id 
JOIN categories ON courses.category_id=categories.id;

SELECT courses.id, courses.title, levels.level, categories.category, users.firstname, users.lastname 
FROM courses 
JOIN levels ON courses.level_id=levels.id 
JOIN categories ON courses.category_id=categories.id 
JOIN users ON courses.teacher_id=users.id;

SELECT courses.id, courses.title, levels.level, categories.category, users.firstname, users.lastname 
FROM courses 
JOIN levels ON courses.level_id=levels.id 
JOIN categories ON courses.category_id=categories.id 
JOIN users ON courses.teacher_id=users.id 
WHERE courses.id=1;

SELECT courses.id, courses.title, levels.level, categories.category, users.firstname, users.lastname 
FROM courses 
JOIN levels ON courses.level_id=levels.id 
JOIN categories ON courses.category_id=categories.id 
JOIN users ON courses.teacher_id=users.id 
WHERE courses.id=2;

SELECT courses.title, courses.description, courses_videos.video, courses_videos.url 
FROM courses
JOIN courses_videos ON courses.id=courses_videos.course_id 
WHERE courses.id=1;

SELECT courses.id, courses.title, courses.description, courses_videos.video, courses_videos.url, categories.category
FROM courses
JOIN courses_videos ON courses.id=courses_videos.course_id
JOIN categories ON courses.category_id=categories.id;

SELECT courses.id, courses.title, courses.description, courses_videos.video, courses_videos.url, categories.category, teacher.firstname, teacher.lastname, teacher_role.role
FROM courses
JOIN courses_videos ON courses.id=courses_videos.course_id
JOIN categories ON courses.category_id=categories.id
JOIN users AS teacher ON courses.teacher_id=teacher.id
JOIN roles AS teacher_role ON teacher.role_id=teacher_role.id;

SELECT courses.id, courses.title, courses.description, levels.level, courses_videos.video, courses_videos.url, categories.category, teacher.firstname, teacher.lastname, teacher_role.role
FROM courses
JOIN courses_videos ON courses.id=courses_videos.course_id
JOIN categories ON courses.category_id=categories.id
JOIN users AS teacher ON courses.teacher_id=teacher.id
JOIN roles AS teacher_role ON teacher.role_id=teacher_role.id
JOIN levels ON courses.level_id=levels.id;

SELECT users.id, users.firstname, users.lastname, courses.title FROM users JOIN courses_users ON users.id=courses_users.user_id JOIN courses ON courses_users.course_id=courses.id WHERE users.id=1;

SELECT users.id, users.firstname, users.lastname, courses.title, courses.teacher_id FROM users JOIN courses_users ON users.id=courses_users.user_id JOIN courses ON courses_users.course_id=courses.id WHERE users.id=1;

SELECT users.id, users.firstname, users.lastname, courses.title, courses_videos.video, courses_videos.url FROM users JOIN courses_users ON users.id=courses_users.user_id JOIN courses ON courses_users.course_id=courses.id JOIN courses_videos ON courses.id=courses_videos.course_id WHERE users.id=1;

SELECT users.id, users.firstname, users.lastname, courses.title, courses_videos.video, courses_videos.url, levels.level, categories.category FROM users JOIN courses_users ON users.id=courses_users.user_id JOIN courses ON courses_users.course_id=courses.id JOIN courses_videos ON courses.id=courses_videos.course_id JOIN levels ON courses.level_id=levels.id JOIN categories ON courses.category_id=categories.id
WHERE users.id=1;

SELECT users.id, users.firstname, users.lastname, roles.role, courses.title, courses.description, courses_videos.video, courses_videos.url, levels.level, categories.category, teacher.firstname, teacher.lastname, teacher_role.role
FROM users 
JOIN courses_users ON users.id=courses_users.user_id 
JOIN courses ON courses_users.course_id=courses.id 
JOIN courses_videos ON courses.id=courses_videos.course_id 
JOIN levels ON courses.level_id=levels.id 
JOIN categories ON courses.category_id=categories.id 
JOIN roles ON users.role_id=roles.id
JOIN users AS teacher ON courses.teacher_id=teacher.id
JOIN roles AS teacher_role ON teacher.role_id=teacher_role.id
WHERE users.id=1;

SELECT users.id, users.firstname, users.lastname, roles.role, courses.title, courses.description, courses_videos.video, courses_videos.url, levels.level, categories.category, teacher.firstname, teacher.lastname, teacher_role.role
FROM users 
JOIN courses_users ON users.id=courses_users.user_id 
JOIN courses ON courses_users.course_id=courses.id 
JOIN courses_videos ON courses.id=courses_videos.course_id 
JOIN levels ON courses.level_id=levels.id 
JOIN categories ON courses.category_id=categories.id 
JOIN roles ON users.role_id=roles.id
JOIN users AS teacher ON courses.teacher_id=teacher.id
JOIN roles AS teacher_role ON teacher.role_id=teacher_role.id
WHERE users.id=2;


SELECT courses.id, courses.title, courses.description, levels.level, courses_videos.video, courses_videos.url, categories.category, teacher.firstname, teacher.lastname, teacher_role.role,
users.id, users.firstname, users.lastname, roles.role
FROM courses
JOIN courses_videos ON courses.id=courses_videos.course_id
JOIN categories ON courses.category_id=categories.id
JOIN users AS teacher ON courses.teacher_id=teacher.id
JOIN roles AS teacher_role ON teacher.role_id=teacher_role.id
JOIN levels ON courses.level_id=levels.id
JOIN courses_users ON courses.id=courses_users.course_id
JOIN users ON courses_users.user_id=users.id
JOIN roles ON users.role_id=roles.id
WHERE users.id=1;

SELECT courses.id, courses.title, courses.description, levels.level, courses_videos.video, courses_videos.url, categories.category, teacher.firstname, teacher.lastname, teacher_role.role,
users.id, users.firstname, users.lastname, roles.role
FROM courses
JOIN courses_videos ON courses.id=courses_videos.course_id
JOIN categories ON courses.category_id=categories.id
JOIN users AS teacher ON courses.teacher_id=teacher.id
JOIN roles AS teacher_role ON teacher.role_id=teacher_role.id
JOIN levels ON courses.level_id=levels.id
JOIN courses_users ON courses.id=courses_users.course_id
JOIN users ON courses_users.user_id=users.id
JOIN roles ON users.role_id=roles.id;



