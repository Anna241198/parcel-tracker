# Стадия сборки
FROM golang:1.22 AS builder

# Установка рабочей директории
WORKDIR /app

# Копирование файлов зависимостей
COPY go.mod go.sum ./

# Установка зависимостей
RUN go mod download

# Копирование исходного кода
COPY . .

# Сборка приложения
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main main.go

# Финальный минималистичный образ
FROM scratch

# Копирование бинарного файла из стадии сборки
COPY --from=builder /main /main

# Команда запуска
CMD ["/main"]
