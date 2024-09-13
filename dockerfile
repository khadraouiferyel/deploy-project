# Utiliser une image Node.js comme base
FROM node:18 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de package et installer les dépendances
COPY package*.json ./
RUN npm install

# Copier le reste des fichiers du projet
COPY . .

# Construire l'application Angular
RUN npm run build

# Utiliser une image Nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers construits dans le répertoire Nginx
COPY --from=build /app/dist/deploy /usr/share/nginx/html

# Exposer le port utilisé par Nginx
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
