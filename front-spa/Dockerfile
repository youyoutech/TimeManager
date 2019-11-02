# Dockerfile for dev
FROM node:latest
EXPOSE 8080
WORKDIR /bindmount     # More on this in a bit
# Hopefully you'd never actually do this, just copy everything, including locally installed node_modules
COPY ./ ./
RUN npm install --no-progress --ignore-optional
CMD ["npm", "run", "dev"]