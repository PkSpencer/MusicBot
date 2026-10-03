FROM node:22-alpine

# Install system utilities needed for compiling native audio binaries
RUN apk add --no-cache python3 make g++ 

WORKDIR /app

# 1. Copy package files and install ALL dependencies (including dev)
COPY package*.json ./
RUN npm install

# 2. Copy the entire repository into the container (this includes the scripts folder)
COPY . .

# 3. Explicitly execute the binary installer during the build phase
RUN node scripts/install-binaries.js || true

# 4. Clean up development packages to shrink the image size
RUN npm prune --production

CMD ["npm", "start"]
