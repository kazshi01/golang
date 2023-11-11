FROM golang:1.20 AS builder

WORKDIR /app

COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o myapp .
RUN go build -o migrate_executable migrate/migrate.go

FROM alpine:latest  

# セキュリティアップデート
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# ビルドしたバイナリファイルをコピー
COPY --from=builder /app/myapp .
COPY --from=builder /app/migrate_executable ./migrate_executable
COPY start.sh ./start.sh

# スクリプトを実行可能にする
RUN chmod +x ./start.sh

# ポート番号の指定
EXPOSE 8080

CMD ["./start.sh"]
