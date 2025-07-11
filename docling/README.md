# Docling Docker Compose Setup

This directory contains a Docker Compose configuration to run the [Docling](https://github.com/docling-project/docling) document processing service using the pre-built image from this repository's package registry.

## Usage

### Quick Start

1. Create a workspace directory and add your documents:
```bash
mkdir -p workspace
# Add your PDF, Word, or other documents to the workspace directory
cp your-document.pdf workspace/
```

2. Start the docling service:
```bash
docker-compose up -d
```

3. Execute docling commands:
```bash
# Process a document
docker-compose exec docling python -m docling.cli.main your-document.pdf

# Interactive shell access
docker-compose exec docling bash

# Run the example script
docker-compose exec docling python /root/minimal.py
```

4. Stop the service:
```bash
docker-compose down
```

### File Structure

```
docling/
├── docker-compose.yml      # Docker Compose configuration
├── README.md              # This file
└── workspace/             # Your documents directory (created automatically)
```

### Volume Mounts

- `./workspace:/workspace` - Local workspace directory mounted into the container
- `docling_cache` - Named volume for persistent model cache storage

### Environment Variables

The container is configured with optimized settings:
- `OMP_NUM_THREADS=4` - OpenMP thread limit for better container performance
- `HF_HOME=/tmp/` - Hugging Face cache location
- `TORCH_HOME=/tmp/` - PyTorch cache location
- `DOCLING_ARTIFACTS_PATH=/root/.cache/docling/models` - Model cache path

### Image Information

- **Image**: `ghcr.io/therobrary/docling:latest`
- **Base**: Python 3.11 (slim-bookworm)
- **Platform**: linux/amd64
- **Updates**: Automatically built from latest docling releases

## Examples

### Processing Documents

```bash
# Start the service
docker-compose up -d

# Process a PDF file
docker-compose exec docling python -m docling.cli.main workspace/document.pdf

# Process with specific output format
docker-compose exec docling python -m docling.cli.main workspace/document.pdf --output-format markdown

# Process multiple files
docker-compose exec docling python -m docling.cli.main workspace/*.pdf
```

### Using the Python API

```bash
# Enter interactive shell
docker-compose exec docling python

# In Python shell:
from docling.document_converter import DocumentConverter
converter = DocumentConverter()
result = converter.convert("workspace/document.pdf")
print(result.document.export_to_markdown())
```

## Troubleshooting

### Common Issues

1. **Permission denied**: Ensure the workspace directory has proper permissions
2. **Memory issues**: Consider increasing Docker memory limits for large documents
3. **Model download**: First run may take time to download models (cached afterwards)

### Logs

View container logs:
```bash
docker-compose logs docling
```

Follow logs in real-time:
```bash
docker-compose logs -f docling
```