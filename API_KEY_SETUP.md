# API-Key Konfiguration für KIFF

## Schnellstart: Groq API-Key einrichten

### Schritt 1: API-Key besorgen

1. Gehe zu https://console.groq.com/keys
2. Erstelle einen neuen API-Key
3. Kopiere den Key (beginnt mit `gsk_...`)

### Schritt 2: `.env` Datei erstellen

Erstelle im `backend/` Ordner eine Datei namens `.env`:

```bash
cd backend
cp .env.example .env
```

Oder erstelle sie manuell mit folgendem Inhalt:

```env
GROQ_API_KEY=gsk_dein_echter_api_key_hier
LLM_SERVER_URL=http://localhost:11434
```

### Schritt 3: Server neu starten

```bash
cd backend
python -m uvicorn api.main:app --reload --port 8000
```

Der Server lädt automatisch die `.env` Datei und zeigt:

```
✅ Loaded environment variables from backend/.env
```

---

## 2. Alternativen für Server-Deployment

### Docker Compose

In `docker-compose.yml`:

```yaml
services:
  backend:
    environment:
      - GROQ_API_KEY=${GROQ_API_KEY}
```

Dann beim Start:

```bash
export GROQ_API_KEY=gsk_dein_key
docker-compose up
```

### Systemweite Umgebungsvariable (Windows)

```powershell
[System.Environment]::SetEnvironmentVariable('GROQ_API_KEY', 'gsk_dein_key', 'User')
```

### Systemweite Umgebungsvariable (Linux/Mac)

```bash
echo "export GROQ_API_KEY=gsk_dein_key" >> ~/.bashrc
source ~/.bashrc
```

---

## UI: Provider-Auswahl

Nach dem API-Key Setup:

1. **Öffne die App** → Gehe zu Settings (⚙️)
2. **Provider Section** → Wähle "Groq" (Radio-Button)
3. System testet automatisch den API-Key
4. Bei Erfolg: ✅ Provider "Groq" aktiviert
5. Bei Fehler: Überprüfe den Key in `.env`

---

## Sicherheit

⚠️ **WICHTIG:**

- `.env` Datei **NICHT** ins Git committen!
- `.env` ist bereits in `.gitignore`
- `.env.example` (ohne echten Key) kann ins Git

---

## Fehlerbehebung

### "API-Key fehlt" Badge in UI

→ `.env` Datei mit `GROQ_API_KEY` erstellen

### "Provider-Validierung fehlgeschlagen"

→ Key in `.env` überprüfen (muss mit `gsk_` beginnen)

### Server lädt .env nicht

→ Sicherstellen, dass `.env` direkt im `backend/` Ordner liegt, nicht in `backend/api/`
