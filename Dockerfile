FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM golang:1.22-alpine AS web-build

WORKDIR /src

COPY go.mod ./
COPY cmd/web ./cmd/web
RUN go build -ldflags="-s -w" -o /out/christian-songbook-web ./cmd/web

FROM alpine:3.20

RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

COPY --from=web-build /out/christian-songbook-web /usr/local/bin/christian-songbook-web
COPY --from=build /app/dist ./dist

ENV HTTP_ADDR=:8080
ENV STATIC_DIR=/app/dist

EXPOSE 8080
USER app
CMD ["christian-songbook-web"]
