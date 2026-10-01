# قمر الزمان

Monorepo لمتجر مستحضرات التجميل «قمر الزمان».

## Projects

| Directory | Description |
|-----------|-------------|
| `backend/` | NestJS API (PostgreSQL, Prisma) |
| `admin-desktop/` | Admin panel — web (static) + Electron desktop (Next.js) |
| `pos-sync-desktop/` | Electron POS sync (SQL Server → VPS) |
| `infra/` | Docker Compose, Nginx, deployment scripts — **HTTP :3200** |
| `mobile-app/` | Flutter customer app — `com.qamaralzaman.app` |
| `docs/` | Project documentation |

## Quick start

- Mobile API default: `http://187.127.88.146:3200/api/v1`
- Deploy IP mode: `infra/scripts/deploy-ip.sh`
- See `backend/README.md` and `infra/DEPLOY.md`.

**Isolation:** this stack uses Docker project `qamar`, host port **3200**, DB `qamar`, and does not run certbot or Miswag watch bots (so it can sit beside the base store on the same VPS).
