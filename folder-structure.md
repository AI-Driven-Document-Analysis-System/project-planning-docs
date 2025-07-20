project-root/
├── app/
│   ├── main.py                     # Single FastAPI application entry point
│   │
│   ├── core/                       # Core configuration
│   │   ├── config.py
│   │   ├── security.py
│   │   ├── database.py
│   │   └── dependencies.py
│   │
│   ├── api/                        # All API routes in one place
│   │   ├── __init__.py
│   │   ├── documents.py            # Document endpoints
│   │   ├── classification.py       # Classification endpoints
│   │   ├── ocr.py                  # OCR endpoints
│   │   ├── summarization.py        # Summarization endpoints
│   │   ├── search.py               # Search endpoints
│   │   ├── analytics.py            # Analytics endpoints
│   │   ├── auth.py                 # Authentication endpoints
│   │   └── subscriptions.py        # Subscription endpoints
│   │
│   ├── services/                   # Business logic layer
│   │   ├── document_service.py
│   │   ├── ocr_service.py
│   │   ├── classification_service.py
│   │   ├── summarization_service.py
│   │   ├── search_service.py
│   │   ├── analytics_service.py
│   │   ├── auth_service.py
│   │   └── subscription_service.py
│   │
│   ├── models/                     # All ML models
│   │   ├── layoutlmv3/
│   │   ├── bert_classifier/
│   │   ├── bart_t5/
│   │   └── vector_embeddings/
│   │
│   ├── schemas/                    # All Pydantic models
│   │   ├── document_schemas.py
│   │   ├── classification_schemas.py
│   │   ├── user_schemas.py
│   │   ├── search_schemas.py
│   │   └── analytics_schemas.py
│   │
│   ├── db/                         # Database models and operations
│   │   ├── models.py               # SQLAlchemy models
│   │   ├── crud.py                 # Database operations
│   │   └── init_db.py
│   │
│   ├── utils/                      # Shared utilities
│   │   ├── logger.py
│   │   ├── file_handler.py
│   │   ├── globals.py
│   │   └── helpers.py
│   │
│   └── middleware/                 # Custom middleware
│       ├── rate_limiting.py
│       ├── jwt_middleware.py
│       └── cors.py
│
├── frontend/                       # React.js frontend (still separate)
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── services/
│   └── package.json
│
├── storage/                        # File storage
│   ├── documents/
│   ├── thumbnails/
│   └── processed/
│
├── logs/                          # Application logs
│   └── app.log
│
├── tests/                         # All tests together
│   ├── test_documents.py
│   ├── test_classification.py
│   ├── test_auth.py
│   └── test_search.py
│
├── requirements.txt               # Single requirements file
├── Dockerfile                     # Single Docker container
├── docker-compose.yml             # Simplified compose
└── .env                          # Single environment file
