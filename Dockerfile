FROM oven/bun:1-slim AS base
WORKDIR /app

COPY package.json bun.lock ./
COPY packages/*/package.json ./packages/*/package.json
RUN bun install --frozen-lockfile

COPY . .
RUN bun run build:packages
RUN bun run build

FROM oven/bun:1-slim AS runtime
WORKDIR /app
COPY --from=base /app/dist ./dist
COPY --from=base /app/node_modules ./node_modules
EXPOSE 4173
CMD ["bun", "x", "vite", "preview", "--host", "0.0.0.0", "--port", "4173"]
