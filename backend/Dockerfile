FROM golang:1.20 AS builder

WORKDIR /app

COPY ./backend .

RUN go mod download
# myapp のビルド
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o myapp .
# migrate_executable のビルド（静的リンク）
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o migrate_executable migrate/migrate.go

FROM alpine:latest  

# セキュリティアップデート
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# ビルドしたバイナリファイルをコピー
COPY --from=builder /app/myapp .
COPY --from=builder /app/migrate_executable ./migrate_executable
COPY ./backend/start.sh ./start.sh

# スクリプトとバイナリの実行を可能にする
RUN chmod +x ./start.sh ./migrate_executable

# ポート番号の指定
EXPOSE 8080

CMD ["./start.sh"]
