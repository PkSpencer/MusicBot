# Use the stable Node.js runtime environment
FROM node:22-alpine

# Set the internal folder to exactly /app
WORKDIR /app

# Copy dependency files first to utilize Docker layer caching
COPY package*.json ./

# Install only production dependencies (keeps the image lightweight)
RUN npm ci --only=production

# Copy the rest of the MusicBot files into /app
COPY . .

# Start the application
CMD ["npm", "start"]