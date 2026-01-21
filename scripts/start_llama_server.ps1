# Stop existing llama-server instances
Get-Process llama-server -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Milliseconds 300

# Build argument list for Mistral 7B Instruct
$args = @(
  "--model", "D:\AI-Models\llama\mistral\mistral-7b-instruct-v0.2.Q4_K_M.gguf",
  "--port", "8080",
  "--ctx-size", "8192",
  "--batch-size", "128",
  "--ubatch-size", "64",
  "--parallel", "1",
  "--threads", "6",
  "--n-gpu-layers", "25",
  "--cache-type-k", "q4_0",
  "--temp", "0.7",
  "--top-k", "40",
  "--top-p", "0.9",
  "--repeat-penalty", "1.1",
  "--repeat-last-n", "256",
  "--no-mmap",
  "--cache-ram", "0"
)

# Start llama-server
Start-Process `
  -FilePath "C:\llama\llama-server.exe" `
  -ArgumentList $args `
  -NoNewWindow `
  -PassThru
