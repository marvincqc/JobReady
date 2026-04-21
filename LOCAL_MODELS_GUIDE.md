# JobReady Local Models Setup Guide

## Overview

Run Docker Agent with **local LLM models** on your machine. No API keys required. Everything runs offline using Docker Model Runner.

## What You'll Get

✅ Local LLM models (Qwen 2.5, SmolLM2)
✅ No API costs or API key management
✅ Agents run completely offline
✅ Full privacy - data stays on your machine
✅ Fast iteration and development

## Prerequisites

- Docker Desktop 4.63+ (macOS/Windows) OR Docker Engine (Linux)
- 8GB+ RAM recommended (16GB+ for optimal performance)
- GPU recommended but not required (uses CPU fallback)

## Step 1: Enable Docker Model Runner

### Docker Desktop (macOS/Windows)

1. Open **Docker Desktop** Settings
2. Go to **AI** tab
3. Check **Enable Docker Model Runner**
4. (Optional) Enable **GPU-backed inference** if you have NVIDIA GPU
5. (Optional) Enable **TCP support** on port 11434 for remote connections
6. Click **Apply & Restart**

### Docker Engine (Linux)

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker-model-plugin

# Or RHEL/CentOS
sudo dnf install docker-model-plugin

# Verify installation
docker model version
```

## Step 2: Pull Local Models

Run the automated setup script:

```bash
chmod +x setup-local-models.sh
./setup-local-models.sh
```

Or manually pull models:

```bash
# Best for coding tasks (recommended for agents)
docker model pull ai/qwen2.5-coder:7b-instruct-q5_k_m

# Fast, lightweight, for simple tasks
docker model pull ai/smollm2:360m-q4_k_m

# List downloaded models
docker model list
```

### Available Models

| Model | Size | Speed | Best For |
|-------|------|-------|----------|
| **Qwen 2.5 Coder** | 7B | Medium | Code generation, API design, complex tasks |
| **SmolLM2** | 360M | Fast | Planning, simple Q&A, quick iterations |
| **Llama 2** | 7B/13B | Medium | General purpose, chat |
| **Mistral** | 7B | Fast | Code, reasoning tasks |

**Download times:** 7-10 minutes on fast internet (first time only, then cached)

## Step 3: Start Model Runner

### Option A: Docker Desktop GUI (Easiest)

1. Open Docker Desktop
2. Go to **Models** tab
3. Click the **▶️ Play** button next to a model
4. Wait for "Model is running" message

### Option B: Docker CLI

```bash
# Run a specific model
docker model run ai/qwen2.5-coder

# Run with custom parameters
docker model run --context-size 8192 ai/qwen2.5-coder
```

The model server will be available at **http://localhost:11434/v1**

## Step 4: Run JobReady Agents with Local Models

### Full Team (All Agents)

```bash
docker agent run jobready-agents-local.yaml
```

Then interact with the Product Manager:

```
You: "Add a feature to export resumes as CSV for agencies"
```

The team will break it down and delegate tasks.

### Backend Agent Only

```bash
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Add a POST /api/resumes/:id/download endpoint"
```

Or use the backend-focused agent:

```bash
docker agent run jobready-backend-local.yaml \
  "Fix the /api/submissions query to properly filter by agency"
```

### Frontend Agent

```bash
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Add a 'clear all fields' button to the form wizard"
```

### DevOps Agent

```bash
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create a production Dockerfile with multi-stage build"
```

### QA Testing Agent

```bash
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Test the form submission flow on mobile"
```

## Usage Examples

### 1. Quick Backend Task

```bash
docker agent run jobready-backend-local.yaml
# Paste your task and let the agent work
```

### 2. Complex Feature with Full Team

```bash
docker agent run jobready-agents-local.yaml
# Type: "I need to add a resume download feature that generates PDF"
# The team will plan it, implement it, test it, and handle deployment
```

### 3. Code Review

```bash
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Review the /api/links endpoint for security issues"
```

### 4. Documentation

```bash
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Document all API endpoints and create .jobready/api.md"
```

### 5. Test a Feature

```bash
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Test OCR import functionality and report any bugs"
```

## Model Performance Guide

### CPU Only (No GPU)
- **Qwen 2.5 Coder**: ~10-20 tokens/sec (reasonable)
- **SmolLM2**: ~30-50 tokens/sec (fast)
- **Recommendation**: Use SmolLM2 for quick tasks, Qwen for important work

### With GPU (NVIDIA)
- **Qwen 2.5 Coder**: ~50-100 tokens/sec (fast)
- **SmolLM2**: ~100+ tokens/sec (very fast)
- **Recommendation**: Use both, switch between them as needed

### Speed Tips
1. Smaller context size = faster responses
2. Set `--context-size 2048` for quick tasks
3. Use SmolLM2 for simple planning, Qwen for coding
4. Run model in Docker Desktop GUI for best resource usage

## Configuration

### Adjust Model Settings

```bash
# Set context size for a model
docker model configure --context-size 8192 ai/qwen2.5-coder

