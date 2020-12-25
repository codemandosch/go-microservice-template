# Build environment
FROM golang:alpine as build-env
RUN apk add --update --no-cache ca-certificates git
WORKDIR /changeme/app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

# Execution environment
FROM alpine
RUN apk add --update --no-cache ca-certificates tzdata
COPY --from=build-env /changeme/app/app /
ENTRYPOINT ["./app"]