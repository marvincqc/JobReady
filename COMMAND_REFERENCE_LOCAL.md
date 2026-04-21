# Local AI Agents - Command Reference

## Quick Start Commands

```bash
# One-time setup (download models)
./setup-local-models.sh

# Start a model (in separate terminal)
docker model run ai/qwen2.5-coder

# Run full team
docker agent run jobready-agents-local.yaml

# Run backend only
docker agent run jobready-backend-local-only.yaml

# Run specific agent
docker agent run --agent frontend_engineer jobready-agents-local.yaml
docker agent run --agent devops_engineer jobready-agents-local.yaml
docker agent run --agent qa_tester jobready-agents-local.yaml
```

## Docker Model Runner Commands

```bash
# Check installation
docker model version

# List models
docker model list

# Pull models
docker model pull ai/qwen2.5-coder:7b-instruct-q5_k_m
docker model pull ai/smollm2:360m-q4_k_m

# Run model (start server)
docker model run ai/qwen2.5-coder
docker model run ai/smollm2

# View logs
docker model logs

# Stop model
docker model stop ai/qwen2.5-coder

# Remove model
docker model remove ai/qwen2.5-coder

# Configure model
docker model configure --context-size 8192 ai/qwen2.5-coder
```

## Docker Agent Commands

```bash
# Interactive chat
docker agent run jobready-agents-local.yaml

# Direct task
docker agent run jobready-agents-local.yaml "Your task here"

# Specific agent
docker agent run --agent backend_engineer jobready-agents-local.yaml "task"

# Backend only (faster)
docker agent run jobready-backend-local-only.yaml "task"

# Debug mode
docker agent run --debug jobready-agents-local.yaml

# Help
docker agent --help
docker agent run --help
```

## Common Task Examples

### Backend Tasks

```bash
# Quick fix
docker agent run jobready-backend-local-only.yaml \
  "Fix /api/links endpoint to filter by agency"

# Add feature
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Add POST /api/resumes/:id/download endpoint"

# Database work
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Create migration for 'exported_at' column"

# Code review
docker agent run --agent backend_engineer jobready-agents-local.yaml \
  "Review server.js for security issues"
```

### Frontend Tasks

```bash
# Mobile responsiveness
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Make form wizard mobile-responsive"

# Add feature
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Add progress indicator to form steps"

# Fix validation
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Fix phone validation for +60 country code"

# Accessibility
docker agent run --agent frontend_engineer jobready-agents-local.yaml \
  "Ensure keyboard navigation works on all form steps"
```

### DevOps Tasks

```bash
# Create Dockerfile
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create production Dockerfile"

# Docker Compose
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create docker-compose.yml for dev"

# CI/CD
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Create GitHub Actions workflow"

# Optimization
docker agent run --agent devops_engineer jobready-agents-local.yaml \
  "Optimize Dockerfile to reduce image size"
```

### QA Tasks

```bash
# Test feature
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Test OCR import feature"

# Mobile testing
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Test form submission on iOS and Android"

# Security review
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Review for security: CORS, input validation, file upload"

# Performance
docker agent run --agent qa_tester jobready-agents-local.yaml \
  "Test performance: form load, PDF generation, OCR speed"
```

### Full Team Planning

```bash
# Feature planning
docker agent run jobready-agents-local.yaml
# Type: "Plan a feature to bulk export resumes as CSV"

# Architecture review
docker agent run jobready-agents-local.yaml
# Type: "Review architecture and suggest improvements"

# Complete feature
docker agent run jobready-agents-local.yaml
# Type: "Implement resume download feature end-to-end"
```

## Useful Aliases

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Agents
alias agent='docker agent run jobready-agents-local.yaml'
alias agent-backend='docker agent run jobready-backend-local-only.yaml'
alias agent-backend-pro='docker agent run --agent backend_engineer jobready-agents-local.yaml'
alias agent-frontend='docker agent run --agent frontend_engineer jobready-agents-local.yaml'
alias agent-devops='docker agent run --agent devops_engineer jobready-agents-local.yaml'
alias agent-qa='docker agent run --agent qa_tester jobready-agents-local.yaml'

# Models
alias model-list='docker model list'
alias model-logs='docker model logs'
alias model-qwen='docker model run ai/qwen2.5-coder'
alias model-smol='docker model run ai/smollm2'

# Setup
alias setup-models='./setup-local-models.sh'

# Memory
alias reset-agent-memory='rm jobready_memory.db'
```

Then use:
```bash
agent
agent-backend "Fix /api/links"
agent-devops "Create Dockerfile"
setup-models
```

## Troubleshooting Commands

```bash
# Check Docker
docker ps

# Check Model Runner
docker model version

# Check if model server is running
curl http://localhost:11434/v1/models

# Check agent outputs
ls -la .jobready/

# View agent memory
cat jobready_memory.db

# Reset memory
rm jobready_memory.db

# Check disk space
docker system df

# View Docker logs
docker logs <container-id>

# Check system resources
docker stats
```

## Performance Optimization

```bash
# Use fastest model for quick tasks
docker agent run jobready-agents-local.yaml  # Uses Qwen

# Use smaller model
# Edit jobready-agents-local.yaml, change model to smollm2

# Reduce context for faster responses
docker model configure --context-size 2048 ai/qwen2.5-coder

# Monitor while running
docker stats

# Clean up old models
docker model remove ai/old-model
docker system prune
```

## Daily Workflow

```bash
# Morning: Start a model (keep it running)
docker model run ai/qwen2.5-coder

# During day: Run agents as needed
docker agent run jobready-agents-local.yaml "task 1"
docker agent run jobready-agents-local.yaml "task 2"

# Evening: Agent automatically stops when idle
# Or manually: docker model stop ai/qwen2.5-coder

# Reset if needed
rm jobready_memory.db
```

## File Management

```bash
# View agent outputs
ls -la .jobready/

# Read generated plan
cat .jobready/plan.md

# Read API documentation
cat .jobready/api.md

# Read QA report
cat .jobready/qa-report.md

# Clear old outputs
rm .jobready/*.md
```

---

For detailed information, see:
- `START_HERE.md` - Complete guide
- `LOCAL_MODELS_GUIDE.md` - Advanced topics
- `CHECKLIST.md` - Verification steps
