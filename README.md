# 🤖 AI GitHub Operations Assistant

An autonomous, production-grade DevOps automation system that monitors GitHub repositories, intelligently triages events using LLMs, prevents AI hallucinations, and delivers actionable insights via Telegram.


## 🚀 Overview
Most GitHub notification systems are noisy and unactionable. This project solves that by acting as an intelligent middleware between GitHub and the developer. It doesn't just forward webhooks; it understands them, validates the AI's logic, and only alerts the developer when necessary.

## 🛠️ Tech Stack
- **Orchestration:** n8n (Self-hosted)
- **Infrastructure:** Oracle Cloud Always Free Tier (24GB RAM, 4 vCPUs) + Cloudflare Tunnel
- **Database:** Supabase (PostgreSQL)
- **AI Engine:** Groq API (Llama 3 / Mixtral)
- **Notifications:** Telegram Bot API

## ✨ Key Features

### 1. Real-Time Intelligent Triage
Webhooks are normalized, routed, and analyzed by Groq AI in real-time. The AI classifies events into priorities (`High`, `Medium`, `Low`, `Informational`) and categories (`PR`, `Issue`, `Comment`, `Release`).

### 2. Deterministic AI Guardrails 🛡️
AI hallucinations can break production pipelines. This system includes a strict **Validation Layer** that checks the LLM's JSON output against a deterministic schema. If the AI invents a URL, gets the category wrong, or outputs invalid JSON, the event is blocked and logged for human review.

### 3. Executive Daily Digest 📊
A scheduled workflow aggregates 24 hours of activity from Supabase, filters out noise, and uses the LLM to generate a clean, HTML-formatted daily summary delivered to Telegram every evening.

### 4. Enterprise-Grade Security & Reliability
- **Parameterized SQL Queries:** Prevents SQL injection and safely handles special characters from GitHub payloads.
- **Global Error Handling:** A dedicated error workflow instantly alerts the developer via Telegram if any node in the pipeline fails.
- **Zero-Downtime Infrastructure:** Migrated from Render to Oracle Cloud to guarantee 24/7 uptime without memory-spin-down crashes.

## 🏗️ Architecture & Data Flow

1. **Ingestion:** GitHub Webhook hits the n8n endpoint (secured via Cloudflare Tunnel).
2. **Normalization:** The payload is parsed into a standardized JSON format.
3. **Deduplication:** Supabase checks the `delivery_id` to ensure events are only processed once.
4. **AI Analysis:** The event is sent to Groq with a strict system prompt.
5. **Validation:** A Code node verifies the AI's output against the original GitHub payload.
6. **Persistence & Routing:** Validated data is saved to Supabase. If `notification: true`, a formatted Telegram alert is sent.

## 🧠 The Engineering Journey (Challenges Solved)
Building this wasn't just about connecting APIs. Key engineering hurdles overcome include:
- **Infrastructure Scaling:** Migrated from Render's free tier (512MB RAM) to Oracle Cloud after experiencing "Offer expired" spin-down loops. 
- **Network Routing:** Resolved IPv6 DNS resolution bugs between Oracle Cloud and Supabase by implementing custom Node.js DNS flags (`--dns-result-order=ipv4first`).
- **Data Pipeline Edge Cases:** Filtered out GitHub's automatic `ping` events and handled `null` repository payloads to prevent database corruption.
- **HTML Parsing:** Debugged Telegram's strict HTML parser to ensure dynamic links and formatting render perfectly without breaking the API.

## 📦 Setup & Deployment
1. Clone the repository.
2. Import the `workflows/event-monitor.json` and `workflows/daily-digest.json` files into your n8n instance.
3. Configure your credentials (Supabase, Groq, Telegram).
4. Set up a Cloudflare Tunnel pointing to `localhost:5678`.
5. Update your GitHub App Webhook URL to your secure tunnel URL.

---
*Built by me*
