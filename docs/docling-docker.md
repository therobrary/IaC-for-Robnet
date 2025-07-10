# Docling Docker Image Builder

This repository contains a GitHub Actions workflow that automatically builds and publishes Docker images for the [Docling](https://github.com/docling-project/docling) document processing library.

## Overview

The workflow:
- Monitors the docling repository for new releases
- Builds Docker images using the official Docling Dockerfile
- Publishes images to GitHub Container Registry (ghcr.io)
- Runs daily at 6 AM UTC to check for updates

## Docker Images

Images are published as:
```
ghcr.io/therobrary/docling:latest
ghcr.io/therobrary/docling:<version-tag>
```

### Usage

```bash
# Run with the latest version
docker run --rm -v $(pwd):/workspace ghcr.io/therobrary/docling:latest

# Run with a specific version
docker run --rm -v $(pwd):/workspace ghcr.io/therobrary/docling:v2.41.0

# Interactive shell
docker run --rm -it -v $(pwd):/workspace ghcr.io/therobrary/docling:latest bash
```

### Available Platforms
- linux/amd64
- linux/arm64

## Workflow Details

### Automatic Builds
- **Schedule**: Daily at 6:00 AM UTC
- **Trigger**: New releases in the docling repository
- **Duplicate Prevention**: Checks if version already exists before building

### Manual Builds
The workflow can be triggered manually:
1. Go to Actions → "Build Docling Docker Image"
2. Click "Run workflow"
3. Optionally enable "Force build" to rebuild existing versions

### Image Contents
The Docker images include:
- Python 3.11 (slim-bookworm base)
- Docling library with CPU-only PyTorch
- Pre-downloaded models for faster startup
- System dependencies (libgl1, libglib2.0-0, etc.)
- Example script at `/root/minimal.py`

### Environment Variables
- `HF_HOME=/tmp/` - Hugging Face cache location
- `TORCH_HOME=/tmp/` - PyTorch cache location  
- `OMP_NUM_THREADS=4` - Thread limit for container environments
- `DOCLING_ARTIFACTS_PATH=/root/.cache/docling/models` - Model cache path

## Development

### Testing the Workflow
1. Fork this repository
2. Enable GitHub Actions in your fork
3. Manually trigger the workflow to test
4. Check the published packages in your fork's packages section

### Customization
The workflow can be customized by editing `.github/workflows/build-docling-image.yml`:
- Change the schedule (cron expression)
- Modify build platforms
- Add additional tags or labels
- Customize the Docker build context

## Troubleshooting

### Common Issues
1. **Permission Denied**: Ensure GitHub Actions has package write permissions
2. **Build Failures**: Check the docling repository for Dockerfile changes
3. **Missing Versions**: Verify the release exists in the docling repository

### Logs
Build logs are available in the GitHub Actions tab of this repository.