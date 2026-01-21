# KIFF AI - Development Setup

## Vollständiges Setup mit Backend & Frontend

### Voraussetzungen

- Python 3.11+
- Node.js 20+
- Git (für Repository-Management)
- llama.cpp Server (läuft auf localhost:8080)
- Config-Dateien in `config/` Ordner

---

## 🚀 Quick Start

### Option 1: Automatisches Setup (Empfohlen)

**Windows (PowerShell):**

```powershell
# Einmalig: Setup ausführen
.\scripts\dev-setup.ps1

# Danach: Entwicklung starten
.\scripts\dev-start.ps1

# Stoppen
.\scripts\dev-stop.ps1
```

**Linux/Mac (Bash):**

```bash
# Einmalig: Setup ausführen
./scripts/dev-setup.sh

# Danach: Entwicklung starten
./scripts/dev-start.sh

# Stoppen
./scripts/dev-stop.sh
```

### Option 2: VS Code Tasks (Empfohlen für Entwicklung)

1. **Öffne VS Code**
2. Drücke `Ctrl+Shift+P` (oder `Cmd+Shift+P` auf Mac)
3. Tippe `Tasks: Run Task`
4. Wähle eine der Tasks:
   - `Start: Backend + Frontend` - Startet beide Services
   - `Backend: Start Development Server` - Nur Backend
   - `Frontend: Start Development Server` - Nur Frontend
   - `Install: All Dependencies` - Alle Dependencies installieren

**Keyboard Shortcuts:**

- `Ctrl+Shift+B` - Führt Build Task aus
- `F5` - Startet Debug-Session (Backend + Frontend)

### Option 3: VS Code Debugger (Für Debugging)

1. **Öffne Run & Debug Panel** (`Ctrl+Shift+D`)
2. Wähle eine Debug-Konfiguration:
   - `Full Stack: Backend + Frontend` - Debug beide zusammen
   - `Python: Backend Debug` - Nur Backend debuggen
   - `Chrome: Frontend Debug` - Nur Frontend debuggen
3. Drücke `F5` oder klicke auf "Start Debugging"

**Debug Features:**

- Breakpoints in Python & TypeScript
- Variable Inspection
- Call Stack Analysis
- Hot Reload aktiviert

---

## 🛠️ Manuelles Setup

### Backend Setup

```powershell
# Virtual Environment aktivieren
.\venv\Scripts\Activate.ps1  # Windows
source venv/bin/activate      # Linux/Mac

# Dependencies installieren
cd backend
pip install -r requirements.txt

# Backend starten
cd api
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Backend läuft auf: **http://localhost:8000**  
API Docs: **http://localhost:8000/docs**

### Frontend Setup

```powershell
# Dependencies installieren
cd frontend
npm install

