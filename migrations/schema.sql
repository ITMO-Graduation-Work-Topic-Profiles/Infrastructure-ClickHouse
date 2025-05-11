
--
-- Database schema
--

CREATE DATABASE IF NOT EXISTS test;

CREATE TABLE test.content_events
(
    `content_event_uuid` UUID,
    `user_id` String,
    `content` String,
    `ts` DateTime
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(ts)
ORDER BY content_event_uuid
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

CREATE TABLE test.topic_events
(
    `topic_event_uuid` UUID,
    `content_event_uuid` UUID,
    `user_id` String,
    `sentiments.name` Array(String),
    `sentiments.weight` Array(Float32),
    `keywords.name` Array(String),
    `keywords.weight` Array(Float32),
    `entities.category` Array(String),
    `entities.name` Array(String),
    `entities.weight` Array(Float32),
    `ts` DateTime
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(ts)
ORDER BY topic_event_uuid
SETTINGS index_granularity = 8192;


--
-- Dbmate schema migrations
--

INSERT INTO schema_migrations (version) VALUES
    ('20250508'),
    ('20250509');
