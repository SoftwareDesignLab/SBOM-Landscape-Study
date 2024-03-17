# NOTE: Maven not required, but needed for transient dependencies
FROM plugfest:mvn

# Relative Project Path
ARG project_path

# Copy Source Code
COPY ${project_path} /code
RUN mkdir /out

# Install cdxgen
RUN . "$NVM_DIR"/nvm.sh && npm install -g @cyclonedx/cdxgen

# Generate SBOM
WORKDIR /code
CMD ["cdxgen", "-o", "/out/cdxgen-sbom.json"]
# docker run --rm --mount type=bind,source=out,target=/out -it test