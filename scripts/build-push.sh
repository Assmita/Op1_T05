#!/bin/bash

# ============================================
# build-push.sh — Build y push a Docker Hub
# TP 5 — Plan DevOps - Zurdo (Corregido)
# ============================================

set -euo pipefail

DOCKER_USER="${DOCKER_USER:-djuarez88}"
IMAGE_NAME="devops-portfolio"
TAG="${1:-1.0}"
FULL_TAG="$DOCKER_USER/$IMAGE_NAME:$TAG"

# Corregimos las rutas basados en tu estructura real
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOCKERFILE_PATH="$ROOT_DIR/Dockerfile"

log() { echo "[$(date '+%H:%M:%S')] $1"; }

log "=== Build: $FULL_TAG ==="
# Usamos el flag -f para apuntar al Dockerfile en la raíz, usando la raíz como contexto
docker build -f "$DOCKERFILE_PATH" -t "$FULL_TAG" -t "$DOCKER_USER/$IMAGE_NAME:latest" "$ROOT_DIR"

log "=== Verificando imagen ==="
docker images "$DOCKER_USER/$IMAGE_NAME"

log "=== Test rápido del contenedor ==="
docker run --rm -d --name test-ci -p 9999:5000 "$FULL_TAG"
sleep 3

# Usamos el endpoint /info que sabemos que responde un HTTP 200 directo
STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9999/info)

if [ "$STATUS" = "200" ]; then
    log "Health check: OK (HTTP $STATUS)"
else
    log "Health check: FALLO (HTTP $STATUS)"
    docker stop test-ci
    exit 1
fi

docker stop test-ci
log "Contenedor de test eliminado"

log "=== Push a Docker Hub ==="
log "Ejecutá: docker login && bash $0 $TAG"
# docker push "$FULL_TAG"
# docker push "$DOCKER_USER/$IMAGE_NAME:latest"

log "=== Listo: $FULL_TAG ==="
