# Stage 1: Build Node.js app
FROM node:14 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Stage 2: Create final image
FROM jenkins/jenkins:lts

USER root

# Install Docker inside the Jenkins image
RUN apt-get update && \
    apt-get install -y docker.io

# Install Node.js in the Jenkins image
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

USER jenkins

# Copy only the necessary artifacts from the builder stage
COPY --from=builder /app .

# Set the working directory to /app
WORKDIR /app

# Expose port 3000 if needed

# Define environment variable if needed

# Run app.js when the container launches
CMD ["node", "app.js"]
