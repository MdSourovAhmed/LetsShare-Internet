FROM node:22-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY package.json package-lock.json* ./
RUN npm install 

COPY --chown=appuser:appgroup ./dist ./dist
COPY --chown=appuser:appgroup ./server.js ./

USER appuser

EXPOSE 5000

#HEALTHCHECK --interval=15s --timeout=5s --retries=3 \
# CMD wget -qO- http://localhost:5000/health || exit 1

CMD ["npm", "run", "dev"]