# Frontend starten
npm run dev
```

Frontend läuft auf: **http://localhost:5173**

---

## 📋 Verfügbare VS Code Tasks

| Task                                 | Beschreibung                    | Shortcut |
| ------------------------------------ | ------------------------------- | -------- |
| `Start: Backend + Frontend`          | Startet beide Services zusammen | -        |
| `Backend: Start Development Server`  | Nur Backend starten             | -        |
| `Frontend: Start Development Server` | Nur Frontend starten            | -        |
| `Install: All Dependencies`          | pip + npm install               | -        |
| `Backend: Install Dependencies`      | Nur Backend Dependencies        | -        |
| `Frontend: Install Dependencies`     | Nur Frontend Dependencies       | -        |
| `Docker: Start All Services`         | Docker Compose starten          | -        |
| `Docker: Stop All Services`          | Docker Compose stoppen          | -        |
| `Backend: Run Tests`                 | Backend Tests ausführen         | -        |
| `Frontend: Run Tests`                | Frontend Tests ausführen        | -        |
| `Frontend: Build Production`         | Production Build                | -        |
| `Backend: Format Code`               | Black + isort                   | -        |
| `Backend: Lint Code`                 | Pylint check                    | -        |

**Task ausführen:**

1. `Ctrl+Shift+P` → `Tasks: Run Task`
2. Task auswählen
3. Enter drücken

---

## 🐛 Debugging Konfigurationen

| Konfiguration                    | Beschreibung                      | Port       |
| -------------------------------- | --------------------------------- | ---------- |
| `Full Stack: Backend + Frontend` | Debug beide Services gleichzeitig | 8000, 5173 |
| `Python: Backend Debug`          | Backend mit debugpy               | 8000       |
| `Chrome: Frontend Debug`         | Frontend mit Chrome DevTools      | 5173       |
| `Edge: Frontend Debug`           | Frontend mit Edge DevTools        | 5173       |
| `Python: FastAPI Tests`          | Debug Tests mit pytest            | -          |
| `Python: Current File`           | Debug aktuelle Python-Datei       | -          |

**Debug starten:**

1. Öffne Run & Debug Panel (`Ctrl+Shift+D`)
2. Wähle Konfiguration aus Dropdown
3. Drücke `F5` oder klicke "Start Debugging"

**Breakpoints setzen:**

- **Python:** Klicke links neben Zeile im `.py` File
- **TypeScript/Vue:** Klicke links neben Zeile im `.ts` oder `.vue` File
- **Conditional Breakpoints:** Rechtsklick auf Breakpoint → "Edit Breakpoint"

---

## 🎯 Feature-Übersicht

### ✅ Backend (FastAPI)

- Server Management (llama.cpp & MCP starten/stoppen)
- ProfileAgent mit Multi-Profilen
- ModelRegistry für Modell-Wechsel
- Chat mit History-Persistence
- Dokument-Upload/Management
- Health & Status Checks
- OpenAPI/Swagger Dokumentation

### ✅ Frontend (Vue 3)

- Chat-UI mit History, Repeat, Cancel
- Server-Management UI
- Modell-Wechsel UI
- Profil-Wechsel UI
- Dokument-Browser
- Live-Status-Anzeige
- Responsive Design

---

## 🔄 Workflow

### Erste Schritte

1. **Setup ausführen:** `.\scripts\dev-setup.ps1` (Windows) oder `./scripts/dev-setup.sh` (Linux/Mac)
2. **Services starten:** `.\scripts\dev-start.ps1` oder via VS Code Task `Start: Backend + Frontend`
3. **Frontend öffnen:** http://localhost:5173
4. **Settings öffnen:** Server starten (llama.cpp + MCP)
5. **Chat verwenden:** Zurück zu Chat-View und mit Agent chatten

### Entwicklungs-Workflow

1. **Code ändern** → Hot Reload aktiviert (Backend + Frontend)
2. **Breakpoint setzen** → F5 drücken → Debuggen
3. **Tests schreiben** → Task `Backend: Run Tests` oder `Frontend: Run Tests`
4. **Code formatieren** → Task `Backend: Format Code` (automatisch bei Save)
5. **Production Build** → Task `Frontend: Build Production`

---

## ⚙️ Konfiguration

### Erforderliche Config-Dateien (in `config/`)

**models_kiff.json** - Modell-Konfiguration

```json
{
  "models": {
    "mistral-7b": {
      "model_path": "path/to/model.gguf",
      "gpu_layers": 20,
      "context_size": 8192,
      "description": "Mistral 7B Instruct",
      "is_default": true
    }
  }
}
```

**profiles_kiff.json** - Agent-Profile

```json
{
  "default": {
    "name": "Standard Assistant",
    "system_prompt": "Du bist ein hilfreicher Assistent.",
    "description": "General assistant"
  }
}
```

**servers_kiff.json** - (veraltet) frühere llama.cpp-Start-Konfig; wird mit Ollama nicht mehr genutzt.

### Verzeichnisstruktur

```
kiff-ai/
├── .vscode/              # VS Code Konfiguration
│   ├── tasks.json        # Build & Run Tasks
│   ├── launch.json       # Debug-Konfigurationen
│   ├── settings.json     # Editor-Einstellungen
│   └── extensions.json   # Empfohlene Extensions
├── backend/              # FastAPI Backend
├── frontend/             # Vue 3 Frontend
├── config/               # JSON Konfigurationen
├── documents/            # Upload/Output Dokumente
├── scripts/              # Startup Scripts
│   ├── dev-setup.ps1     # Setup (Windows)
│   ├── dev-start.ps1     # Start (Windows)
│   ├── dev-stop.ps1      # Stop (Windows)
│   ├── dev-setup.sh      # Setup (Linux/Mac)
│   ├── dev-start.sh      # Start (Linux/Mac)
│   └── dev-stop.sh       # Stop (Linux/Mac)
└── venv/                 # Python Virtual Environment
```

---

## 🐛 Troubleshooting

### Backend startet nicht

- ✅ Prüfe Python Version: `python --version` (muss 3.11+ sein)
- ✅ Virtual Environment aktiviert? Siehe `(venv)` im Terminal
- ✅ Dependencies installiert? `pip list` → FastAPI, Uvicorn sichtbar?
- ✅ Port 8000 frei? PowerShell: `Get-NetTCPConnection -LocalPort 8000`
- ✅ Health Check: http://localhost:8000/health

### Frontend startet nicht

- ✅ Node.js Version: `node --version` (muss 20+ sein)
- ✅ Dependencies installiert? `cd frontend && npm install`
- ✅ Port 5173 frei? PowerShell: `Get-NetTCPConnection -LocalPort 5173`
- ✅ Vite läuft? Siehe Terminal-Output für Fehler

### Server-Start in UI funktioniert nicht

- ✅ Docker Compose läuft? (Ollama-Service muss erreichbar sein)
- ✅ Port 11434 frei? (Ollama)
- ✅ Backend-Logs prüfen (Terminal mit Backend)

### Chat funktioniert nicht

- ✅ Backend läuft? http://localhost:8000/health
- ✅ Ollama läuft? http://localhost:11434/api/tags
- ✅ Status in Settings-View prüfen
- ✅ Browser Console öffnen (F12) → Fehler sichtbar?
- ✅ Network Tab prüfen → API Calls erfolgreich?

### Debug Session startet nicht

- ✅ Extension installiert? `ms-python.python` für Python, `msjsdiag.debugger-for-chrome` für Frontend
- ✅ Task läuft bereits? Stoppe mit `.\scripts\dev-stop.ps1`
- ✅ VS Code neu laden: `Ctrl+Shift+P` → "Developer: Reload Window"

### Port bereits belegt

**Lösung 1: Services stoppen**

```powershell
# Windows
.\scripts\dev-stop.ps1

