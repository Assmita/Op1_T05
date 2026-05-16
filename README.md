# TP05 — Docker: primera app en contenedor

## Qué contiene

API Python con framework Flask corriendo en un servidor web Gunicorn dentro de un contenedor Docker, implementando buenas prácticas de producción (imagen base ligera `slim`, entorno seguro sin usuario root y logs optimizados).

## Repositorio del Proyecto
- **GitHub:** https://github.com/Assmita/Op1_T05.git
- **Docker Hub:** https://hub.docker.com/r/djuarez88/devops-portfolio

## Endpoints

| Método | Ruta | Descripción |
|---|---|---|
| `GET` | `/` | Estado base de la API |
| `GET` | `/health` | Chequeo de salud del sistema (Uptime, hostname, entorno) |
| `GET` | `/info` | Versión de la app y metadata del autor (Damian Juarez) |

## Correr localmente

Para desplegar y probar la aplicación en tu entorno local descargándola directamente desde internet, ejecutá la siguiente secuencia en tu terminal de Bash:

```bash
# 1. Descargar y correr el contenedor desde el registro público de Docker Hub
docker run -d --name api-final -p 8080:5000 djuarez88/devops-portfolio:latest

# 2. Validar el estado de salud de la API
curl http://localhost:8080/health
