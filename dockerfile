# Stage 1: Build the custom k6 binary with xk6
FROM golang:1.24.4-alpine AS builder
# Install necessary packages
RUN apk add --no-cache make gcc musl-dev
RUN apk update && apk add git
WORKDIR /build

# Install xk6 and build k6 with desired extensions
RUN go install go.k6.io/xk6/cmd/xk6@latest
RUN xk6 build --with github.com/LeonAdato/xk6-output-statsd

# Stage 2: Create the final k6 image with the custom binary
FROM alpine:latest
WORKDIR /home/k6
COPY --from=builder /build/k6 .
ENTRYPOINT ["./k6"]

# Build the image
# docker build -t my-xk6-app .

# Run the container
# docker run -it --rm -v "$(pwd):/app" my-xk6-app run --out output-statsd /app/script.js
