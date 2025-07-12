# Sample Document

This is a sample markdown document to test docling processing.

## Features

Docling can process various document formats including:

- PDF files
- Microsoft Word documents (.docx)
- PowerPoint presentations (.pptx)
- HTML files
- Images with text (OCR)

## Usage

Place your documents in this workspace directory and use the docling commands to process them.

## Example

```python
from docling.document_converter import DocumentConverter

converter = DocumentConverter()
result = converter.convert("sample.md")
print(result.document.export_to_markdown())
```

This sample file can be processed to test the docling setup.