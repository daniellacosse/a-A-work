CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  q_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (q_id) REFERENCES questions(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  q_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (q_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  q_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (q_id) REFERENCES questions(id)
);

CREATE TABLE tags (
  id INTEGER PRIMARY KEY,
  tag VARCHAR(255) NOT NULL
);

CREATE TABLE question_tags (
  id INTEGER PRIMARY KEY,
  q_id INTEGER NOT NULL,
  t_id INTEGER NOT NULL,
  FOREIGN KEY (q_id) REFERENCES questions(id),
  FOREIGN KEY (t_id) REFERENCES tags(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Daniel', 'LaCosse'),
  ('Jordan', 'Nolan'),
  ('Jonathan', 'Tamboer'),
  ('Jorge', 'Rodgriguez'),
  ('Buddy', 'Lamers'),
  ('Greg', 'Meyer'),
  ('Tommy', 'Duek'),
  ('Sam', 'Sweeney');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('SQL', 'What is SQL?', (SELECT id FROM users WHERE lname = 'Nolan')),
  ('Ruby', 'What is Ruby?', (SELECT id FROM users WHERE lname = 'LaCosse')),
  ('Women', 'What is women?', (SELECT id FROM users WHERE lname = 'Meyer')),
  ('Rails', 'What is Rails?', (SELECT id FROM users WHERE lname = 'Nolan')),
  ('Happiness', 'What is happy?', (SELECT id FROM users WHERE lname = 'Nolan'));

INSERT INTO
  replies(parent_id, body, user_id, q_id)
VALUES
  (NULL, 'SQL is Structured Query Language', (SELECT id FROM users WHERE lname = 'Tamboer'),
  (SELECT id FROM questions WHERE title = 'SQL')),

  (NULL, 'Ruby is a Object Oriented Language', (SELECT id FROM users WHERE lname = 'Duek'),
  (SELECT id FROM questions WHERE title = 'Ruby')),

  ((SELECT id FROM replies WHERE body = 'Ruby is a Object Oriented Language'), 'So helpful. Thx',
  (SELECT id FROM users WHERE lname = 'Lamers'), (SELECT id FROM questions WHERE title = 'Ruby'));

INSERT INTO
  question_likes(user_id, q_id)
VALUES
  ((SELECT id FROM users WHERE lname = 'Tamboer'),(SELECT id FROM questions WHERE title = 'SQL')),
  ((SELECT id FROM users WHERE lname = 'Tamboer'),(SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'Nolan'),(SELECT id FROM questions WHERE title = 'SQL')),
  ((SELECT id FROM users WHERE lname = 'Nolan'),(SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'Nolan'),(SELECT id FROM questions WHERE title = 'Women')),
  ((SELECT id FROM users WHERE lname = 'Duek'), (SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'Duek'), (SELECT id FROM questions WHERE title = 'SQL')),
  ((SELECT id FROM users WHERE lname = 'Lamers'), (SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'Lamers'), (SELECT id FROM questions WHERE title = 'Women')),
  ((SELECT id FROM users WHERE lname = 'LaCosse'), (SELECT id FROM questions WHERE title = 'Women')),
  ((SELECT id FROM users WHERE lname = 'Rodgriguez'), (SELECT id FROM questions WHERE title = 'Women')),
  ((SELECT id FROM users WHERE lname = 'Sweeney'), (SELECT id FROM questions WHERE title = 'Women')),
  ((SELECT id FROM users WHERE lname = 'LaCosse'), (SELECT id FROM questions WHERE title = 'Rails')),
  ((SELECT id FROM users WHERE lname = 'Rodgriguez'), (SELECT id FROM questions WHERE title = 'Rails')),
  ((SELECT id FROM users WHERE lname = 'Sweeney'), (SELECT id FROM questions WHERE title = 'Happiness'));

INSERT INTO
  question_followers(user_id, q_id)
VALUES
  ((SELECT id FROM users WHERE lname = 'Nolan'),(SELECT id FROM questions WHERE title = 'SQL')),
  ((SELECT id FROM users WHERE lname = 'Nolan'),(SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'LaCosse'), (SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'Lamers'), (SELECT id FROM questions WHERE title = 'Ruby')),
  ((SELECT id FROM users WHERE lname = 'Sweeney'), (SELECT id FROM questions WHERE title = 'SQL'));

INSERT INTO
  tags(tag)
VALUES
  ('html'),
  ('css'),
  ('ruby'),
  ('javascript');

INSERT INTO
  question_tags(q_id, t_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'Ruby'), (SELECT id FROM tags WHERE tag = 'ruby')),
  ((SELECT id FROM questions WHERE title = 'Rails'), (SELECT id FROM tags WHERE tag = 'ruby')),
  ((SELECT id FROM questions WHERE title = 'Women'), (SELECT id FROM tags WHERE tag = 'css')),
  ((SELECT id FROM questions WHERE title = 'Happiness'), (SELECT id FROM tags WHERE tag = 'html')),
  ((SELECT id FROM questions WHERE title = 'SQL'), (SELECT id FROM tags WHERE tag = 'javascript'));