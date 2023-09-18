# Base image
FROM public.ecr.aws/docker/library/node:16.20.2

# Set the working directory in the container
WORKDIR /server


# Copy the requirements file to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the application code to the container
COPY . .

# Expose the port your application runs on
EXPOSE 5000

# Set the entrypoint command to run your application
CMD ["npx", "nodemon", "server"]
