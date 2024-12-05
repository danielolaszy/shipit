# Step 1: Use Go base image for building the app
FROM golang:1.22-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files to the container
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the entire project into the current working directory (/app)
COPY . .

# Step 2: Build the Go application
RUN go build -o shipit ./cmd/shipit

# Step 3: Create a smaller image for running the app (using Alpine for minimal size)
FROM alpine:latest

# Install necessary CA certificates (to make HTTPS requests)
RUN apk --no-cache add ca-certificates

# Set the working directory for the app
WORKDIR /root/

# Copy the built Go binary from the builder image
COPY --from=builder /app/shipit .

# Expose the port the app will run on
EXPOSE 8080

# Define the default command to run the Go app
CMD ["./shipit"]