# Linux/Mac
./scripts/dev-stop.sh
```

**Lösung 2: Prozess manuell killen**

```powershell
# Windows - Port 8000
Get-NetTCPConnection -LocalPort 8000 | ForEach-Object { Stop-Process -Id $_.OwningProcess -Force }

# Linux/Mac - Port 8000
lsof -ti:8000 | xargs kill -9
```

---

## 📚 Weitere Dokumentation

- **Backend API:** http://localhost:8000/docs (Swagger UI)
- **Backend README:** [backend/README.md](backend/README.md)
- **Frontend README:** [frontend/README.md](frontend/README.md)
- **Migration Docs:** [MIGRATION_COMPLETE.md](MIGRATION_COMPLETE.md)
- **Implementation:** [IMPLEMENTATION_COMPLETE.md](IMPLEMENTATION_COMPLETE.md)

---

## 🎓 Keyboard Shortcuts Cheatsheet

| Shortcut        | Aktion                            |
| --------------- | --------------------------------- |
| `Ctrl+Shift+P`  | Command Palette (Tasks, Commands) |
| `Ctrl+Shift+B`  | Run Build Task                    |
| `F5`            | Start Debugging                   |
| `Shift+F5`      | Stop Debugging                    |
| `Ctrl+Shift+D`  | Open Debug Panel                  |
| `Ctrl+Shift+E`  | Open Explorer                     |
| `Ctrl+` `       | Toggle Terminal                   |
| `Ctrl+K Ctrl+T` | Change Theme                      |
| `Ctrl+,`        | Open Settings                     |

---

## ⚡ Empfohlene VS Code Extensions

Die folgenden Extensions werden automatisch empfohlen, wenn du das Projekt öffnest:

**Python Development:**

- Python (ms-python.python)
- Pylance (ms-python.vscode-pylance)
- Black Formatter (ms-python.black-formatter)

**Frontend Development:**

- Volar (Vue.volar) - Vue 3 Support
- TypeScript Vue Plugin (Vue.vscode-typescript-vue-plugin)
- ESLint (dbaeumer.vscode-eslint)

**Debugging:**

- Debugger for Chrome (msjsdiag.debugger-for-chrome)
- Edge DevTools (ms-edgedevtools.vscode-edge-devtools)

**Utilities:**

- Docker (ms-azuretools.vscode-docker)
- GitLens (eamodio.gitlens)
- Error Lens (usernamehw.errorlens)
- Todo Tree (gruntfuggly.todo-tree)

Installiere alle empfohlenen Extensions für das beste Entwicklungserlebnis!
Die folgenden Extensions werden automatisch empfohlen, wenn du das Projekt öffnest:

**Python Development:**

- Python (ms-python.python)
- Pylance (ms-python.vscode-pylance)
- Black Formatter (ms-python.black-formatter)

**Frontend Development:**

- Volar (Vue.volar) - Vue 3 Support
- TypeScript Vue Plugin (Vue.vscode-typescript-vue-plugin)
- ESLint (dbaeumer.vscode-eslint)

**Debugging:**

- Debugger for Chrome (msjsdiag.debugger-for-chrome)
- Edge DevTools (ms-edgedevtools.vscode-edge-devtools)

**Utilities:**

- Docker (ms-azuretools.vscode-docker)
- GitLens (eamodio.gitlens)
- Error Lens (usernamehw.errorlens)
- Todo Tree (gruntfuggly.todo-tree)

Installiere alle empfohlenen Extensions für das beste Entwicklungserlebnis!
