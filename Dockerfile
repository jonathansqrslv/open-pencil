FROM oven/bun:1-slim
WORKDIR /app
COPY . .
RUN bun install --frozen-lockfile
RUN bun run build:packages
RUN bun run build
EXPOSE 4173
CMD ["bun", "x", "vite", "preview", "--host", "0.0.0.0", "--port", "4173"]
