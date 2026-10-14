# 🤖 AI-Powered GitHub Operations Assistant

An event-driven automation system that monitors GitHub activity, validates events against GitHub's source-of-truth data, intelligently prioritizes developer actions using AI, stores activity history, and delivers contextual real-time notifications.

##  Live Demo
[Watch the 90-second project walkthrough on Loom](#) *(Replace # with your Loom link once recorded!)*

## 🚀 Why This Isn't Just a "Notification Bot"
Most GitHub automation tools spam you with every single event, leading to notification fatigue. This system uses a strict **AI Triage & Deterministic Validation Layer** to determine *if* you actually need to take action. It prevents hallucinations, ensures critical PR reviews are never missed, and safely audits any ambiguous AI decisions.

## 🛠️ Tech Stack
- **Orchestration:** n8n (Self-hosted on Render)
- **Database:** PostgreSQL (Supabase) for event deduplication and audit logging
- **AI/LLM:** Groq (Fast, structured JSON output)
- **Integration:** GitHub App (Webhooks), Telegram Bot API

## 🏗️ Architecture Highlights
1. **Source of Truth Validation:** The AI is *never* allowed to invent facts. It only classifies normalized, pre-validated GitHub payloads.
2. **Fail-Safe AI Validator:** A deterministic code layer checks the AI's output. If the AI misclassifies priority or hallucinates, the event is safely routed to a PostgreSQL audit table (`github_ai_rejections`) for human review.
3. **Smart Routing:** High-priority actions (e.g., PR review requests) trigger instant Telegram alerts. Low-priority events are batched for daily digests.
4. **Idempotency:** Uses GitHub's `delivery_id` with PostgreSQL `ON CONFLICT` to guarantee zero duplicate processing.

## 📊 Workflow Diagram
```text
GitHub App Webhook 
       ↓
n8n Webhook (Normalize Payload)
       ↓
PostgreSQL (Deduplication Check)
       ↓
Groq AI (Triage & Classification)
       ↓
Deterministic Validator (Pass/Fail Gate)
       ↓
   ┌───┴───┐
   ↓       ↓
TRUE     FALSE
   ↓       ↓
Telegram  PostgreSQL Audit Log
```

## 🚀 Getting Started
1. Clone this repository and import the JSON workflow from the `/workflows` folder into your n8n instance.
2. Create a GitHub App with `Read-only` permissions for Issues, Pull Requests, and Actions.
3. Set up a Supabase PostgreSQL database and run the schema provided in `/database/schema.sql`.
4. Configure your n8n environment variables and Telegram Bot credentials.

---
*Built by Emeka | Open to AI Automation & DevOps opportunities in the UK, Canada, and Australia.*
