FROM golang:1.20 AS builder

WORKDIR /app

COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o myapp .

FROM alpine:latest  

# セキュリティアップデート
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# ビルドしたバイナリファイルをコピー
COPY --from=builder /app/myapp .

# ポート番号の指定
EXPOSE 8080

CMD ["./myapp"]
