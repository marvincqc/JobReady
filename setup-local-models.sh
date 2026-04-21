#!/bin/bash

# JobReady Local Models Setup Script
# Sets up Docker Model Runner and pulls recommended models

set -e

echo "🤖 JobReady Local Models Setup"
echo "================================"
echo ""

# Check if Docker is running
if ! docker ps > /dev/null 2>&1; then
    echo "❌ Error: Docker is not running. Please start Docker Desktop or Docker Engine."
    exit 1
fi

# Check if docker model command exists
echo "Checking Docker Model Runner installation..."
if ! docker model version > /dev/null 2>&1; then
    echo "❌ Error: Docker Model Runner not found."
    echo ""
    echo "SETUP INSTRUCTIONS:"
    echo "1. On Docker Desktop: Settings > AI > Enable Docker Model Runner"
    echo "2. On Linux: sudo apt-get install docker-model-plugin"
    echo "3. Then run this script again"
    exit 1
fi

echo "✅ Docker Model Runner found: $(docker model version | head -1)"
echo ""

# Recommended models for JobReady
echo "📥 Pulling recommended models..."
echo ""

# Option 1: Lightweight coding model (recommended for agents)
echo "Pulling Qwen 2.5 Coder (recommended for coding agents)..."
docker model pull ai/qwen2.5-coder:7b-instruct-q5_k_m || echo "⚠️  Note: Pull may require time for large models"

# Option 2: Smaller, faster model
echo ""
echo "Pulling SmolLM2 (faster, for simple tasks)..."
docker model pull ai/smollm2:360m-q4_k_m

echo ""
echo "✅ Models pulled successfully!"
echo ""
echo "MODEL INFORMATION:"
echo "- Qwen 2.5 Coder (7B): Best for coding, API design, backend tasks"
echo "- SmolLM2 (360M): Fast, lightweight, good for planning tasks"
echo ""

# Check if Docker Model Runner is serving on localhost:11434
echo "Checking Model Runner API..."
if ! curl -s http://localhost:11434/v1/models > /dev/null 2>&1; then
    echo "⚠️  Model Runner API not responding on localhost:11434"
    echo ""
    echo "NEXT STEPS:"
    echo "1. Open Docker Desktop > Models tab"
    echo "2. Select a model and click 'Run' to start the server"
    echo "3. Or run: docker model run ai/qwen2.5-coder"
    echo ""
fi

echo ""
echo "🚀 READY TO USE!"
echo ""
echo "Run your agents with local models:"
echo ""
echo "  # Full team with all agents"
echo "  docker agent run jobready-agents-local.yaml"
echo ""
echo "  # Backend agent only"
echo "  docker agent run --agent backend_engineer jobready-agents-local.yaml 'Add API endpoint'"
echo ""
echo "  # Or use the backend-only agent"
echo "  docker agent run jobready-backend-local.yaml"
echo ""
