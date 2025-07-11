#!/bin/bash

# Test script to verify the docling docker-compose setup
set -e

echo "🧪 Testing Docling Docker Compose Setup"
echo "========================================"

cd "$(dirname "$0")"

echo "📋 Validating docker-compose.yml..."
docker compose config > /dev/null
echo "✅ docker-compose.yml is valid"

echo "🚀 Starting docling service..."
docker compose up -d
sleep 5

echo "🔍 Checking service status..."
docker compose ps

echo "🐍 Testing Python import..."
docker compose exec -T docling python -c "import docling; print('✅ Docling import successful')"

echo "📁 Testing workspace mount..."
docker compose exec -T docling ls -la /workspace

echo "🧹 Cleaning up..."
docker compose down

echo "🎉 All tests passed! The docling setup is working correctly."