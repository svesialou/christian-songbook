FROM golang:1.22-alpine AS build

WORKDIR /app

COPY backend/go.mod backend/go.sum ./
COPY backend/cmd ./cmd

RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/christian-songbook-api ./cmd/api

FROM alpine:3.20

COPY --from=build /bin/christian-songbook-api /usr/local/bin/christian-songbook-api

EXPOSE 8082

CMD ["christian-songbook-api"]
