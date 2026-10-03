FROM node:22-alpine

# 1. Install necessary system tools for compilation
RUN apk add --no-cache python3 make g++ 

WORKDIR /app

# 2. CRITICAL: Copy ALL project files first (including the scripts folder)
COPY . .

# 3. Run npm install now that the scripts folder physically exists in the container
RUN npm install --include=dev

# 4. Explicitly make sure the binaries pull script fires safely
RUN node scripts/install-binaries.js || true

# 5. Clean up development dependencies to keep the image small
RUN npm prune --production

CMD ["npm", "start"]
