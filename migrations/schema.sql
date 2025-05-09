
--
-- Database schema
--

CREATE DATABASE IF NOT EXISTS test;

CREATE TABLE test.content_event
(
    `event_id` UUID,
    `user_id` String,
    `ts` DateTime,
    `content` String
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(ts)
ORDER BY event_id
SETTINGS index_granularity = 8192;

CREATE TABLE test.schema_migrations
(
    `version` String,
    `ts` DateTime DEFAULT now(),
    `applied` UInt8 DEFAULT 1
)
ENGINE = ReplacingMergeTree(ts)
PRIMARY KEY version
ORDER BY version
SETTINGS index_granularity = 8192;

CREATE TABLE test.topic_event
(
    `event_id` UUID,
    `user_id` String,
    `ts` DateTime,
    `sentiment` Tuple(
        positive Float32,
        negative Float32,
        neutral Float32),
    `keywords.name` Array(String),
    `keywords.weight` Array(Float32),
    `entities.category` Array(String),
    `entities.name` Array(String),
    `entities.weight` Array(Float32)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(ts)
ORDER BY event_id
SETTINGS index_granularity = 8192;


--
-- Dbmate schema migrations
--

INSERT INTO schema_migrations (version) VALUES
    ('20250508');
