-- migrate:up
CREATE TABLE IF NOT EXISTS test.topic_attributes_events
(
    topic_attributes_event_uuid UUID,
    content_event_uuid UUID,
    user_id String,
    sentiments Nested(
        name String,
        weight Float32
    ),
    keywords Nested(
        name String,
        weight Float32
    ),
    entities Nested(
        category String,
        name String,
        weight Float32
    ),
    ts DateTime,
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(ts)
ORDER BY (topic_attributes_event_uuid);

-- migrate:down
DROP TABLE IF EXISTS test.topic_events;