# See current configuration
docker model inspect ai/qwen2.5-coder
```

### Update Agent YAML

Edit `jobready-agents-local.yaml` to change models:

```yaml
models:
  local_default:
    provider: openai
    base_url: http://localhost:11434/v1
    model: qwen2.5-coder        # Change this
    max_tokens: 4096            # Or this for speed/quality
```

## Troubleshooting

### "Model Runner API not responding"

**Solution 1**: Start the model in Docker Desktop GUI
```bash
# Docker Desktop > Models > Click Play button
```

**Solution 2**: Start manually
```bash
docker model run ai/qwen2.5-coder
```

**Solution 3**: Check if port 11434 is in use
```bash
lsof -i :11434
# If occupied, configure different port in Docker Desktop settings
```

### "curl: (52) Empty reply from server"

The model server is starting but not ready yet. Wait 10-30 seconds.

### Agent Runs Slowly

- Check if model is loaded: Open Docker Desktop > Models > check status
- Try smaller model: Use SmolLM2 instead of Qwen
- Reduce context size: `docker model configure --context-size 2048`
- Check CPU/RAM usage in Activity Monitor

### Out of Memory Error

- Close other apps to free RAM
- Use smaller model (SmolLM2)
- Reduce context size
- Add swap space (Linux: `free -h` to check)

### Model Takes Long Time to Download

- Check internet connection
- Models are 2-7GB, downloading takes 5-10 minutes on good connection
- Models are cached locally after first download
- You can pause/resume in Docker Desktop

## Monitor Models

### Docker Desktop GUI
1. Open Docker Desktop
2. Go to **Models** tab
3. Check **Requests** tab to see agent activity
4. View **Logs** for debugging

### Docker CLI

```bash
# View logs
docker model logs ai/qwen2.5-coder

# List running models
docker model list

# Stop a model
docker model stop ai/qwen2.5-coder
```

## Advanced: Use Multiple Models

Edit `jobready-agents-local.yaml` to use different models for different agents:

```yaml
models:
  coder:
    provider: openai
    base_url: http://localhost:11434/v1
    model: qwen2.5-coder
  
  planner:
    provider: openai
    base_url: http://localhost:11434/v1
    model: smollm2

agents:
  backend_engineer:
    model: coder              # Use Qwen for coding
  
  root:
    model: planner            # Use SmolLM for planning
```

## Privacy & Data

✅ **Completely offline** - Models run locally, data never leaves your machine
✅ **No tracking** - No telemetry or analytics
✅ **No API calls** - Except to your local server
✅ **Your data is yours** - Full control and privacy

## Cost Savings

- **No API costs** - Models run free on your hardware
- **No rate limits** - Run as many agents as you want
- **No subscription** - One-time download, use forever

## Limitations

- **Smaller context window** - Qwen supports ~8K tokens (vs Claude's 200K+)
- **Not as powerful** - Open source models vs enterprise LLMs
- **Slower responses** - CPU inference is slower than cloud APIs
- **Memory usage** - 7B models need ~8GB RAM loaded

For complex tasks, you can still switch back to cloud models:

```bash
# Use Anthropic Claude instead
export ANTHROPIC_API_KEY=sk-ant-...
docker agent run jobready-agents.yaml
```

## Next Steps

1. ✅ Enable Docker Model Runner (see Step 1)
2. ✅ Pull models: `./setup-local-models.sh`
3. ✅ Start a model in Docker Desktop GUI
4. ✅ Run agents: `docker agent run jobready-agents-local.yaml`
5. ✅ Give agents tasks and watch them work

## Resources

- [Docker Model Runner Docs](https://docs.docker.com/ai/model-runner/)
- [Docker Agent Docs](https://docs.docker.com/ai/docker-agent/)
- [Available Models on Docker Hub](https://hub.docker.com/u/ai)
- [HuggingFace Model Browser](https://huggingface.co/models)

## Support

### Get Help

```bash
# Docker agent help
docker agent --help
docker agent run --help

# Model runner help
docker model --help
docker model pull --help
```

### Check Logs

```bash
# View model runner logs
docker model logs

# View agent execution logs
docker agent run --debug jobready-agents-local.yaml
```

### Common Workflows

**Stuck? Start simple:**
```bash
# Test if model is working
docker model run ai/smollm2

# Ask a simple question
# Q: "What is 2+2?"
# Should respond instantly
```

---

**Ready to build with local AI? Let's go! 🚀**
