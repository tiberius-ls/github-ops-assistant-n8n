-- Table for storing all processed GitHub events
CREATE TABLE IF NOT EXISTS github_events (
    id BIGSERIAL PRIMARY KEY,
    delivery_id TEXT UNIQUE NOT NULL,
    event_type TEXT NOT NULL,
    repository_full_name TEXT,
    sender_login TEXT,
    received_at TIMESTAMPTZ DEFAULT NOW(),
    processed_at TIMESTAMPTZ,
    priority TEXT,
    category TEXT,
    action_required BOOLEAN,
    ai_summary TEXT,
    ai_reason TEXT,
    notification BOOLEAN,
    source_url TEXT
);

-- Table for logging AI rejections (Guardrails)
CREATE TABLE IF NOT EXISTS github_ai_rejections (
    id BIGSERIAL PRIMARY KEY,
    delivery_id TEXT UNIQUE NOT NULL,
    repository_full_name TEXT,
    event_type TEXT,
    action TEXT,
    validation_errors JSONB,
    ai_output JSONB,
    human_review_required BOOLEAN DEFAULT TRUE,
    logged_at TIMESTAMPTZ DEFAULT NOW()
);
