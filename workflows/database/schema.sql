-- Main events table for deduplication and daily digests
CREATE TABLE IF NOT EXISTS github_events (
    id BIGSERIAL PRIMARY KEY,
    delivery_id TEXT UNIQUE,
    event_type TEXT NOT NULL,
    repository_full_name TEXT,
    priority TEXT,
    action_required BOOLEAN,
    category TEXT,
    ai_summary TEXT,
    ai_reason TEXT,
    notification BOOLEAN,
    source_url TEXT,
    received_at TIMESTAMPTZ DEFAULT NOW(),
    processed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Audit table for failed AI validations
CREATE TABLE IF NOT EXISTS github_ai_rejections (
    id BIGSERIAL PRIMARY KEY,
    delivery_id TEXT UNIQUE,
    repository_full_name TEXT,
    event_type TEXT,
    action TEXT,
    validation_errors JSONB NOT NULL DEFAULT '[]'::jsonb,
    ai_output JSONB,
    human_review_required BOOLEAN NOT NULL DEFAULT TRUE,
    logged_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
