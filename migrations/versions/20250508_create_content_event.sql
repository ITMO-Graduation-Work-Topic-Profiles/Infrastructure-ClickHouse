-- migrate:up
CREATE TABLE IF NOT EXISTS test.content_event
(
    content_event_uuid UUID,
    user_id String,
    content String,
    ts DateTime,
)
    ENGINE = MergeTree()
    PARTITION BY toYYYYMM(ts)
    ORDER BY (content_event_uuid);

-- migrate:down
DROP TABLE IF EXISTS test.content_event;
