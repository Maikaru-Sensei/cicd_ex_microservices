FROM golang:1.20-alpine

# Set maintainer label: maintainer=[YOUR-EMAIL]
LABEL maintainer="mi.zauner@proton.me"

# Set working directory: `/src`
WORKDIR /src

# Copy local file `main.go` to the working directory
COPY *.go /src

# Copy go.mod and go.sum files to the working directory
COPY go.mod ./
RUN go mod download

# List items in the working directory (ls)
RUN ls

# Build the GO app as myapp binary and move it to /usr/
RUN cd /src
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp
RUN mv myapp /usr/

#Expose port 8888
EXPOSE 8080

# Run the service myapp when a container of this image is launched
CMD ["/usr/myapp"]