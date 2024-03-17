FROM plugfest:no-mvn

# Relative Project Path
ARG project_path

# Copy Source Code
COPY ${project_path} /code
RUN mkdir /out

# Install trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.49.1

# Generate SBOM
CMD ["trivy", "fs", "--format", "cyclonedx", "--output", "/out/trivy-sbom.json", "/code"]
# docker run --rm --mount type=bind,source=out,target=/out -it test