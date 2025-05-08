-- migrate:up
CREATE TABLE IF NOT EXISTS test.content_event
(
    event_id UUID,
    user_id  String,
    ts       DateTime,
    content     String
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(ts)
ORDER BY (event_id);

-- migrate:down
DROP TABLE IF EXISTS test.content_event;
