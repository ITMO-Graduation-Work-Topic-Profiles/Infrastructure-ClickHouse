-- migrate:up
CREATE TABLE IF NOT EXISTS test.topic_event
(
    event_id  UUID,
    user_id   String,
    ts        DateTime,
    sentiment Tuple(positive Float32, negative Float32, neutral Float32),
    keywords     Nested(
        name   String,
        weight Float32
    ),
    entities   Nested(
        category String,
        name     String,
        weight   Float32
    )
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(ts)
ORDER BY (event_id);

-- migrate:down
DROP TABLE IF EXISTS test.topic_event;
