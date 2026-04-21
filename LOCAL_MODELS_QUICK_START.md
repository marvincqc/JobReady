# 🚀 LOCAL MODELS QUICK START

## 3 Steps to Start Using Local AI Agents for JobReady

### Step 1: Enable Docker Model Runner (2 min)
Open **Docker Desktop** → **Settings** → **AI** → Check "Enable Docker Model Runner" → Restart

### Step 2: Pull Models (5-10 min)
```bash
./setup-local-models.sh
```
Or manually:
```bash
docker model pull ai/qwen2.5-coder:7b-instruct-q5_k_m
docker model pull ai/smollm2:360m-q4_k_m
```

### Step 3: Start a Model
**Docker Desktop GUI:**
- Go to **Models** tab
- Click the **▶️ Play** button next to a model
- Wait for "Running" status

**Or CLI:**
```bash
docker model run ai/qwen2.5-coder
```

## Run Your Agents

### Full Team (Recommended)
```bash
docker agent run jobready-agents-local.yaml
```
Ask: "Add a feature to export resumes as JSON"

### Backend Only (Quick Tasks)
```bash
docker agent run jobready-backend-local.yaml "Add PDF export endpoint"
```

### Specific Agent
```bash
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Add multi-language support for Tamil"
```

## Examples

```bash
# Plan a feature
docker agent run --agent root jobready-agents-local.yaml \
  "Plan the resume download feature"

# Implement backend API
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Implement GET /api/resumes/:id/download endpoint"

# Improve frontend
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Optimize the form wizard for mobile"

# Test everything
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Test form submission end-to-end"

# Docker deployment
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create production Dockerfile"
```

## Model Performance

| Model | Speed | Best For | RAM |
|-------|-------|----------|-----|
| **Qwen 2.5 Coder** | 🟢 Medium | Coding, complex tasks | 8GB+ |
| **SmolLM2** | 🟢 Fast | Planning, simple tasks | 4GB+ |

**GPU:** 2-3x faster than CPU

## Key Files

- `jobready-agents-local.yaml` — Full team (5 agents)
- `jobready-backend-local.yaml` — Backend agent only
- `setup-local-models.sh` — Auto-setup script
- `LOCAL_MODELS_GUIDE.md` — Full documentation

## Troubleshooting

**Model not responding?**
→ Start it in Docker Desktop GUI (Models tab > Play button)

**Agent running slow?**
→ Use SmolLM2 instead, or check Docker Desktop stats

**Out of memory?**
→ Close other apps, or use smaller model

**Want cloud models back?**
```bash
export ANTHROPIC_API_KEY=sk-ant-...
docker agent run jobready-agents.yaml  # Original with API keys
```

## Next: Read Full Guide

→ See `LOCAL_MODELS_GUIDE.md` for detailed setup and advanced usage

---

**You're all set! Your local AI agents are ready to build JobReady. 🤖**
