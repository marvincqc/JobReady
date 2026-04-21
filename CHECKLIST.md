# JobReady AI Agents Setup Checklist

## Pre-Setup (Before You Start)
- [ ] Docker Desktop is installed and running
- [ ] You have a JobReady project directory
- [ ] You've reviewed the agent files (10 files created)
- [ ] You have about 15 minutes for setup

## Choose Your Path

### Path A: Local Models (Free & Offline) ✨ RECOMMENDED
- [ ] Read `START_HERE.md`
- [ ] Read `LOCAL_MODELS_QUICK_START.md`
- [ ] Docker Desktop Settings > AI > Enable Docker Model Runner
- [ ] Run `chmod +x setup-local-models.sh && ./setup-local-models.sh`
- [ ] Wait for models to download (5-10 min, one-time only)
- [ ] Open Docker Desktop > Models tab > Click play button for a model
- [ ] Wait until model shows "Running"
- [ ] Test: `docker agent run jobready-agents-local.yaml`
- [ ] If successful, proceed to "First Task"

### Path B: Cloud Models (Fast & Powerful)
- [ ] Read `START_HERE.md`
- [ ] Read `AGENTS_SETUP.md`
- [ ] Get API key: OpenAI or Anthropic
- [ ] Set environment variable: `export ANTHROPIC_API_KEY=sk-ant-...`
- [ ] Test: `docker agent run jobready-agents.yaml`
- [ ] If successful, proceed to "First Task"

## First Task

### Option 1: Interactive Chat
- [ ] Run: `docker agent run jobready-agents-local.yaml` (or `jobready-agents.yaml` for cloud)
- [ ] Type your task: `"What's in my codebase? Suggest improvements"`
- [ ] Let the agent explore your project
- [ ] Review the suggestions

### Option 2: Direct Task
- [ ] Run: `docker agent run jobready-backend-local.yaml "What are the current API endpoints?"`
- [ ] Wait for response
- [ ] Check `.jobready/` directory for outputs

## Common First Tasks (Choose One)

### Backend Tasks
- [ ] Fix API endpoint
```bash
docker agent run jobready-backend-local.yaml \
  "Fix the /api/links endpoint bug"
```

### Frontend Tasks
- [ ] Improve form
```bash
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Add mobile responsiveness to the form"
```

### DevOps Tasks
- [ ] Create Docker config
```bash
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create Dockerfile for production"
```

### Full Team Planning
- [ ] Plan a feature
```bash
docker agent run jobready-agents-local.yaml
# Type: "Plan a resume export feature"
```

## Verification Checklist

After first run:
- [ ] Agent completed without errors
- [ ] Output was relevant to your task
- [ ] Files were created in `.jobready/` directory
- [ ] Agent can access your codebase (read files)

## Troubleshooting Checklist

If something fails:
- [ ] Check Docker is running: `docker ps`
- [ ] Check Model Runner: `docker model version`
- [ ] For local models: Check model is running in Docker Desktop
- [ ] Check API key (if cloud): `echo $ANTHROPIC_API_KEY`
- [ ] Reset memory: `rm jobready_memory.db`
- [ ] Check disk space: `docker system df`

## Advanced Setup (Optional)

### Add Aliases for Faster Access
- [ ] Edit `~/.bashrc` or `~/.zshrc`
- [ ] Add aliases from `COMMAND_REFERENCE.md`
- [ ] Source the file: `source ~/.bashrc`
- [ ] Test: `agent-local --help` (should work)

### Set Up for Team Collaboration
- [ ] Create `.env` with Supabase credentials
- [ ] Share `.yaml` files with team
- [ ] Document project context in `README.md`
- [ ] Create `.gitignore` entry for `jobready_memory.db` (optional)

### Integrate with IDE
- [ ] For Cursor: Configure Model Runner in settings
- [ ] For Continue.dev: Point to `http://localhost:11434/v1`
- [ ] For Cline: Set up Docker Model Runner integration

## Performance Optimization (Optional)

- [ ] Benchmark your setup: Run a simple task and time it
- [ ] Adjust context size if needed: `docker model configure --context-size 2048`
- [ ] Monitor resources: `docker stats`
- [ ] Consider GPU if available (check Docker Desktop settings)

## Documentation Review

After setup, read these in order:
- [ ] `START_HERE.md` - Overview (5 min)
- [ ] `COMMAND_REFERENCE.md` - Common commands (5 min)
- [ ] `LOCAL_MODELS_GUIDE.md` or `AGENTS_SETUP.md` - Detailed setup (10 min)
- [ ] Agent YAML files - Understand agent roles (5 min)

## Daily Usage

Every time you want to use agents:

### Option A: Interactive (Best for complex tasks)
```bash
docker agent run jobready-agents-local.yaml
# Describe your task in natural language
```

### Option B: Direct (Best for quick fixes)
```bash
docker agent run jobready-backend-local.yaml "Your task here"
```

### Option C: Specific Agent
```bash
docker agent run --agent frontend_engineer jobready-agents-local.yaml "Your task"
```

## Monthly Maintenance

- [ ] Update agent configs if needed
- [ ] Review `.jobready/` outputs
- [ ] Update agent instructions based on project changes
- [ ] Review and clean up `jobready_memory.db` if needed (optional)
- [ ] Check for Docker updates: `docker --version`
- [ ] Check for Model Runner updates: `docker model version`

## Success Indicators

You're ready when:
- ✅ Agent runs without errors
- ✅ Agent reads your codebase successfully
- ✅ Agent generates relevant code/plans
- ✅ You understand the 5 agent roles
- ✅ You can run agents with a simple command
- ✅ You have 2-3 successful agent interactions

## Next Steps After Setup

1. **Generate Dockerfile**: `docker agent run --agent devops_engineer jobready-agents-local.yaml "Create Dockerfile"`
2. **Plan a feature**: `docker agent run jobready-agents-local.yaml "Plan resume export feature"`
3. **Fix a bug**: `docker agent run jobready-backend-local.yaml "Fix the /api/links endpoint"`
4. **Test everything**: `docker agent run --agent qa_tester jobready-agents-local.yaml "Full test"`
5. **Deploy**: Use DevOps agent to set up CI/CD

## Files You Created

Total: 11 files

**Documentation (6 files)**:
- START_HERE.md
- LOCAL_MODELS_QUICK_START.md
- LOCAL_MODELS_GUIDE.md
- AGENTS_SETUP.md
- AGENTS_COMPARISON.md
- COMMAND_REFERENCE.md
- FILES_OVERVIEW.txt
- CHECKLIST.md (this file)

**Configurations (4 files)**:
- jobready-agents.yaml (cloud)
- jobready-agents-local.yaml (local)
- jobready-backend.yaml (cloud)
- jobready-backend-local.yaml (local)

**Scripts (1 file)**:
- setup-local-models.sh

## Support Resources

Quick links:
- Docker Agent: https://docs.docker.com/ai/docker-agent/
- Model Runner: https://docs.docker.com/ai/model-runner/
- Docker Hub AI Models: https://hub.docker.com/u/ai
- GitHub: https://github.com/docker/docker-agent

---

✅ **You're all set! Start with `START_HERE.md` and choose your path.**

Questions? Check the relevant guide or re-read this checklist.
