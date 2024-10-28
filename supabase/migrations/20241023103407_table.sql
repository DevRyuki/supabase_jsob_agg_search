CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE TABLE likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL
);

CREATE TABLE users_likes (
  user_id UUID REFERENCES users(id),
  like_id UUID REFERENCES likes(id),
  PRIMARY KEY (user_id, like_id)
);

CREATE VIEW users_likes_view AS
SELECT
  users.id AS user_id,
  users.name AS user_name,
  jsonb_agg(
    jsonb_build_object(
      'like_id', likes.id,
      'like_name', likes.name
    )
  ) AS likes:jsonb
FROM
  users
LEFT JOIN users_likes ON users.id = users_likes.user_id
LEFT JOIN likes ON users_likes.like_id = likes.id
GROUP BY
  users.id;