# 🚀 Local AI Agents - 3-Step Setup

## Step 1: Enable Docker Model Runner (2 min)

### Docker Desktop
Settings → AI → Enable Docker Model Runner → Apply & Restart

### Linux
```bash
sudo apt-get install docker-model-plugin
```

## Step 2: Download Models (5-10 min, one-time)

```bash
./setup-local-models.sh
```

Wait for download to complete.

## Step 3: Start & Run

### Start Model
Docker Desktop → Models tab → Click ▶️ button

OR

```bash
docker model run ai/qwen2.5-coder
```

### Run Agents
```bash
# Full team
docker agent run jobready-agents-local.yaml

# Backend only (faster)
docker agent run jobready-backend-local-only.yaml

# Specific agent
docker agent run --agent frontend_engineer jobready-agents-local.yaml
```

Done! 🎉

---

## Quick Examples

```bash
# Interactive
docker agent run jobready-agents-local.yaml
# Type: "Add resume export feature"

# Direct task
docker agent run jobready-backend-local-only.yaml \
  "Fix the /api/links endpoint"

# Specific agent
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create Dockerfile"
```

---

For more details → `START_HERE_LOCAL.md`
