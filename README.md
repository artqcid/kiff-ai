# KIFF AI Development Workspace

Übergeordneter Workspace für die KIFF AI Entwicklung mit Backend und Frontend als Git Submodules.

## Struktur

```
kiff-ai/
├── backend/          # Submodule: kiff-ai-backend (FastAPI)
├── frontend/         # Submodule: kiff-ai-frontend (Vue 3)
├── kiff-ai.code-workspace
└── docker-compose.yml
```

## Quick Start

### 1. Repository klonen (mit Submodules)

```bash
git clone --recursive https://github.com/artqcid/kiff-ai.git
cd kiff-ai
```

Falls schon geklont, Submodules initialisieren:
```bash
git submodule update --init --recursive
```

### 2. VS Code Workspace öffnen

```bash
code kiff-ai.code-workspace
```

### 3. Development starten

**Backend:**
```bash
cd backend/api
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**Frontend:**
```bash
cd frontend
npm install
npm run dev
```

**Docker (alle Services):**
```bash
docker-compose up --build
```

## Services

- **Backend API:** http://localhost:8000
- **API Docs:** http://localhost:8000/docs
- **Frontend:** http://localhost:5173
- **Qdrant:** http://localhost:6333

## Submodules aktualisieren

```bash
# Alle Submodules auf neuesten Stand
git submodule update --remote

# Oder einzeln
cd backend
git pull origin main

cd ../frontend
git pull origin main
```

## Links

- [Backend Repository](https://github.com/artqcid/kiff-ai-backend)
- [Frontend Repository](https://github.com/artqcid/kiff-ai-frontend)

## Features

### Backend (FastAPI)
- 🚀 REST API mit OpenAPI/Swagger
- 💬 Chat mit llama.cpp
- 🔍 RAG mit Qdrant
- 🌐 MCP für Web-Kontext
- 📁 Dokumentenverwaltung

### Frontend (Vue 3)
- 🎨 Moderne SPA mit TypeScript
- 💬 Chat-Interface
- 📁 Dokument-Upload
- ⚙️ Einstellungen und Profile

## Development Workflow

### Backend-Änderungen:
```bash
cd backend
# Änderungen machen
git add .
git commit -m "Update backend"
git push

# Im kiff-ai Workspace Submodule-Pointer aktualisieren
cd ..
git add backend
git commit -m "Update backend submodule"
git push
```

### Frontend-Änderungen:
```bash
cd frontend
# Änderungen machen
git add .
git commit -m "Update frontend"
git push

# Im kiff-ai Workspace Submodule-Pointer aktualisieren
cd ..
git add frontend
git commit -m "Update frontend submodule"
git push
```

## Einzelne Workspaces

- **Backend solo:** `backend/kiff-ai-backend.code-workspace`
- **Frontend solo:** `frontend/kiff-ai-frontend.code-workspace`
- **Beide zusammen:** `kiff-ai.code-workspace`
