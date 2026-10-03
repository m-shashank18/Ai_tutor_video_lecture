# RAG Document Q&A — Week 1: Ingestion Pipeline

A production-style Retrieval-Augmented Generation system built incrementally over multiple weeks.

## Week 1 scope

| Component | Description |
|-----------|-------------|
| `DocumentLoader` | Load PDF, DOCX, TXT, MD with rich metadata |
| `DocumentChunker` | Recursive character splitting with per-chunk stats |
| `IngestionPipeline` | Orchestrates load → chunk, returns typed `IngestionResult` |
| `Settings` | Pydantic-settings, all config from `.env` |

## Quick start

```bash
# 1. Clone & enter
cd rag-docqa

# 2. Create virtual environment
python -m venv .venv
.venv\Scripts\activate        # Windows
# source .venv/bin/activate   # macOS/Linux

# 3. Install dependencies
pip install -r requirements.txt

# 4. Configure (optional for Week 1)
cp .env.example .env
# edit .env — only GROQ_API_KEY matters in later weeks

# 5. Run tests
python tests/test_week1_pipeline.py
```

## Project structure

```
rag-docqa/
├── config/
│   └── settings.py          # Pydantic-Settings, reads .env
├── src/
│   ├── ingestion/
│   │   ├── document_loader.py
│   │   └── pipeline.py
│   ├── chunking/
│   │   └── text_splitter.py
│   └── utils/
│       └── logger.py
├── tests/
│   └── test_week1_pipeline.py
├── data/
│   └── sample_docs/
│       └── sample.txt
├── requirements.txt
├── .env.example
├── Dockerfile
└── README.md
```

## Supported file types

| Extension | Library | Notes |
|-----------|---------|-------|
| `.pdf` | pypdf | One `Document` per page |
| `.docx` | docx2txt | Single `Document` |
| `.txt` | built-in + chardet | Auto encoding detection |
| `.md` | built-in + chardet | Auto encoding detection |

## Configuration reference

| Variable | Default | Description |
|----------|---------|-------------|
| `CHUNK_SIZE` | 512 | Target chunk size in characters |
| `CHUNK_OVERLAP` | 64 | Overlap between consecutive chunks |
| `MAX_FILE_SIZE_MB` | 50 | Reject files larger than this |
| `GROQ_API_KEY` | — | Used from Week 2 onward |
| `LOG_LEVEL` | INFO | loguru log level |

## Docker

```bash
docker build -t rag-week1 .
docker run --rm rag-week1
```
