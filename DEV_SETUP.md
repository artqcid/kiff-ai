# KIFF AI - Development Setup

## Vollständiges Setup mit Backend & Frontend

### Voraussetzungen

- Python 3.11+
- Node.js 20+
- llama.cpp Server (läuft auf localhost:8080)
- Config-Dateien in `config/` Ordner

### Backend Setup

```powershell
# In langchain/backend/
cd backend

# Virtual Environment aktivieren (falls nicht schon aktiv)
..\venv\Scripts\Activate.ps1

# Dependencies installieren
pip install -r requirements.txt

# Backend starten
cd api
python main.py
```

Backend läuft auf: **http://localhost:8000**  
API Docs: **http://localhost:8000/docs**

### Frontend Setup

```powershell
# In langchain/frontend/
cd frontend

# Dependencies installieren (nur einmal)
npm install

# Frontend starten
npm run dev
```

Frontend läuft auf: **http://localhost:5173**

### Beide Services starten

Öffne 2 PowerShell-Terminals:

**Terminal 1 - Backend:**
```powershell
cd C:\Users\marku\Documents\GitHub\artqcid\ai-projects\langchain\backend\api
..\venv\Scripts\Activate.ps1
python main.py
```

**Terminal 2 - Frontend:**
```powershell
cd C:\Users\marku\Documents\GitHub\artqcid\ai-projects\langchain\frontend
npm run dev
```

### Feature-Übersicht

✅ **Backend (FastAPI)**
- Server Management (llama.cpp & MCP starten/stoppen)
- ProfileAgent mit Multi-Profilen
- ModelRegistry für Modell-Wechsel
- Chat mit History-Persistence
- Dokument-Upload/Management
- Health & Status Checks

✅ **Frontend (Vue 3)**
- Chat-UI mit History, Repeat, Cancel
- Server-Management UI
- Modell-Wechsel UI
- Profil-Wechsel UI
- Dokument-Browser
- Live-Status-Anzeige

### Workflow

1. **Backend starten** → API läuft auf :8000
2. **Frontend starten** → UI läuft auf :5173
3. **Frontend öffnen** → http://localhost:5173
4. **Zu Settings** → Server starten (llama.cpp + MCP)
5. **Zurück zu Chat** → Mit Agent chatten

### Hinweise

- **llama.cpp** muss separat gestartet werden (oder über Settings-UI)
- **MCP Server** ist optional
- **Config-Dateien** müssen in `config/` vorhanden sein:
  - `models_kiff.json` - Modell-Konfiguration
  - `profiles_kiff.json` - Agent-Profile
  - `servers_kiff.json` - Server-Config
- **Dokumente** werden in `documents/input` und `documents/output` gespeichert
- **Chat-History** wird in `documents/chat_history.json` persistiert

### Troubleshooting

**Backend startet nicht:**
- Prüfe ob Python 3.11+ installiert ist
- Prüfe ob alle Dependencies installiert sind: `pip list`
- Prüfe ob Port 8000 frei ist

**Frontend startet nicht:**
- Prüfe ob Node.js 20+ installiert ist: `node --version`
- Installiere Dependencies: `npm install`
- Prüfe ob Port 5173 frei ist

**Server-Start in UI funktioniert nicht:**
- Prüfe ob Scripts in `scripts/` vorhanden sind:
  - `start_llama_server.ps1`
  - `start_mcp_server.ps1`
- Prüfe ob llama.cpp Binaries vorhanden sind
- Prüfe Config-Dateien

**Chat funktioniert nicht:**
- Prüfe ob Backend läuft (http://localhost:8000/health)
- Prüfe ob llama.cpp Server läuft
- Prüfe Status in Settings-View
