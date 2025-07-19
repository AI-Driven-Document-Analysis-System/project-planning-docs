------------------------------------------------
-- A rough database design for PostgressSQL DB
------------------------------------------------

-- document meta data
CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_filename VARCHAR(255) NOT NULL,
    file_path_minio TEXT NOT NULL,
    file_size BIGINT NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    document_hash VARCHAR(64) UNIQUE,
    page_count INTEGER,
    language_detected VARCHAR(10),
    upload_timestamp TIMESTAMP DEFAULT NOW(),
    uploaded_by_user_id UUID,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- document processing
CREATE TABLE document_processing (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    processing_status VARCHAR(50) NOT NULL,
    processing_errors JSONB,
    ocr_completed_at TIMESTAMP,
    classification_completed_at TIMESTAMP,
    summarization_completed_at TIMESTAMP,
    indexing_completed_at TIMESTAMP
);

-- document content
CREATE TABLE document_content (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    extracted_text TEXT, -- stores the entire text from the document. Can store up to 1GB of data
    searchable_content TEXT,
    layout_sections JSONB,
    entities_extracted JSONB,
    ocr_confidence_score DECIMAL(5,4),
    has_tables BOOLEAN DEFAULT FALSE,
    has_images BOOLEAN DEFAULT FALSE
);


-- classification details
CREATE TABLE document_classifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    document_type VARCHAR(50) NOT NULL,
    confidence_score DECIMAL(5,4) NOT NULL,
    model_version VARCHAR(20),
    classified_at TIMESTAMP DEFAULT NOW()
);

-- summarization details
CREATE TABLE document_summaries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    summary_text TEXT NOT NULL,
    key_points JSONB,
    model_version VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);

-- document embedding
CREATE TABLE document_embeddings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    chroma_collection_id VARCHAR(100),
    embedding_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

-- tags
CREATE TABLE document_tags (
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    tag VARCHAR(50) NOT NULL,
    tag_type VARCHAR(20) DEFAULT 'user', -- 'user' or 'auto'
    PRIMARY KEY (document_id, tag)
);

-- indexing
CREATE INDEX idx_documents_type ON document_classifications(document_type);
CREATE INDEX idx_documents_upload_date ON documents(upload_timestamp);
CREATE INDEX idx_processing_status ON document_processing(processing_status);
CREATE INDEX idx_content_search ON document_content USING gin(to_tsvector('english', searchable_content));